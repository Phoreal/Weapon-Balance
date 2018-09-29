//=============================================================================
// KFWeap_MedicBase
//=============================================================================
// Base class for medic weapons that shoot healing darts and can lock on
//=============================================================================
// Killing Floor 2
// Copyright (C) 2015 Tripwire Interactive LLC
//=============================================================================

class PhoWeap_MedicBase extends KFWeapon
	abstract;

/*********************************************************************************************
 * @name Healing Darts
 ********************************************************************************************* */
/** DamageTypes for Instant Hit Weapons */
var	class<DamageType>   HealingDartDamageType;

/** How much to heal for when using this weapon */
var(Healing) int		HealAmount;

/** How many points of heal ammo to recharge per second */
var(Healing) float      HealFullRechargeSeconds;

/** Keeps track of incremental healing since we have to heal in whole integers */
var          float      HealingIncrement;

/** How many points of heal ammo to recharge per second. Calculated from the HealFullRechargeSeconds */
var          float      HealRechargePerSecond;

/** The sound of the healing dart hitting someone they will heal */
var AKEvent	HealImpactSoundPlayEvent;

/** The sound of the healing dart hitting someone they will hurt */
var AKEvent	HurtImpactSoundPlayEvent;

/** Sound to play when the weapon is fired */
var(Sounds)	WeaponFireSndInfo DartFireSnd;

const ShootDartAnim		= 'Shoot_Dart';
const ShootDartIronAnim	= 'Shoot_Iron_Dart';

/** How long after we shoot a healing dart before a zed can grab us.
  * Prevents us from missing healing shots from being grabbed */
var(Weapon) float   HealDartShotWeakZedGrabCooldown;

/** Recoil override for healing dart alt-fire */
var(Recoil)	int		DartMaxRecoilPitch;
var(Recoil)	int 	DartMinRecoilPitch;
var(Recoil)	int		DartMaxRecoilYaw;
var(Recoil)	int		DartMinRecoilYaw;

/** Controller rumble override for healing dart. */
var ForceFeedbackWaveform HealingDartWaveForm;

var repnotify byte HealingDartAmmo;

/*********************************************************************************************
 * @name Weapon lock on support
 ********************************************************************************************* */

/** The frequency with which we will check for a lock */
var(Locking) float		LockCheckTime;

/** How far out should we be considering actors for a lock */
var(Locking) float		LockRange;

/** How long does the player need to target an actor to lock on to it*/
var(Locking) float		LockAcquireTime;

/** Once locked, how long can the player go without painting the object before they lose the lock */
var(Locking) float		LockTolerance;

/** When true, this weapon is locked on target */
var bool         		bLockedOnTarget;

/** What "target" is this weapon locked on to */
var repnotify Actor 	LockedTarget;

/** What "target" is current pending to be locked on to */
var repnotify Actor		PendingLockedTarget;

/** angle for locking for lock targets */
var(Locking) float 		LockAim;

/** Sound Effects to play when Locking */
var AkBaseSoundObject   LockAcquiredSoundFirstPerson;
var AkBaseSoundObject   LockTargetingStopEvent;
var AkBaseSoundObject   LockTargetingStopEventFirstPerson;
var AkBaseSoundObject   LockLostSoundFirstPerson;
var AkBaseSoundObject   LockTargetingSoundFirstPerson;

/** If true, weapon will try to lock onto targets */
var bool bTargetLockingActive;

/** How much time is left before pending lock-on can be acquired */
var float PendingLockAcquireTimeLeft;
/** How much time is left before pending lock-on is lost */
var float PendingLockTimeout;
/** How much time is left before lock-on is lost */
var float LockedOnTimeout;

/*********************************************************************************************
 @name Optics UI
********************************************************************************************* */

var class<KFGFxWorld_MedicOptics> OpticsUIClass;
var KFGFxWorld_MedicOptics OpticsUI;

/** The last updated value for our ammo - Used to know when to update our optics ammo */
var byte StoredPrimaryAmmo;
var byte StoredSecondaryAmmo;

