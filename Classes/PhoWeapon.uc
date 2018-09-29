Class PhoWeapon extends KFMutator
	config(PhoWeapon);

var array<KFPickupFactory> 	AllPickupFactories;

var	array<PhoPickupFactory_ItemDefault>	ItemPickups;

var array<PhoPickupFactory_ItemDefault> 	PPFID;

var array< class<KFWeapon> > KFStartingWeapon;

var config array<string> CustomItems;

var array<FCustomTraderItem> CustomItemList;
var KFGFxObject_TraderItems CustomTrader;

	/* Init Config */
		var config bool bIWontInitThisConfig;
	/* Weapon Settings */
		var config string StartingWeapons_Berserker;
		var config string StartingWeapons_Commando;
		var config string StartingWeapons_Support;
		var config string StartingWeapons_FieldMedic;
		var config string StartingWeapons_Demolitionist;
		var config string StartingWeapons_Firebug;
		var config string StartingWeapons_Gunslinger;
		var config string StartingWeapons_Sharpshooter;
		var config string StartingWeapons_Survivalist;
		var config string StartingWeapons_Swat;


	function InitConfigVar() 
	{
		/* Init Config */
			bIWontInitThisConfig = true;
		/* Weapon Settings */
			StartingWeapons_Berserker = "";
			StartingWeapons_Commando = "";
			StartingWeapons_Support = "";
			StartingWeapons_FieldMedic = "";
			StartingWeapons_Demolitionist = "";
			StartingWeapons_Firebug = "";
			StartingWeapons_Gunslinger = "";
			StartingWeapons_Sharpshooter = "";
			StartingWeapons_Survivalist = "";
			StartingWeapons_Swat = "";
	}

	function ModifyPlayer(Pawn Other) 
	{
		local KFPawn Player;
		local KFPlayerController KFPC;
		local class<KFPerk> cKFP;
		local class<Weapon> cRetW;
		local Inventory Inv;
		local bool bFound;

			super.ModifyPlayer(Other);

			Player = KFPawn_Human(Other);
			KFPC = KFPlayerController(Player.Controller);
			cKFP = KFPC.GetPerk().GetPerkClass();

			if (IsBotPlayer(KFPC)) return;

			cRetW = GetStartingWeapClassFromPerk(cKFP);
			if (cRetW!=None) 
			{

					bFound = False;
					for(Inv=Player.InvManager.InventoryChain;Inv!=None;Inv=Inv.Inventory) {
						switch(Inv.ItemName) {
							case class'KFGameContent.KFWeap_Blunt_Crovel'.default.ItemName:
							case class'KFGameContent.KFWeap_AssaultRifle_AR15'.default.ItemName:
							case class'KFGameContent.KFWeap_Shotgun_MB500'.default.ItemName:
							case class'KFGameContent.KFWeap_Pistol_Medic'.default.ItemName:
							case class'KFGameContent.KFWeap_GrenadeLauncher_HX25'.default.ItemName:
							case class'KFGameContent.KFWeap_Flame_CaulkBurn'.default.ItemName:
							case class'KFGameContent.KFWeap_Revolver_DualRem1858'.default.ItemName:
							case class'KFGameContent.KFWeap_Rifle_Winchester1894'.default.ItemName:
							case class'KFGameContent.KFWeap_SMG_MP7'.default.ItemName:
								Player.InvManager.RemoveFromInventory(Inv);
								bFound = True;
								break;
						}
						if (bFound) break;
					}
				//武器のとーにゅー
					Player.Weapon = Weapon(Player.CreateInventory(cRetW,Player.Weapon!=None));
				//武器の装備
					Player.InvManager.ServerSetCurrentWeapon(Player.Weapon);


			}

	}

