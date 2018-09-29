class PhoWeap_Shotgun_Medic extends PhoWeap_MedicBase;

var(Weapon) array<byte>	NumPellets;

/*********************************************************************************************
 Firing / Projectile - Below projectile spawning code copied from KFWeap_ShotgunBase
********************************************************************************************* */

/** Spawn projectile is called once for each shot pellet fired */
simulated function KFProjectile SpawnProjectile( class<KFProjectile> KFProjClass, vector RealStartLoc, vector AimDir )
{
	local int i;
	local rotator AimRot;
	local KFPerk InstigatorPerk;

    if( CurrentFireMode == GRENADE_FIREMODE )
    {
        return Super.SpawnProjectile(KFProjClass, RealStartLoc, AimDir);
    }

    InstigatorPerk = GetPerk();
    if( InstigatorPerk != none )
    {
    	Spread[CurrentFireMode] = default.Spread[CurrentFireMode] * InstigatorPerk.GetTightChokeModifier();
    }

	AimRot = rotator(AimDir);

	for (i = 0; i < NumPellets[CurrentFireMode]; i++)
	{
		Super.SpawnProjectile(KFProjClass, RealStartLoc, vector(class'KFWeap_ShotgunBase'.static.AddMultiShotSpread(AimRot, Spread[CurrentFireMode])));
	}

	return None;
}

/** Disable normal bullet spread */
simulated function rotator AddSpread(rotator BaseAim)
{
	return BaseAim; // do nothing
}

/** Notification that a weapon attack has has happened */
function HandleWeaponShotTaken( byte FireMode )
{
    if( KFPlayer != None )
	{
        KFPlayer.AddShotsFired(NumPellets[FireMode]);
	}
}

///////////////////////////////////////////////////////////////////////////////////////////
//
// Trader
//
///////////////////////////////////////////////////////////////////////////////////////////

/** Allows weapon to calculate its own damage for display in trader.
  * Overridden to multiply damage by number of pellets.
  * Exact copy of KFWeap_ShotgunBase.CalculateTraderWeaponStatDamage
  */
static simulated function float CalculateTraderWeaponStatDamage()
{
	local float BaseDamage, DoTDamage;
	local class<KFDamageType> DamageType;

	BaseDamage = default.InstantHitDamage[DEFAULT_FIREMODE];

	DamageType = class<KFDamageType>(default.InstantHitDamageTypes[DEFAULT_FIREMODE]);
	if( DamageType != none && DamageType.default.DoT_Type != DOT_None )
	{
		DoTDamage = (DamageType.default.DoT_Duration / DamageType.default.DoT_Interval) * (BaseDamage * DamageType.default.DoT_DamageScale);
	}

	return BaseDamage * default.NumPellets[DEFAULT_FIREMODE] + DoTDamage;
}

/** Returns trader filter index based on weapon type */
static simulated event EFilterTypeUI GetTraderFilter()
{
	return FT_Shotgun;
}

defaultproperties
{
	// Healing charge
    HealAmount=20 //30	//15
	HealFullRechargeSeconds=12

	// Inventory
	InventorySize=6
	GroupPriority=75
	WeaponSelectTexture=Texture2D'ui_weaponselect_tex.UI_WeaponSelect_MedicShotgun'
	SecondaryAmmoTexture=Texture2D'UI_SecondaryAmmo_TEX.MedicDarts'

    // FOV
	MeshIronSightFOV=52
    PlayerIronSightFOV=70

	// Depth of field
	DOF_FG_FocalRadius=95
	DOF_FG_MaxNearBlurSize=3.5

	// Zooming/Position
	PlayerViewOffset=(X=14.0,Y=6.5,Z=-3.5)
	IronSightPosition=(X=12.0,Y=0,Z=0)

	// Content
	PackageKey="Medic_Shotgun"
	FirstPersonMeshName="WEP_1P_Medic_Shotgun_MESH.Wep_1stP_Medic_Shotgun_Rig"
	FirstPersonAnimSetNames(0)="WEP_1P_Medic_Shotgun_ANIM.WEP_1P_Medic_Shotgun_ANIM"
	PickupMeshName="wep_3p_medic_shotgun_mesh.Wep_Medic_Shotgun_Pickup"
	AttachmentArchetypeName="WEP_Medic_Shotgun_ARCH.Wep_Medic_Shotgun_3P"
	MuzzleFlashTemplateName="WEP_Medic_Shotgun_ARCH.Wep_Medic_Shotgun_MuzzleFlash"

    bHasFireLastAnims=false

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_ShotgunSingle'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_Pellet'
	InstantHitDamage(DEFAULT_FIREMODE)=20.0
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_Shotgun_Medic'
	PenetrationPower(DEFAULT_FIREMODE)=2.0
	FireInterval(DEFAULT_FIREMODE)=0.2   //300 RPM  //0.297
	FireOffset=(X=30,Y=3,Z=-3)
	Spread(DEFAULT_FIREMODE)=0.07
	// Shotgun
	NumPellets(DEFAULT_FIREMODE)=7	//6

	// ALTFIRE_FIREMODE
	NumPellets(ALTFIRE_FIREMODE)=1
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_MedicDart'
	AmmoCost(ALTFIRE_FIREMODE)=35	//40

	// BASH_FIREMODE - Waiting on animations
	InstantHitDamage(BASH_FIREMODE)=26.0
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_Shotgun_Medic'

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_SA_MedicShotgun.Play_SA_MedicShotgun_Fire_3P', FirstPersonCue=AkEvent'WW_WEP_SA_MedicShotgun.Play_SA_MedicShotgun_Fire_1P')
    WeaponFireSnd(ALTFIRE_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_SA_MedicShotgun.Play_SA_MedicShotgun_Fire_3P', FirstPersonCue=AkEvent'WW_WEP_SA_MedicShotgun.Play_SA_MedicShotgun_Fire_1P')

	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'WW_WEP_SA_MedicShotgun.Play_SA_MedicShotgun_Handling_DryFire'
	WeaponDryFireSnd(ALTFIRE_FIREMODE)=AkEvent'WW_WEP_SA_MedicDart.Play_WEP_SA_Medic_Dart_DryFire'

	// Attachments
	bHasIronSights=true
	bHasFlashlight=true

	// Ammo
	MagazineCapacity[0]=10
	SpareAmmoCapacity[0]=80
	InitialSpareMags[0]=3
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=400
	minRecoilPitch=375
	maxRecoilYaw=250
	minRecoilYaw=-250
	RecoilRate=0.075
	RecoilBlendOutRatio=0.25
	RecoilMaxYawLimit=500
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=900
	RecoilMinPitchLimit=64785
	RecoilISMaxYawLimit=50
	RecoilISMinYawLimit=65485
	RecoilISMaxPitchLimit=500
	RecoilISMinPitchLimit=65485
	RecoilViewRotationScale=0.7
	FallingRecoilModifier=1.5
	HippedRecoilModifier=1.5

	AssociatedPerkClasses(0)=class'KFPerk_FieldMedic'
	AssociatedPerkClasses(1)=class'KFPerk_Support'

	WeaponFireWaveForm=ForceFeedbackWaveform'FX_ForceFeedback_ARCH.Gunfire.Heavy_Recoil_SingleShot'

	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0, IncrementHealFullRecharge=0)
	WeaponUpgrades[2]=(IncrementDamage=0.0f, IncrementWeight=0, IncrementHealFullRecharge=0)
}