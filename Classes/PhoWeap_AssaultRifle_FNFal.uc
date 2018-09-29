class PhoWeap_AssaultRifle_FNFal extends KFWeap_AssaultRifle_FNFal;

defaultproperties
{
	// Ammo
	SpareAmmoCapacity[0]=340

	// Recoil
	maxRecoilPitch=175 	//200
	minRecoilPitch=150 	//165
	maxRecoilYaw=150 	//190
	minRecoilYaw=-150 	//-165
	RecoilRate=0.085	//0.09

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_FNFal'
	FireInterval(DEFAULT_FIREMODE)=+0.092307 	//650 RPM 
	PenetrationPower(DEFAULT_FIREMODE)=2.0
	Spread(DEFAULT_FIREMODE)=0.007
	InstantHitDamage(DEFAULT_FIREMODE)=55.0 	//50	//70

	// ALTFIRE_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_FNFal'
	FireInterval(ALTFIRE_FIREMODE)=+0.1  		//600 RPM
	PenetrationPower(ALTFIRE_FIREMODE)=2.0
	InstantHitDamage(ALTFIRE_FIREMODE)=55.0 	//50	//70
	Spread(ALTFIRE_FIREMODE)=0.007
}