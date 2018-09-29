class PhoWeap_Shotgun_DragonsBreath extends KFWeap_Shotgun_DragonsBreath;


defaultproperties
{

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)="ui_firemodes_tex.UI_FireModeSelect_ShotgunSingle"
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_DragonsBreath'
	InstantHitDamage(DEFAULT_FIREMODE)=25 //15 //27	//26
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_DragonsBreath'
	PenetrationPower(DEFAULT_FIREMODE)=2.0 //3.0
	FireInterval(DEFAULT_FIREMODE)=0.69 // 78 RPM //0.77	
	FireOffset=(X=30,Y=3,Z=-3)
	// Shotgun
	Spread(DEFAULT_FIREMODE)=0.16 //0.1
	NumPellets(DEFAULT_FIREMODE)=8 //9	

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[2]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[3]=(IncrementDamage=0.0f,IncrementWeight=0)
}