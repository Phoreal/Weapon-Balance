class PhoWeap_Rifle_M14EBR extends KFWeap_Rifle_M14EBR;

defaultproperties
{
	// Ammo
	MagazineCapacity[0]=20
	SpareAmmoCapacity[0]=160	//120
	InitialSpareMags[0]=2
	bCanBeReloaded=true
	bReloadFromMagazine=true

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_M14EBR'
	InstantHitDamage(DEFAULT_FIREMODE)=90
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M14EBR'
	FireInterval(DEFAULT_FIREMODE)=0.22 //0.2
	PenetrationPower(DEFAULT_FIREMODE)=2.0
	Spread(DEFAULT_FIREMODE)=0.006
	FireOffset=(X=30,Y=3.0,Z=-2.5)

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[2]=(IncrementDamage=0.0f,IncrementWeight=0)
}