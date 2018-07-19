Class PhoPlayerReplicationInfo extends KFPlayerReplicationInfo;

// For custom trader inventory.
struct FCustomTraderItem
{
	var class<KFWeaponDefinition> WeaponDef;
	var class<KFWeapon> WeaponClass;
};

var transient PhoPlayerReplicationInfo LocalOwnerPRI; // Local playercontroller owner PRI

// Custom trader inventory
var KFGFxObject_TraderItems CustomList;
var array<FCustomTraderItem> CustomItems;
var KFGFxObject_TraderItems MyTraderItems;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetTimer(1.0, true, 'UpdateTI');
}

simulated function UpdateTI()
{
	KFGameReplicationInfo(WorldInfo.GRI).TraderItems=MyTraderItems;	
}

defaultproperties
{
   MyTraderItems=KFGFxObject_TraderItems'GP_Trader_ARCH.PhoTraderItems'
   //GP_Trader_ARCH_PW.PhoTraderItems
}
