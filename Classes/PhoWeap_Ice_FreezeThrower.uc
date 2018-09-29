class PhoWeap_Ice_FreezeThrower extends KFWeap_Ice_FreezeThrower;

defaultproperties
{
    // Inventory
	InventorySize=9		//7
	GroupPriority=100	//75

	// ALT_FIREMODE
	AmmoCost(ALTFIRE_FIREMODE)=7	//10

   	AssociatedPerkClasses(0)=class'KFPerk_Survivalist'
	AssociatedPerkClasses(1)=class'KFPerk_Firebug'

	// Weapon Upgrade stat boosts
	WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0)
	WeaponUpgrades[2]=(IncrementDamage=0.0f,IncrementWeight=0)
}