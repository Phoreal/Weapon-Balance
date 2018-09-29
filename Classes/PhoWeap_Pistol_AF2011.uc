class PhoWeap_Pistol_AF2011 extends KFWeap_Pistol_AF2011;

defaultproperties
{
	DualClass=class'PhoWeap_Pistol_DualAF2011'

	// DEFAULT_FIREMODE
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
	WeaponFireTypes(DEFAULT_FIREMODE)= EWFT_Projectile
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_PistolAF2011'
	FireInterval(DEFAULT_FIREMODE)=+0.1898
	InstantHitDamage(DEFAULT_FIREMODE)=53 //91
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'PhoDT_Ballistic_AF2011'
	PenetrationPower(DEFAULT_FIREMODE)=1.5
	Spread(DEFAULT_FIREMODE)=0.01
	FireOffset=(X=20,Y=4.0,Z=-3)
    AmmoCost(DEFAULT_FIREMODE)=2

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
}