replication
{
	// Server->Client properties
	if (bNetDirty && Role == ROLE_Authority)
		bLockedOnTarget, LockedTarget, PendingLockedTarget, HealingDartAmmo;
}

/* epic ===============================================
* ::ReplicatedEvent
*
* Called when a variable with the property flag "RepNotify" is replicated
*
* =====================================================
*/
simulated event ReplicatedEvent(name VarName)
{
	if (VarName == nameof(LockedTarget))
	{
		// Clear the lock if we lost our LockedTarget and don't have a new PendingLockedTarget
		if( OpticsUI != none )
		{
			if (LockedTarget == none && PendingLockedTarget == none)
			{
				OpticsUI.ClearLockOn();
			}
			else if (LockedTarget != none)
			{
				OpticsUI.LockedOn();
			}
		}
	}
	else if (VarName == nameof(PendingLockedTarget))
	{
		// Clear the lock if we lost our LockedTarget and don't have a new PendingLockedTarget
		if( OpticsUI != none )
		{
			if (PendingLockedTarget == none && LockedTarget == none)
			{
				OpticsUI.ClearLockOn();
			}
			else if (PendingLockedTarget != none)
			{
				OpticsUI.StartLockOn();
			}
		}
	}
	else
	{
		Super.ReplicatedEvent(VarName);

		// This same variable has a replicated event in a base class, so it is not on the normal path.
		if (VarName == nameof(HealingDartAmmo))
		{
			AmmoCount[1] = HealingDartAmmo;
		}
	}
}

/*********************************************************************************************
 @name Actor
********************************************************************************************* */

/**
  * Check target locking - server-side only
  * HealAmmo Regen client and server
  */
simulated event Tick( FLOAT DeltaTime )
{
	// If we're not fully charged tick the HealAmmoRegen system
    if( AmmoCount[ALTFIRE_FIREMODE] < MagazineCapacity[ALTFIRE_FIREMODE] )
	{
        HealAmmoRegeneration(DeltaTime);
	}

	if (Instigator != none && Instigator.weapon == self)
	{
		UpdateOpticsUI();
	}

	Super.Tick(DeltaTime);
}

/*********************************************************************************************
 @name Firing / Projectile
********************************************************************************************* */

/** Instead of switch fire mode use as immediate alt fire */
simulated function AltFireMode()
{
	if ( !Instigator.IsLocallyControlled() )
	{
		return;
	}

	// StartFire - StopFire called from KFPlayerInput
	StartFire(ALTFIRE_FIREMODE);
}

/** @see KFWeapon::ConsumeAmmo */
simulated function ConsumeAmmo( byte FireModeNum )
{
    // If its not the healing fire mode, return
    if( FireModeNum != ALTFIRE_FIREMODE )
    {
        Super.ConsumeAmmo(FireModeNum);
        return;
    }

`if(`notdefined(ShippingPC))
    if( bInfiniteAmmo )
    {
        return;
    }
