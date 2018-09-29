class PhoWeap_SMG_MP7 extends KFWeap_SMG_MP7 ;

defaultproperties
{
	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_MP7'
	FireInterval(DEFAULT_FIREMODE)=+.063 // 950 RPM
	Spread(DEFAULT_FIREMODE)=0.01	//0.015
	InstantHitDamage(DEFAULT_FIREMODE)=25 //20	//16
	FireOffset=(X=30,Y=4.5,Z=-5)

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_MP7'
	FireInterval(ALTFIRE_FIREMODE)=+.063 // 950 RPM
	InstantHitDamage(ALTFIRE_FIREMODE)=25 //20	//16
	Spread(ALTFIRE_FIREMODE)=0.01

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[2]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[3]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[4]=(IncrementDamage=0.0f,IncrementWeight=0)
}