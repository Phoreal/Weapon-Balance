class PhoWeap_SMG_HK_UMP extends KFWeap_SMG_HK_UMP;

defaultproperties
{
    // Inventory
    InventorySize=4		//5

    // Ammo
    SpareAmmoCapacity[0]=330 //320	//290

    // DEFAULT_FIREMODE
    FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
    FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
    WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
    WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
    InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_HK_UMP'
    FireInterval(DEFAULT_FIREMODE)=+0.1 // 600 RPM
    Spread(DEFAULT_FIREMODE)=0.01
    InstantHitDamage(DEFAULT_FIREMODE)=37	//45
    FireOffset=(X=30,Y=4.5,Z=-5)

    // ALT_FIREMODE
    FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletBurst'
    FiringStatesArray(ALTFIRE_FIREMODE)=WeaponBurstFiring
    WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_InstantHit
    WeaponProjectiles(ALTFIRE_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
    InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_HK_UMP'
    FireInterval(AltFire_FIREMODE)=+0.1 // 600 RPM
	BurstAmount=3
	BurstFire2RdAnim=Shoot_Burst2
	BurstFire3RdAnim=Shoot_Burst
	BurstFire2RdSightedAnim=Shoot_Burst2_Iron
	BurstFire3RdSightedAnim=Shoot_Burst_Iron
    WeaponFire2RdSnd=(DefaultCue=AkEvent'WW_WEP_UMP.Play_WEP_UMP_Fire_3P_2Round', FirstPersonCue=AkEvent'WW_WEP_UMP.Play_WEP_UMP_Fire_1P_2Round')
    WeaponFire3RdSnd=(DefaultCue=AkEvent'WW_WEP_UMP.Play_WEP_UMP_Fire_3P_3Round', FirstPersonCue=AkEvent'WW_WEP_UMP.Play_WEP_UMP_Fire_1P_3Round')
    InstantHitDamage(ALTFIRE_FIREMODE)=37	//45
    Spread(ALTFIRE_FIREMODE)=0.01

    // Weapon Upgrade stat boosts
    WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
    WeaponUpgrades[2]=(IncrementDamage=0.0f,IncrementWeight=0)
}
