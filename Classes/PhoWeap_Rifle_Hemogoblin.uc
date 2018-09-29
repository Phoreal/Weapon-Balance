class PhoWeap_Rifle_Hemogoblin extends PhoWeap_MedicBase;

/** Returns trader filter index based on weapon type (copied from riflebase) */
static simulated event EFilterTypeUI GetTraderFilter()
{
    if (default.FiringStatesArray[DEFAULT_FIREMODE] == 'WeaponFiring' || default.FiringStatesArray[DEFAULT_FIREMODE] == 'WeaponBurstFiring')
    {
        return FT_Assault;
    }
    else // if( FiringStatesArray[DEFAULT_FIREMODE] == 'WeaponSingleFiring')
    {
        return FT_Rifle;
    }
}

/**
* See Pawn.ProcessInstantHit
* @param DamageReduction: Custom KF parameter to handle penetration damage reduction
*/
simulated function ProcessInstantHitEx(byte FiringMode, ImpactInfo Impact, optional int NumHits, optional out float out_PenetrationVal, optional int ImpactNum)
{
    local KFPerk InstigatorPerk;

    InstigatorPerk = GetPerk();
    if (InstigatorPerk != none)
    {
        InstigatorPerk.UpdatePerkHeadShots(Impact, InstantHitDamageTypes[FiringMode], ImpactNum);
    }

    super.ProcessInstantHitEx(FiringMode, Impact, NumHits, out_PenetrationVal, ImpactNum);
}

defaultproperties
{
    //Healing
    HealAmount=25   //20
    HealFullRechargeSeconds=12 //15

    // Inventory / Grouping
    InventorySize=8
    GroupPriority=75
    WeaponSelectTexture=Texture2D'WEP_UI_Bleeder_TEX.UI_WeaponSelect_Bleeder'
    SecondaryAmmoTexture=Texture2D'UI_SecondaryAmmo_TEX.MedicDarts'
    AssociatedPerkClasses(0)=class'KFPerk_FieldMedic'

    // FOV
    MeshFOV=70
    MeshIronSightFOV=27
    PlayerIronSightFOV=70

    // Depth of field
    DOF_BlendInSpeed=3.0	
    DOF_FG_FocalRadius=0//70
    DOF_FG_MaxNearBlurSize=3.5

	// Content
	PackageKey="Bleeder"
	FirstPersonMeshName="WEP_1P_Bleeder_MESH.WEP_1stP_Bleeder_Rig"
	FirstPersonAnimSetNames(0)="WEP_1P_Bleeder_ANIM.Wep_1stP_Bleeder_Anim"
	PickupMeshName="wep_3p_bleeder_mesh.Wep_3rdP_Bleeder_Pickup"
    AttachmentArchetypeName="WEP_Bleeder_ARCH.Wep_Bleeder_3P"
	MuzzleFlashTemplateName="WEP_Bleeder_ARCH.Wep_Bleeder_MuzzleFlash"
    
    LaserSightTemplate=KFLaserSightAttachment'FX_LaserSight_ARCH.LaserSight_WithAttachment_1P'

    // Ammo
    MagazineCapacity[0]=7
    SpareAmmoCapacity[0]=91 //77
    InitialSpareMags[0]=3
    bCanBeReloaded=true
    bReloadFromMagazine=true

    // Zooming/Position
    PlayerViewOffset=(X=20.0,Y=11.0,Z=-2) //(X=15.0,Y=11.5,Z=-4)
    IronSightPosition=(X=30.0,Y=0,Z=0)

    // AI warning system
    bWarnAIWhenAiming=true
    AimWarningDelay=(X=0.4f, Y=0.8f)
    AimWarningCooldown=0.0f

    // Recoil
    maxRecoilPitch=225
    minRecoilPitch=200
    maxRecoilYaw=200
    minRecoilYaw=-200
    RecoilRate=0.08
    RecoilMaxYawLimit=500
    RecoilMinYawLimit=65035
    RecoilMaxPitchLimit=900
    RecoilMinPitchLimit=65035
    RecoilISMaxYawLimit=150
    RecoilISMinYawLimit=65385
    RecoilISMaxPitchLimit=375
    RecoilISMinPitchLimit=65460
    RecoilViewRotationScale=0.6

    // DEFAULT_FIREMODE
    FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_BulletSingle'
    FiringStatesArray(DEFAULT_FIREMODE)=WeaponSingleFiring
    WeaponFireTypes(DEFAULT_FIREMODE)=EWFT_InstantHit
    WeaponProjectiles(DEFAULT_FIREMODE)=class'KFProj_Bullet_Hemogoblin'
    InstantHitDamage(DEFAULT_FIREMODE)=50.0
    InstantHitDamageTypes(DEFAULT_FIREMODE)=class'KFDT_Ballistic_Hemogoblin'
    FireInterval(DEFAULT_FIREMODE)=0.25
    PenetrationPower(DEFAULT_FIREMODE)=0.0 //2.0
    Spread(DEFAULT_FIREMODE)=0.006
    FireOffset=(X=30,Y=3.0,Z=-2.5)

    // ALT_FIREMODE
    AmmoCost(ALTFIRE_FIREMODE)=40

    // BASH_FIREMODE
    InstantHitDamageTypes(BASH_FIREMODE)=class'KFDT_Bludgeon_Hemogoblin'
    InstantHitDamage(BASH_FIREMODE)=27

    // Fire Effects
    WeaponFireSnd(DEFAULT_FIREMODE)=(DefaultCue=AkEvent'WW_WEP_Bleeder.Play_WEP_Bleeder_Fire_3P', FirstPersonCue=AkEvent'WW_WEP_Bleeder.Play_WEP_Bleeder_Fire_1P')  //@TODO: Replace
    WeaponDryFireSnd(DEFAULT_FIREMODE)=AkEvent'WW_WEP_SA_EBR.Play_WEP_SA_EBR_Handling_DryFire'  //@TODO: Replace

    // Custom animations
    FireSightedAnims=(Shoot_Iron, Shoot_Iron2, Shoot_Iron3)

    // Attachments
    bHasIronSights=true
    bHasFlashlight=false
    bHasLaserSight=false

    WeaponFireWaveForm=ForceFeedbackWaveform'FX_ForceFeedback_ARCH.Gunfire.Heavy_Recoil'

    WeaponUpgrades[1]=(IncrementDamage=0.0f,IncrementWeight=0, IncrementHealFullRecharge=0)
    WeaponUpgrades[2]=(IncrementDamage=0.0f,IncrementWeight=0, IncrementHealFullRecharge=0)
}