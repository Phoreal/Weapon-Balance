class PhoWeap_Rifle_RailGun extends KFWeap_Rifle_RailGun;

defaultproperties
{
	// Ammo
	MagazineCapacity[0]=1
	SpareAmmoCapacity[0]=20
	InitialSpareMags[0]=6
	bCanBeReloaded=true
	bReloadFromMagazine=true
	AmmoPickupScale[0]=3.0

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'UI_SecondaryAmmo_TEX.UI_FireModeSelect_AutoTarget'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_RailGun'
	InstantHitDamage(DEFAULT_FIREMODE)=325  //375	//280
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_RailGun'
	FireInterval(DEFAULT_FIREMODE)=0.1 //0.4
	PenetrationPower(DEFAULT_FIREMODE)=10.0
	Spread(DEFAULT_FIREMODE)=0.005
	FireOffset=(X=30,Y=3.0,Z=-2.5)
	ForceReloadTimeOnEmpty=0.5

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'UI_SecondaryAmmo_TEX.UI_FireModeSelect_ManualTarget'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(ALTFIRE_FIREMODE)=none
	InstantHitDamage(ALTFIRE_FIREMODE)=650 //750	//560
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_RailGun'
	FireInterval(ALTFIRE_FIREMODE)=0.1 //0.4
	PenetrationPower(ALTFIRE_FIREMODE)=10.0
	Spread(ALTFIRE_FIREMODE)=0.005

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
}