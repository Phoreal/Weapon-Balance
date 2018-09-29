//=============================================================================
// KFWeap_Flame_HuskCannon
//=============================================================================
// Husk Cannon weapon code
//=============================================================================
// Killing Floor 2
// Copyright (C) 2017 Tripwire Interactive LLC
//=============================================================================
class PhoWeap_HuskCannon extends KFWeap_HuskCannon;

defaultproperties
{
    //Gameplay Props
    MaxChargeTime=1.0			
    ValueIncreaseTime=0.3		//0.2
    DmgIncreasePerCharge=1.7	//0.7
    AOEIncreasePerCharge=0.5	//0.3
    IncapIncreasePerCharge=0.5	//0.22
    AmmoIncreasePerCharge=1

	// Ammo
	MagazineCapacity[0]=15  //25	//20
	SpareAmmoCapacity[0]=150 //300	//240
	InitialSpareMags[0]=4

	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	Spread(DEFAULT_FIREMODE) = 0.0085
    WeaponProjectiles(DEFAULT_FIREMODE)=class'PhoProj_HuskCannon_Fireball'
	FireInterval(DEFAULT_FIREMODE)=+0.3		//0.4
	FireOffset=(X=30,Y=4.5,Z=-5)

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
}