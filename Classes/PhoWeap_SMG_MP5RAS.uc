class PhoWeap_SMG_MP5RAS extends KFWeap_SMG_MP5RAS;

defaultproperties
{
	// Ammo
	SpareAmmoCapacity[0]=360 //360	//320

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_MP5RAS'
	FireInterval(DEFAULT_FIREMODE)=+0.075 // 800 RPM		//0.067
	Spread(DEFAULT_FIREMODE)=0.01
	InstantHitDamage(DEFAULT_FIREMODE)=29 //22	//25
	FireOffset=(X=30,Y=4.5,Z=-5)

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletBurst'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponBurstFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_MP5RAS'
	FireInterval(ALTFIRE_FIREMODE)=+0.075 
	InstantHitDamage(ALTFIRE_FIREMODE)=29  //22	//25
	Spread(ALTFIRE_FIREMODE)=0.01
	BurstAmount=3

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[2]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[3]=(IncrementDamage=0.0f,IncrementWeight=0)
}