`endif

	// If AmmoCount is being replicated, don't allow the client to modify it here
	if ( Role == ROLE_Authority )
	{
        // Don't consume ammo if magazine size is 0 (infinite ammo with no reload)
		if (MagazineCapacity[1] > 0 && AmmoCount[1] > 0)
		{
			// Reduce ammo amount by heal ammo cost
            AmmoCount[1] = Max(AmmoCount[1] - AmmoCost[1], 0);
            HealingDartAmmo = Max(HealingDartAmmo - AmmoCost[1], 0);
		}
	}
}

/**
 * See Pawn.ProcessInstantHit
 * @param DamageReduction: Custom KF parameter to handle penetration damage reduction
 */
simulated function ProcessInstantHitEx( byte FiringMode, ImpactInfo Impact, optional int NumHits, optional out float out_PenetrationVal, optional int ImpactNum )
{
    local KFPawn HealTarget;
    local KFPlayerController Healer;
	local KFPerk InstigatorPerk;
	local float AdjustedHealAmount;

    HealTarget = KFPawn(Impact.HitActor);
    Healer = KFPlayerController(Instigator.Controller);

	InstigatorPerk = GetPerk();
	if( InstigatorPerk != none )
	{
		InstigatorPerk.UpdatePerkHeadShots( Impact, InstantHitDamageTypes[FiringMode], ImpactNum );
	}

	if (FiringMode == ALTFIRE_FIREMODE && HealTarget != none && WorldInfo.GRI.OnSameTeam(Instigator,HealTarget) )
	{
        // Let the accuracy system know that we hit someone
		if( Healer != none )
		{
            Healer.AddShotsHit(1);
		}

		AdjustedHealAmount = HealAmount * static.GetUpgradeHealMod(CurrentWeaponUpgradeIndex);
    	HealTarget.HealDamage(AdjustedHealAmount, Instigator.Controller, HealingDartDamageType);

        // Play a healed impact sound for the healee
        if( HealImpactSoundPlayEvent != None && HealTarget != None && !bSuppressSounds  )
    	{
    	    HealTarget.PlaySoundBase(HealImpactSoundPlayEvent, false, false,,Impact.HitLocation);
    	}
	}
	else
	{
        // Play a hurt impact sound for the hurt
        if( HurtImpactSoundPlayEvent != None && HealTarget != None && !bSuppressSounds  )
    	{
    	    HealTarget.PlaySoundBase(HurtImpactSoundPlayEvent, false, false,,Impact.HitLocation);
    	}
        Super.ProcessInstantHitEx(FiringMode, Impact, NumHits, out_PenetrationVal);
	}
}

/** Spawn projectile is called once for each shot pellet fired */
simulated function KFProjectile SpawnProjectile( class<KFProjectile> KFProjClass, vector RealStartLoc, vector AimDir )
{
    local KFProjectile SpawnedProjectile;

	SpawnedProjectile = Super.SpawnProjectile(KFProjClass, RealStartLoc, AimDir);

    if (bLockedOnTarget && PhoProj_HealingDart(SpawnedProjectile) != None)
	{
		PhoProj_HealingDart(SpawnedProjectile).SeekTarget = LockedTarget;
	}

	return SpawnedProjectile;
}

/**
* Called on the client when the weapon is fired calculate the recoil parameters
* Network: LocalPlayer
*/
simulated event HandleRecoil()
{
	// Separate recoil settings for healing darts. Doesn't update RecoilRate
	// or BlendOutRate, but that could be problematic if currently recoiling.
	if ( CurrentFireMode == ALTFIRE_FIREMODE )
	{
		minRecoilPitch = DartMinRecoilPitch;
		maxRecoilPitch = DartMaxRecoilPitch;
		minRecoilYaw = DartMinRecoilYaw;
		maxRecoilYaw = DartMaxRecoilYaw;
	}
	else
	{
		minRecoilPitch = default.minRecoilPitch;
		maxRecoilPitch = default.maxRecoilPitch;
		minRecoilYaw = default.minRecoilYaw;
		maxRecoilYaw = default.maxRecoilYaw;
	}

	Super.HandleRecoil();
}

/** plays view shake on the owning client only */
simulated function ShakeView()
{
	// All healing darts use the same force feedback wave form
	if ( CurrentFireMode == ALTFIRE_FIREMODE )
	{
		WeaponFireWaveForm = HealingDartWaveForm;
	}
	else
	{
		WeaponFireWaveForm = default.WeaponFireWaveForm;
	}

	Super.ShakeView();
}

/*********************************************************************************************
 * State WeaponSingleFiring
 * Fire must be released between every shot.
 *********************************************************************************************/

simulated state WeaponSingleFiring 
{
	/** Handle ClearPendingFire */
	simulated function FireAmmunition()
    {
        if(CurrentFireMode == ALTFIRE_FIREMODE)
        {
            // Don't let a weak zed grab us when we just shot a healing dart
            SetWeakZedGrabCooldownOnPawn(HealDartShotWeakZedGrabCooldown);
            StartHealRecharge();


        }
	        // Let the accuracy tracking system know that we fired
    HandleWeaponShotTaken( CurrentFireMode );

	// Handle the different fire types
	switch( WeaponFireTypes[CurrentFireMode] )
	{
		case EWFT_InstantHit:
            // Launch a projectile if we are in zed time, and this weapon has a projectile to launch for this mode
            if( `IsInZedTime(self) && WeaponProjectiles[CurrentFireMode] != none )
            {
                ProjectileFire();
            }
            else
            {
                InstantFireClient();
            }
			break;

		case EWFT_Projectile:
                
           	if (bUsingSights && CurrentFireMode == ALTFIRE_FIREMODE && !`IsInZedTime(self) && !bLockedOnTarget )
		    {
		       	InstantFireClient();
		    }
		    else
		    {
		    	ProjectileFire();
		    }    
			break;

		case EWFT_Custom:
			CustomFire();
			break;
	}

	// Decrement Ammo.  Called after Fire() for weapons that can fire a variable ammo amount (e.g. nail shotgun)
	ConsumeAmmo( CurrentFireMode );

	NotifyWeaponFired( CurrentFireMode );

	// Play fire effects now (don't wait for WeaponFired to replicate)
	PlayFireEffects(CurrentFireMode, vect(0,0,0));

	
	ClearPendingFire(CurrentFireMode);

      
	}
}

// This makes it impossible for the server to fire before the fire animation has the chance to play on the client side.
simulated function StartFire(byte FireModeNum)
{
	if(FireModeNum == ALTFIRE_FIREMODE && !HasAmmo(FireModeNum, AmmoCost[1]))
	{
		return;
	}

	Super.StartFire(FireModeNum);
}

/*********************************************************************************************
 @name Reload / recharge
********************************************************************************************* */

/** Overridden to call StartHealRecharge on server */
function GivenTo( Pawn thisPawn, optional bool bDoNotActivate )
{
	super.GivenTo( thisPawn, bDoNotActivate );

	// StartHealRecharge gets called on the client from ClientWeaponSet (called from ClientGivenTo, called from GivenTo),
	// but we also need this called on the server for remote clients, since the server needs to track the ammo too (to know if/when to spawn projectiles)

	if( Role == ROLE_Authority && !thisPawn.IsLocallyControlled() )
	{
		StartHealRecharge();
	}
}

/** Start the heal recharge cycle */
function StartHealRecharge()
{
	local KFPerk InstigatorPerk;
	local float UsedHealRechargeTime;

	// begin ammo recharge on server
	if( Role == ROLE_Authority )
	{
		InstigatorPerk = GetPerk();
		UsedHealRechargeTime = HealFullRechargeSeconds * static.GetUpgradeHealRechargeMod(CurrentWeaponUpgradeIndex);

        InstigatorPerk.ModifyHealerRechargeTime( UsedHealRechargeTime );
		// Set the healing recharge rate whenever we start charging
        HealRechargePerSecond = MagazineCapacity[ALTFIRE_FIREMODE] / UsedHealRechargeTime;
		HealingIncrement = 0;
	}
}

/** Heal Ammo Regen */
function HealAmmoRegeneration(float DeltaTime)
{
	if( Role == ROLE_Authority )
	{
		HealingIncrement += HealRechargePerSecond * DeltaTime;

		if( HealingDartAmmo > AmmoCount[ALTFIRE_FIREMODE] )
		{
			HealingDartAmmo = AmmoCount[ALTFIRE_FIREMODE];
		}

		if( HealingIncrement >= 1.0 && HealingDartAmmo < MagazineCapacity[ALTFIRE_FIREMODE] )
		{
			// Use HealingDartAmmo to replicate the actual ammo you should have.
			HealingDartAmmo++;
			AmmoCount[ALTFIRE_FIREMODE] = HealingDartAmmo;

			HealingIncrement -= 1.0;
		}
	}
}

/** Healing charge doesn't count as ammo for purposes of inventory management (e.g. switching) */
simulated function bool HasAnyAmmo()
{
	if ( HasSpareAmmo() || HasAmmo(DEFAULT_FIREMODE) )
	{
		return true;
	}

	return false;
}

/*********************************************************************************************
 @name Target Locking
********************************************************************************************* */

/**
 *  This function is used to adjust the LockTarget.
 */
function AdjustLockTarget(actor NewLockTarget)
{
	if ( LockedTarget == NewLockTarget )
	{
		// no need to update
		return;
	}

	if (NewLockTarget == None)
	{
		// Clear the lock
		if (bLockedOnTarget)
		{
			bLockedOnTarget = false;
			LockedTarget = None;

			if (OpticsUI != none && PendingLockedTarget == none)
			{
				// Optics UI only exists for local players
				OpticsUI.ClearLockOn();
			}

			if ( bUsingSights )
			{
				ClientPlayTargetingSound(LockLostSoundFirstPerson);
			}
		}
	}
	else
	{
		// Set the lock
		bLockedOnTarget = true;
		LockedTarget = NewLockTarget;

		if (OpticsUI != none)
		{
			// Optics UI only exists for local players
			OpticsUI.LockedOn();
		}

		ClientPlayTargetingSound(LockAcquiredSoundFirstPerson);
	}
}

/**
* Given an potential target TA determine if we can lock on to it.  By default only allow locking on
* to pawns.
*/
simulated function bool CanLockOnTo(Actor TA)
{
	Local Pawn PawnTarget;

    PawnTarget = Pawn(TA);

    // Make sure the pawn is legit, isn't dead, and isn't already at full health
    if ( (TA == None) || !TA.bProjTarget || TA.bDeleteMe || (PawnTarget == None)
        || (TA == Instigator) || (PawnTarget.Health <= 0) || (PawnTarget.Health >= PawnTarget.HealthMax) )
	{
		return false;
	}

	// Make sure and only lock onto players on the same team
    return WorldInfo.GRI.OnSameTeam(Instigator,TA);
}

/** returns true if lock-on is possible */
function bool AllowTargetLockOn()
{
	if ( bUsingSights )
	{
		return !Instigator.bNoWeaponFiring;
	}
	
	
}

/**
* This function checks to see if we are locked on a target
*/
function CheckTargetLock()
{
    local Actor BestTarget, HitActor, TA;
	local vector StartTrace, EndTrace, Aim, HitLocation, HitNormal;
	local rotator AimRot;
	local float BestAim, BestDist;

	if ( (Instigator == None) || (Instigator.Controller == None) || (self != Instigator.Weapon) )
	{
		return;
	}

	if ( !AllowTargetLockOn() )
	{
		AdjustLockTarget(None);
		PendingLockedTarget = None;
		return;
	}

	// clear lock if target is destroyed
	if ( LockedTarget != None )
	{
		if ( LockedTarget.bDeleteMe )
		{
			AdjustLockTarget(None);
		}
	}

	BestTarget = None;

	//@todo: if we ever want AI to use medic weapons, then bring back the commented-out code that used to be here

	// Begin by tracing the shot to see if it hits anyone
	Instigator.Controller.GetPlayerViewPoint( StartTrace, AimRot );
	Aim = vector(AimRot);
	EndTrace = StartTrace + Aim * LockRange;
	HitActor = Trace(HitLocation, HitNormal, EndTrace, StartTrace, true,,, TRACEFLAG_Bullet);

	// Check for a hit
	if ( (HitActor == None) || !CanLockOnTo(HitActor) )
	{
		// We didn't hit a valid target, have the controller attempt to pick a good target
		BestAim = LockAim;
		BestDist = 0.0;
		TA = Instigator.Controller.PickTarget(class'Pawn', BestAim, BestDist, Aim, StartTrace, LockRange, True);
		if ( TA != None && CanLockOnTo(TA) )
		{
            // Trace to see if we hit a destructible, as the PickTarget code only traces against world geometry
            // @todo: Set up pick target to ignore pawns (as it should), but not trace through destructibles
            HitActor = Trace(HitLocation, HitNormal, TA.Location, StartTrace, true,,, TRACEFLAG_Bullet);

            // Make sure we didn't hit a destructible
            if( KFFracturedMeshActor(HitActor) != none || KFDestructibleActor(HitActor) != none )
            {
                BestTarget = none;
            }
            else
            {
                BestTarget = TA;
        	}
		}
	}
	else	// We hit a valid target
	{
		BestTarget = HitActor;
	}

	// If we have a "possible" target, note its time mark
	if ( BestTarget != None )
	{
		if ( BestTarget == LockedTarget )
		{
			LockedOnTimeout = LockTolerance;
		}
		// We have our best target, see if they should become our current target.
		// Check for a new Pending Lock
		else if (PendingLockedTarget != BestTarget)
		{
			PendingLockedTarget = BestTarget;
			PendingLockTimeout = LockTolerance;
			PendingLockAcquireTimeLeft = LockAcquireTime;

			if (OpticsUI != none)
			{
				// Optics UI only exists for local players
				OpticsUI.StartLockOn();
			}

			if ( bUsingSights )
			{
				// Play the "targeting" beep when we begin attempting to lock onto a target
				// that we haven't locked onto yet
				ClientPlayTargetingSound(LockTargetingSoundFirstPerson);
			}
		}
		// Acquire new target if LockAcquireTime has passed
		if ( PendingLockedTarget != None )
		{
			PendingLockAcquireTimeLeft -= LockCheckTime;
			if ( PendingLockedTarget == BestTarget && PendingLockAcquireTimeLeft <= 0 )
			{
				AdjustLockTarget(PendingLockedTarget);
				PendingLockedTarget = None;
			}
		}
	}
	// If we lost a target, attempt to invalidate the pending target
	else if ( PendingLockedTarget != None )
	{
		PendingLockTimeout -= LockCheckTime;
		if ( PendingLockTimeout <= 0 || !CanLockOnTo(PendingLockedTarget) )
		{
			PendingLockedTarget = None;
			if (OpticsUI != none)
			{
				// Optics UI only exists for local players
				OpticsUI.ClearLockOn();
			}
		}
	}

	// If the new target is not the same, attempt to invalidate current locked on target
	if ( LockedTarget != None && BestTarget != LockedTarget )
	{
		LockedOnTimeout -= LockCheckTime;
		if ( LockedOnTimeout <= 0.f || !CanLockOnTo(LockedTarget) )
		{
			AdjustLockTarget(None);
		}
	}
}

/** Plays a first person targeting beep sound (Local Player Only) */
unreliable client function ClientPlayTargetingSound(AkBaseSoundObject Sound)
{
	if( Sound != None && !bSuppressSounds )
	{
		if ( Instigator != None && Instigator.IsHumanControlled() )
		{
			PlaySoundBase(Sound, true);
		}
	}
}

/**
 * Tells the weapon to play a firing sound (uses CurrentFireMode)
 * Overridden to support the dart shooting sounds
 */
simulated function PlayFiringSound( byte FireModeNum )
{
	if ( !bPlayingLoopingFireSnd )
	{
		if( FireModeNum == ALTFIRE_FIREMODE )
		{
    		WeaponPlayFireSound(DartFireSnd.DefaultCue, DartFireSnd.FirstPersonCue);
        }
        else
        {
			Super.PlayFiringSound(FireModeNum);
			return;
		}
	}

	// Need to make noise if super isn't called
	MakeNoise(1.0,'PlayerFiring'); // AI
}

/** Override for 1st person healing dart anims */
simulated function name GetWeaponFireAnim(byte FireModeNum)
{
	if ( FireModeNum == ALTFIRE_FIREMODE )
	{
		return (bUsingSights) ? ShootDartIronAnim : ShootDartAnim;
	}

	return Super.GetWeaponFireAnim(FireModeNum);
}

/*********************************************************************************************
 @name Optics UI
********************************************************************************************* */

/** Get our optics movie from the inventory once our InvManager is created */
reliable client function ClientWeaponSet(bool bOptionalSet, optional bool bDoNotActivate)
{
	local KFInventoryManager KFIM;

	super.ClientWeaponSet(bOptionalSet, bDoNotActivate);

	if (OpticsUI == none)
	{
		KFIM = KFInventoryManager(InvManager);
		if (KFIM != none)
		{
			//Create the screen's UI piece
			OpticsUI = KFGFxWorld_MedicOptics(KFIM.GetOpticsUIMovie(OpticsUIClass));
		}
	}

	// Initialize our displayed ammo count and healer charge
	StartHealRecharge();
}

function ItemRemovedFromInvManager()
{
	local KFInventoryManager KFIM;
	local PhoWeap_MedicBase KFW;

	Super.ItemRemovedFromInvManager();

	if (OpticsUI != none)
	{
		KFIM = KFInventoryManager(InvManager);
		if (KFIM != none)
		{
			// @todo future implementation will have optics in base weapon class
			foreach KFIM.InventoryActors(class'PhoWeap_MedicBase', KFW)
			{
				if( KFW != self && KFW.OpticsUI.Class == OpticsUI.class)
				{
					// A different weapon is still using this optics class
					return;
				}
			}

			//Create the screen's UI piece
			KFIM.RemoveOpticsUIMovie(OpticsUI.class);

			OpticsUI.Close();
			OpticsUI = none;
		}
	}
}

/** Unpause our optics movie and reinitialize our ammo when we equip the weapon */
simulated function AttachWeaponTo(SkeletalMeshComponent MeshCpnt, optional Name SocketName)
{
	super.AttachWeaponTo(MeshCpnt, SocketName);

	if (OpticsUI != none)
	{
		OpticsUI.SetPause(false);
		OpticsUI.ClearLockOn();
		UpdateOpticsUI(true);
		OpticsUI.SetShotPercentCost( AmmoCost[ALTFIRE_FIREMODE]);
	}
}

/** Pause the optics movie once we unequip the weapon so it's not playing in the background */
simulated function DetachWeapon()
{
	local Pawn OwnerPawn;
	super.DetachWeapon();

	OwnerPawn = Pawn(Owner);
	if( OwnerPawn != none && OwnerPawn.Weapon == self )
	{
		if (OpticsUI != none)
		{
			OpticsUI.SetPause();
		}
	}
}

/**
 * Update our displayed ammo count if it's changed
 */
simulated function UpdateOpticsUI(optional bool bForceUpdate)
{
	if (OpticsUI != none && OpticsUI.OpticsContainer != none)
	{
		if (AmmoCount[DEFAULT_FIREMODE] != StoredPrimaryAmmo || bForceUpdate)
		{
			StoredPrimaryAmmo = AmmoCount[DEFAULT_FIREMODE];
			OpticsUI.SetPrimaryAmmo(StoredPrimaryAmmo);
		}

		if (AmmoCount[ALTFIRE_FIREMODE] != StoredSecondaryAmmo || bForceUpdate)
		{
			StoredSecondaryAmmo = AmmoCount[ALTFIRE_FIREMODE];
			OpticsUI.SetHealerCharge(StoredSecondaryAmmo);
		}

		if(OpticsUI.MinPercentPerShot != AmmoCost[ALTFIRE_FIREMODE])
		{
			OpticsUI.SetShotPercentCost( AmmoCost[ALTFIRE_FIREMODE] );
		}
	}
}

/*********************************************************************************************
 * state Inactive
 * This state is the default state.  It needs to make sure Zooming is reset when entering/leaving
 *********************************************************************************************/

auto simulated state Inactive
{
	simulated function BeginState(name PreviousStateName)
	{
		Super.BeginState(PreviousStateName);

		if ( Role == ROLE_Authority )
		{
			bTargetLockingActive = false;
			AdjustLockTarget(None);
			ClearTimer(nameof(CheckTargetLock));
		}

		// force stop beep/lock
		PendingLockedTarget = None;
	}

	simulated function EndState(Name NextStateName)
	{
		Super.EndState(NextStateName);

		if ( Role == ROLE_Authority  )
		{
			SetTimer(LockCheckTime, true, nameof(CheckTargetLock));	
			bTargetLockingActive = true;		
		}
	}
}

/*********************************************************************************************
 * State WeaponSprinting
 * This is the default Sprinting State.  It's performed on both the client and the server.
 *********************************************************************************************/

/** Override AllowTargetLockOn */
simulated state WeaponSprinting
{
	ignores AllowTargetLockOn;
}

/*********************************************************************************************
 * Trader
 ********************************************************************************************/

/** Allows weapon to set its own trader stats (can set number of stats, names and values of stats) */
static simulated event SetTraderWeaponStats( out array<STraderItemWeaponStats> WeaponStats )
{
	super.SetTraderWeaponStats( WeaponStats );

	WeaponStats.Length = WeaponStats.Length + 1;
	WeaponStats[WeaponStats.Length-1].StatType = TWS_HealAmount;
	WeaponStats[WeaponStats.Length-1].StatValue = default.HealAmount;

	WeaponStats.Length = WeaponStats.Length + 1;
	WeaponStats[WeaponStats.Length-1].StatType = TWS_RechargeTime;
	WeaponStats[WeaponStats.Length-1].StatValue = default.HealFullRechargeSeconds;
}

/*********************************************************************************************
* HUD
********************************************************************************************/

/** Determines the secondary ammo left for HUD display */
simulated function int GetSecondaryAmmoForHUD()
{
    return AmmoCount[1];
}

defaultproperties
{
	// Healing charge
    HealAmount=20
	HealFullRechargeSeconds=15
	HealDartShotWeakZedGrabCooldown=0.5

	DartMaxRecoilPitch=250
	DartMinRecoilPitch=200
	DartMaxRecoilYaw=100
	DartMinRecoilYaw=-100

	HealingDartWaveForm=ForceFeedbackWaveform'FX_ForceFeedback_ARCH.Gunfire.Default_Recoil'

	// Zooming/Position
	ZoomInTime=0.12		//0.15

	// Lock On Functionality
    LockRange=50000
	LockAim=0.98
	LockChecktime=0.1
	LockAcquireTime=1.3		//0.2
	LockTolerance=0.2

	// ALT_FIREMODE
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'PhoProj_HealingDart'
	FireInterval(ALTFIRE_FIREMODE)=+0.175
	InstantHitDamage(ALTFIRE_FIREMODE)=0	//Acidic compound skill can adjust that
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Dart_Toxic'
	Spread(ALTFIRE_FIREMODE)=0.015
	AmmoCost(ALTFIRE_FIREMODE)=50
	HealingDartDamageType=class'KFDT_Dart_Healing'
	DartFireSnd=(DefaultCue=AkEvent'WW_WEP_SA_MedicDart.Play_WEP_SA_Medic_Dart_Fire_3P', FirstPersonCue=AkEvent'WW_WEP_SA_MedicDart.Play_WEP_SA_Medic_Dart_Fire_1P')

	MagazineCapacity[1]=100
	HealingDartAmmo=100
	bCanRefillSecondaryAmmo=false

    // Lock on sounds
	LockAcquiredSoundFirstPerson=AkEvent'WW_WEP_SA_MedicDart.Play_WEP_SA_Medic_Alert_Locked_1P'
	LockLostSoundFirstPerson=AkEvent'WW_WEP_SA_MedicDart.Play_WEP_SA_Medic_Alert_Lost_1P'
	LockTargetingSoundFirstPerson=AkEvent'WW_WEP_SA_MedicDart.Play_WEP_SA_Medic_Alert_Locking_1P'
    HealImpactSoundPlayEvent=AkEvent'WW_WEP_SA_MedicDart.Play_WEP_SA_Medic_Dart_Heal'
    HurtImpactSoundPlayEvent=AkEvent'WW_WEP_SA_MedicDart.Play_WEP_SA_Medic_Dart_Hurt'

    // The animated reticle screens class
	OpticsUIClass=class'KFGFxWorld_MedicOptics'

	// Aim Assist
	AimCorrectionSize=40.f
}

