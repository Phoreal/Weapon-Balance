class PhoWeap_Shotgun_DoubleBarrel extends KFWeap_Shotgun_DoubleBarrel;

var float ReloadTimeModifier;

simulated function float GetReloadRateScale()
{
return Super.GetReloadRateScale() * ReloadTimeModifier;
}

defaultproperties
{
	ReloadTimeModifier=0.88

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_ShotgunSingle'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_Pellet'
	InstantHitDamage(DEFAULT_FIREMODE)=50.0  //25
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'PhoDT_Ballistic_DBShotgun'
	PenetrationPower(DEFAULT_FIREMODE)=2.0
	FireInterval(DEFAULT_FIREMODE)=0.25 // 240 RPM
	FireOffset=(X=25,Y=3.5,Z=-4)
	NumPellets(DEFAULT_FIREMODE)=6 //12	//10
	Spread(DEFAULT_FIREMODE)=0.25
	ForceReloadTimeOnEmpty=0.3

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_ShotgunAuto'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponDoubleBarrelFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Bullet_Pellet'
	InstantHitDamage(ALTFIRE_FIREMODE)=50.0 //25
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'PhoDT_Ballistic_DBShotgun'
	PenetrationPower(ALTFIRE_FIREMODE)=2.0
	FireInterval(ALTFIRE_FIREMODE)=0.25 // 240 RPM
	NumPellets(ALTFIRE_FIREMODE)=12 //24	//20
	Spread(ALTFIRE_FIREMODE)=0.25
	AmmoCost(ALTFIRE_FIREMODE)=2
	DoubleBarrelKickMomentum=1000
	FallingMomentumReduction=0.5

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[2]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[3]=(IncrementDamage=0.0f,IncrementWeight=0)
}