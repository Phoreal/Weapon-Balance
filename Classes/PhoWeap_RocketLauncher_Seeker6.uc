//=============================================================================
// KFWeap_RocketLauncher_Seeker6
//=============================================================================
// A heatseeking rocket launcher that can fire up to 6 rockets
//=============================================================================
// Killing Floor 2
// Copyright (C) 2017 Tripwire Interactive LLC
//  - Matt 'Squirrlz' Farber
//=============================================================================
class PhoWeap_RocketLauncher_Seeker6 extends KFWeap_RocketLauncher_Seeker6;

defaultproperties
{

	// Inventory
	InventoryGroup=IG_Primary
	GroupPriority=75	//100
	InventorySize=6 //10	//9
	WeaponSelectTexture=Texture2D'WEP_UI_SeekerSix_TEX.UI_WeaponSelect_SeekerSix'

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'UI_FireModes_TEX.UI_FireModeSelect_Rocket'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Rocket_Seeker6'
	FireInterval(DEFAULT_FIREMODE)=+0.3		//0.35
	InstantHitDamage(DEFAULT_FIREMODE)=125.0 //100.00	//120
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_Seeker6Impact'
	Spread(DEFAULT_FIREMODE)=0.025
	FireOffset=(X=20,Y=4.0,Z=-3)

		// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)= Texture2D'UI_SecondaryAmmo_TEX.UI_FireModeSelect_AutoTarget'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponBurstFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Rocket_Seeker6'
	FireInterval(ALTFIRE_FIREMODE)=+0.3 //0.1
	InstantHitDamage(ALTFIRE_FIREMODE)=125.0 //100.00	//120
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_Seeker6Impact'
	Spread(ALTFIRE_FIREMODE)=0.025
	AmmoCost(ALTFIRE_FIREMODE)=1


	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
}
