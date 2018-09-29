class PhoWeap_SMG_Kriss extends KFWeap_SMG_Kriss;

defaultproperties
{

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_Kriss'
	FireInterval(DEFAULT_FIREMODE)=+.05 // 1200 RPM
	Spread(DEFAULT_FIREMODE)=0.01		//0.015
	InstantHitDamage(DEFAULT_FIREMODE)=37.0 //33
	FireOffset=(X=30,Y=4.5,Z=-5)

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_Kriss'
	FireInterval(ALTFIRE_FIREMODE)=+.05
	InstantHitDamage(ALTFIRE_FIREMODE)=37.0  //33
	Spread(ALTFIRE_FIREMODE)=0.01		//0.015

    // Weapon Upgrade stat boosts
    WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
}
