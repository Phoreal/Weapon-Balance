class PhoWeap_Rifle_CenterfireMB464 extends KFWeap_Rifle_CenterfireMB464;

defaultproperties
{

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_Winchester1894'
	InstantHitDamage(DEFAULT_FIREMODE)=180
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_CenterfireMB464'
	FireInterval(DEFAULT_FIREMODE)=0.4 //0.45
	Spread(DEFAULT_FIREMODE)=0.007
	PenetrationPower(DEFAULT_FIREMODE)=1.5
	FireOffset=(X=25,Y=3.0,Z=-2.5)

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[2]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[3]=(IncrementDamage=0.0f,IncrementWeight=0)
}