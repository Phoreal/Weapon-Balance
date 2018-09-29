class PhoDT_Ballistic_ElephantGun extends KFDT_Ballistic_ElephantGun
	abstract
	hidedropdown;

defaultproperties
{
	BloodSpread=0.4
	BloodScale=0.6

	KDamageImpulse=3500
	KDeathUpKick=800
	KDeathVel=650
	GibImpulseScale=1.0

    StumblePower=42	//35
	GunHitPower=54		//45
	
	WeaponDef=class'PhoWeapDef_ElephantGun'
}