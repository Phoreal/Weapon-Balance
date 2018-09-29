class PhoWeap_AssaultRifle_MKB42 extends KFWeap_AssaultRifle_MKB42;

defaultproperties
{
	// Recoil
	maxRecoilYaw=180 
	minRecoilYaw=-180  
	RecoilRate=0.11 //0.085

	// Ammo
	SpareAmmoCapacity[0]=300

	// Inventory / Grouping
	InventorySize=6		//7

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	FireInterval(DEFAULT_FIREMODE)=+0.12 // 500 RPM
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'PhoDT_Ballistic_MKB42'
	Spread(DEFAULT_FIREMODE)=0.0085
	InstantHitDamage(DEFAULT_FIREMODE)=50.0 //60
	FireOffset=(X=32,Y=4.0,Z=-5)

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(ALTFIRE_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	FireInterval(ALTFIRE_FIREMODE)=+0.12 // 1000 RPM
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'PhoDT_Ballistic_MKB42'
	InstantHitDamage(ALTFIRE_FIREMODE)=50.0 //60
	Spread(ALTFIRE_FIREMODE)=0.0085

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[2]=(IncrementDamage=0.0f,IncrementWeight=0)
}