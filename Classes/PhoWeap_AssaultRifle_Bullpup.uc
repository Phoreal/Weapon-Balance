class PhoWeap_AssaultRifle_Bullpup extends KFWeap_AssaultRifle_Bullpup;

defaultproperties
{
    // Inventory / Grouping
	InventorySize=5		//6

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_Bullpup'
	FireInterval(DEFAULT_FIREMODE)=+0.09836 // 610 RPM	/0.09
	Spread(DEFAULT_FIREMODE)=0.0085
	InstantHitDamage(DEFAULT_FIREMODE)=35.0 	//25	//30
	FireOffset=(X=30,Y=4.5,Z=-5)

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_Bullpup'
	FireInterval(ALTFIRE_FIREMODE)=+0.09836 // 610 RPM	//0.1
	InstantHitDamage(ALTFIRE_FIREMODE)=35.0 	//25	//30
	Spread(ALTFIRE_FIREMODE)=0.0085

}