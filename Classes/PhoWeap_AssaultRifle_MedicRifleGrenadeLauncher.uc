class PhoWeap_AssaultRifle_MedicRifleGrenadeLauncher extends KFWeap_AssaultRifle_MedicRifleGrenadeLauncher;

defaultproperties
{
	// Inventory / Grouping
	InventorySize=7		//8

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_MedicRifleGrenadeLauncher'
	FireInterval(DEFAULT_FIREMODE)=+0.12 // 400 RPM
	Spread(DEFAULT_FIREMODE)=0.0085
	InstantHitDamage(DEFAULT_FIREMODE)=50.0 //24	//47
	FireOffset=(X=30,Y=4.5,Z=-5)
	SecondaryFireOffset=(X=20.f,Y=4.5,Z=-7.f)

}