class PhoWeap_Pistol_DualAF2011 extends KFWeap_Pistol_DualAF2011;

defaultproperties
{
	SingleClass=class'PhoWeap_Pistol_AF2011'

	// Ammo
	InitialSpareMags[0]=4	//2

	// DEFAULT_FIREMODE
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_PistolAF2011'
	FireInterval(DEFAULT_FIREMODE)=+0.13 // about twice as fast as single
	InstantHitDamage(DEFAULT_FIREMODE)=53
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'PhoDT_Ballistic_AF2011'
	PenetrationPower(DEFAULT_FIREMODE)=1.5
	Spread(DEFAULT_FIREMODE)=0.01
    AmmoCost(DEFAULT_FIREMODE)=2

    // Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
}

