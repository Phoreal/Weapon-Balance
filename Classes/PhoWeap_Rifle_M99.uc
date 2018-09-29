class PhoWeap_Rifle_M99 extends KFWeap_Rifle_M99;

defaultproperties
{
	// Ammo
	MagazineCapacity[0]=1
	SpareAmmoCapacity[0]=15 //30	//30
	InitialSpareMags[0]=6
	bCanBeReloaded=true
	bReloadFromMagazine=true
	AmmoPickupScale[0]=2.0

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_M99'
	InstantHitDamage(DEFAULT_FIREMODE)=750 //850
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'PhoDT_Ballistic_M99'
	FireInterval(DEFAULT_FIREMODE)=0.2 //0.2
	PenetrationPower(DEFAULT_FIREMODE)=5.0
	Spread(DEFAULT_FIREMODE)=0.006
	FireOffset=(X=30,Y=3.0,Z=-2.5)
	ForceReloadTimeOnEmpty=0.5


}