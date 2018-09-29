class PhoPickupFactory_ItemDefault extends KFPickupFactory_Item;

defaultproperties
{
	// These are the default weapons to load into an item pickup factory, more can be added on the object 
	// Weapons in this list are always loaded into memory if this actor exists in the map
    ItemPickups.Add((ItemClass=class'KFInventory_Armor'))
    ItemPickups.Add((ItemClass=class'PhoWeap_AssaultRifle_AR15'))
    ItemPickups.Add((ItemClass=class'PhoWeap_Shotgun_MB500'))
    ItemPickups.Add((ItemClass=class'PhoWeap_Blunt_Crovel'))
	ItemPickups.Add((ItemClass=class'KFWeap_Pistol_9mm'))
	ItemPickups.Add((ItemClass=class'PhoWeap_Revolver_Rem1858'))
	ItemPickups.Add((ItemClass=class'PhoWeap_Rifle_Winchester1894'))
	ItemPickups.Add((ItemClass=class'PhoWeap_Pistol_Medic'))
	ItemPickups.Add((ItemClass=class'PhoWeap_SMG_MP7'))
}
