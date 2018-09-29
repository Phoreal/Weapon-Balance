class PhoWeap_Shotgun_M4 extends KFWeap_Shotgun_M4;

defaultproperties
{
	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_ShotgunSingle'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_Pellet'
	InstantHitDamage(DEFAULT_FIREMODE)=30.0 //28
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M4Shotgun'
	PenetrationPower(DEFAULT_FIREMODE)=2.0
	FireInterval(DEFAULT_FIREMODE)=0.2 // 300 RPM		//0.225
	FireOffset=(X=30,Y=5,Z=-4)
	// Shotgun
	NumPellets(DEFAULT_FIREMODE)=8 //7

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[2]=(IncrementDamage=0.0f,IncrementWeight=0)
}