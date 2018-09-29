class PhoWeap_Shotgun_ElephantGun extends KFWeap_Shotgun_ElephantGun;

defaultproperties
{
	// Inventory
	InventorySize=12	//11


	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_ShotgunSingle'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_Pellet'
	InstantHitDamage(DEFAULT_FIREMODE)=25.0 //36	//40
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_ElephantGun'
	PenetrationPower(DEFAULT_FIREMODE)=4.0
	FireInterval(DEFAULT_FIREMODE)=0.25 // 240 RPM
	FireOffset=(X=25,Y=3.5,Z=-4)
	NumPellets(DEFAULT_FIREMODE)=10	//6
	Spread(DEFAULT_FIREMODE)=0.19
	ForceReloadTimeOnEmpty=0.3

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_ShotgunAuto'
	FiringStatesArray(ALTFIRE_FIREMODE)= WeaponQuadBarrelFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Bullet_Pellet'
	InstantHitDamage(ALTFIRE_FIREMODE)=25.0 //36	//40
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_ElephantGun'
	PenetrationPower(ALTFIRE_FIREMODE)=4.0
	FireInterval(ALTFIRE_FIREMODE)=0.25 // 240 RPM
	NumPellets(ALTFIRE_FIREMODE)=40	//24
	Spread(ALTFIRE_FIREMODE)=0.19
	AmmoCost(ALTFIRE_FIREMODE)=4
	DoubleBarrelKickMomentum=1000
	FallingMomentumReduction=0.5

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_ElephantGun'
	InstantHitDamage(BASH_FIREMODE)=27 //24

	// Ammo
	SpareAmmoCapacity[0]=48 //72	//40

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
}