//<<---開始武器の乗っ取り--->>//
	
	//現在のパークからクラスの取得。
	function class<Weapon> GetStartingWeapClassFromPerk(class<KFPerk> Perk) 
	{
		local string SendStr;
		local array<String> SplitBuf;
		SendStr = "";
		switch(Perk) {
			case class'KFPerk_Berserker':
				SendStr = StartingWeapons_Berserker;
				break;
			case class'KFPerk_Commando':
				SendStr = StartingWeapons_Commando;
				break;
			case class'KFPerk_Support':
				SendStr = StartingWeapons_Support;
				break;
			case class'KFPerk_FieldMedic':
				SendStr = StartingWeapons_FieldMedic;
				break;
			case class'KFPerk_Demolitionist':
				SendStr = StartingWeapons_Demolitionist;
				break;
			case class'KFPerk_Firebug':
				SendStr = StartingWeapons_Firebug;
				break;
			case class'KFPerk_Gunslinger':
				SendStr = StartingWeapons_Gunslinger;
				break;
			case class'KFPerk_Sharpshooter':
				SendStr = StartingWeapons_Sharpshooter;
				break;
			case class'KFPerk_Survivalist':
				SendStr = StartingWeapons_Survivalist;
				break;
			case class'KFPerk_Swat':
				SendStr = StartingWeapons_Swat;
				break;
		}
		if (SendStr=="") return None;
		ParseStringIntoArray(SendStr,SplitBuf,",",true);
		SendStr = "PhoWeapon.PhoWeap_" $ SplitBuf[Rand(SplitBuf.length)];
		return GetWeapClassFromString(SendStr);
	}
	
	//文字列からクラスの取得。
	function class<Weapon> GetWeapClassFromString(string str) 
	{
		return class<Weapon>(DynamicLoadObject(str, class'Class'));
	}

	function bool IsBotPlayer(KFPlayerController KFPC)
	{
		return (KFPC.PlayerReplicationInfo.PlayerName=="Braindead Human");
	}



function PostBeginPlay()
{
	local int i;
	local FCustomTraderItem CI;	

	Super.PostBeginPlay();
	
	if (!bIWontInitThisConfig) InitConfigVar();
	SaveConfig();

	if( WorldInfo.Game.BaseMutator==None )
		WorldInfo.Game.BaseMutator = Self;
	else WorldInfo.Game.BaseMutator.AddMutator(Self);
	
	if( bDeleteMe ) // This was a duplicate instance of the mutator.
		return;
	
	WorldInfo.Game.PlayerReplicationInfoClass = class'PhoPlayerReplicationInfo';	
	
	KFGameReplicationInfo(WorldInfo.GRI).TraderItems=class'PhoPlayerReplicationInfo'.Default.MyTraderItems;	

	//we use solid archetype but I keep it just for debug
	for( i=0; i<CustomItems.Length; ++i )
	{
		CI.WeaponDef = class<KFWeaponDefinition>(DynamicLoadObject(CustomItems[i],class'Class'));
		if( CI.WeaponDef==None )
		{
			LogInternal("FAILED TO LOAD CUSTOM WEAPON"@CustomItems[i]);
			continue;
		}
		
		CI.WeaponClass = class<KFWeapon>(DynamicLoadObject(CI.WeaponDef.Default.WeaponClassPath,class'Class'));
		if( CI.WeaponClass==None )
		{
			LogInternal("FAILED TO LOAD CUSTOM WEAPON"@CustomItems[i]);
			continue;
		}
			
		LogInternal("SUCCESSED TO LOAD CUSTOM WEAPON"@CustomItems[i]);
		
		CustomItemList.AddItem(CI);
	}

	SetPickupItemList();

}
	
function AddMutator(Mutator M)
{
	if( M!=Self ) // Make sure we don't get added twice.
	{
		if( M.Class==Class )
			M.Destroy();
		else Super.AddMutator(M);
	}
}

function SetPickupItemList()
{
    local KFPickupFactory_ItemDefault ItemFactory;

        foreach AllActors(class'KFPickupFactory_ItemDefault', ItemFactory)
        {
        	ItemFactory.ItemPickups[1].ItemClass = class'PhoWeapon.PhoWeap_AssaultRifle_AR15';
        	ItemFactory.ItemPickups[2].ItemClass = class'PhoWeapon.PhoWeap_Shotgun_MB500';
        	ItemFactory.ItemPickups[3].ItemClass = class'PhoWeapon.PhoWeap_Blunt_Crovel';
        	ItemFactory.ItemPickups[5].ItemClass = class'PhoWeapon.PhoWeap_Revolver_Rem1858';
        	ItemFactory.ItemPickups[6].ItemClass = class'PhoWeapon.PhoWeap_Rifle_Winchester1894';
        	ItemFactory.ItemPickups[7].ItemClass = class'PhoWeapon.PhoWeap_Pistol_Medic';
        	ItemFactory.ItemPickups[8].ItemClass = class'PhoWeapon.PhoWeap_SMG_MP7';
        } 
}

defaultproperties
{


}
