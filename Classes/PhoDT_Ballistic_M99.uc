class PhoDT_Ballistic_M99 extends KFDT_Ballistic_M99
	abstract
	hidedropdown;

defaultproperties
{

    KnockdownPower=20
	StunPower=100 //40 //8	//15
	StumblePower=0
	GunHitPower=80 //50
	MeleeHitPower=0

	WeaponDef=class'PhoWeapDef_M99'
	ModifierPerkList(0)=class'KFPerk_Sharpshooter'
}
