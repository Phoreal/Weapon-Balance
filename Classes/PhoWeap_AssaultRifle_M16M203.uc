class PhoWeap_AssaultRifle_M16M203 extends KFWeap_AssaultRifle_M16M203;

DefaultProperties
{
	// Ammo
	InitialSpareMags[0]	= 3 //2
	MagazineCapacity[0]	= 30
	SpareAmmoCapacity[0]= 300	//270
    //grenades
	InitialSpareMags[1]	= 3
	MagazineCapacity[1]	= 1
	SpareAmmoCapacity[1]= 13 //11

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'PhoDT_Ballistic_M16M203'
	FireInterval(DEFAULT_FIREMODE)=+0.085714 //700 RPM 	//0.086 
	Spread(DEFAULT_FIREMODE)=0.0085
	InstantHitDamage(DEFAULT_FIREMODE)=35.0 //24 //33
	FireOffset=(X=30,Y=4.5,Z=-5)
	SecondaryFireOffset=(X=20.f,Y=4.5,Z=-7.f)

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(ALTFIRE_FIREMODE)=FiringSecondaryState
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'PhoProj_HighExplosive_M16M203'
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_M203Impact'
	FireInterval(ALTFIRE_FIREMODE)=+0.25f
	InstantHitDamage(ALTFIRE_FIREMODE)=150.0 //150 //225	//230
	Spread(ALTFIRE_FIREMODE)=0.0085

}