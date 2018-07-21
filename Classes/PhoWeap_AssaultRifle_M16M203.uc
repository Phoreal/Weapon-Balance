class PhoWeap_AssaultRifle_M16M203 extends KFWeap_AssaultRifle_M16M203;

DefaultProperties
{
	bCanRefillSecondaryAmmo = true;

	// Shooting Animations
	FireSightedAnims[0]=Shoot_Iron
	FireSightedAnims[1]=Shoot_Iron2
	FireSightedAnims[2]=Shoot_Iron3

    // FOV
    MeshFov=65
	MeshIronSightFOV=45
    PlayerIronSightFOV=70
 
	// Depth of field
	DOF_FG_FocalRadius=75
	DOF_FG_MaxNearBlurSize=3.5

	// Content
	PackageKey="M16_M203"
	FirstPersonMeshName="wep_1p_m16_m203_mesh.Wep_1stP_M16_M203_Rig"
	FirstPersonAnimSetNames(0)="wep_1p_m16_m203_anim.Wep_1stP_M16_M203_Anim"
	PickupMeshName="WEP_3P_M16_M203_MESH.Wep_M4_M203_Pickup"
	AttachmentArchetypeName="Wep_M16_M203_ARCH.Wep_M16_M203_3P_new"
	MuzzleFlashTemplateName="wep_m16_m203_arch.Wep_M16_M203_MuzzleFlash"


	AttachmentArchetype=KFWeapAttach_MultiAmmo'Wep_M16_M203_ARCH.Wep_M16_M203_3P_new'

   	// Zooming/Position
	PlayerViewOffset=(X=22.0,Y=9.f,Z=-2.f)
	
	IronSightPosition=(X=0,Y=0,Z=0)

	// Pickup
    AmmoPickupScale[1]=2.0

	// Ammo
	InitialSpareMags[0]	= 3 //2
	MagazineCapacity[0]	= 30
	SpareAmmoCapacity[0]= 300	//270
    //grenades
	InitialSpareMags[1]	= 3
	MagazineCapacity[1]	= 1
	SpareAmmoCapacity[1]= 13 //11

	bCanBeReloaded=true
	bReloadFromMagazine=true

	// Recoil
	maxRecoilPitch=120
	minRecoilPitch=70
	maxRecoilYaw=130
	minRecoilYaw=-130
	RecoilRate=0.08
	RecoilMaxYawLimit=500
	RecoilMinYawLimit=65035
	RecoilMaxPitchLimit=900
	RecoilMinPitchLimit=65035
	RecoilISMaxYawLimit=75
	RecoilISMinYawLimit=65460
	RecoilISMaxPitchLimit=375
	RecoilISMinPitchLimit=65460
	RecoilViewRotationScale=0.25
	IronSightMeshFOVCompensationScale=1.7
    HippedRecoilModifier=1.5

    SecondaryAmmoTexture=Texture2D'ui_firemodes_tex.UI_FireModeSelect_Grenade'

    // Inventory / Grouping
	InventorySize=6
	GroupPriority=50
	WeaponSelectTexture=Texture2D'wep_ui_m16_m203_tex.UI_WeaponSelect_M16M203'
   	AssociatedPerkClasses(0)=class'KFPerk_Demolitionist'
   	AssociatedPerkClasses(1)=class'KFPerk_Commando'

	// DEFAULT_FIREMODE
	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletAuto'
	FiringStatesArray(DEFAULT_FIREMODE)=WeaponFiring
	WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
	WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_AssaultRifle'
	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_M16M203'
	FireInterval(DEFAULT_FIREMODE)=+0.085714 //700 RPM 	//0.086 
	Spread(DEFAULT_FIREMODE)=0.0085
	InstantHitDamage(DEFAULT_FIREMODE)=35.0 //24 //33
	FireOffset=(X=30,Y=4.5,Z=-5)
	SecondaryFireOffset=(X=20.f,Y=4.5,Z=-7.f)

	// ALT_FIREMODE
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
	FiringStatesArray(ALTFIRE_FIREMODE)=FiringSecondaryState
	WeaponFireTypes(ALTFIRE_FIREMODE)=EWFT_Projectile
	WeaponProjectiles(ALTFIRE_FIREMODE)=class'PhoProj_HighExplosive_M16M203'
	InstantHitDamageTypes(ALTFIRE_FIREMODE)=class'KFDT_Ballistic_M203Impact'
	FireInterval(ALTFIRE_FIREMODE)=+0.25f
	InstantHitDamage(ALTFIRE_FIREMODE)=150.0 //150 //225	//230
	Spread(ALTFIRE_FIREMODE)=0.0085

	// BASH_FIREMODE
	InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_M16M203'
	InstantHitDamage(BASH_FIREMODE)=26

	// Fire Effects
	WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_M16M203.Play_M16_Fire_3P_Loop', FirstPersonCue=AkEvent'WW_WEP_M16M203.Play_M16_Fire_1P_Loop')
	WeaponFireLoopEndSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_M16M203.Play_M16_Fire_3P_EndLoop', FirstPersonCue=AkEvent'WW_WEP_M16M203.Play_M16_Fire_1P_EndLoop')
	WeaponFireSnd(ALTFIRE_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_SA_M79.Play_WEP_SA_M79_Fire_M', FirstPersonCue=AkEvent'WW_WEP_SA_M79.Play_WEP_SA_M79_Fire_S')

	WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'WW_WEP_SA_L85A2.Play_WEP_SA_L85A2_Handling_DryFire'
	WeaponDryFireSnd(ALTFIRE_FIREMODE)=AkEvent'WW_WEP_SA_L85A2.Play_WEP_SA_L85A2_Handling_DryFire'

	// Advanced (High RPM) Fire Effects
	bLoopingFireAnim(DEFAULT_FIREMODE)=true
	bLoopingFireSnd(DEFAULT_FIREMODE)=true
	WeaponFireSnd(2)=(DefaultCue=AkEvent'WW_WEP_M16M203.Play_M16_Fire_3P_Single', FirstPersonCue=AkEvent'WW_WEP_M16M203.Play_M16_Fire_1P_Single')
	SingleFireSoundIndex=2

	// Attachments
	bHasIronSights=true
	bHasFlashlight=false

}