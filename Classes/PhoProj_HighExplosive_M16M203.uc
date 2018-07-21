class PhoProj_HighExplosive_M16M203 extends KFProj_HighExplosive_M16M203;

DefaultProperties
{
        // explosion
    Begin Object Class=KFGameExplosion Name=ExploTemplate0
        Damage=200 //225    //230
        DamageRadius=500           //800
        DamageFalloffExponent=2     //3
        DamageDelay=0.f

        // Damage Effects
        MyDamageType=class'KFDT_Explosive_M16M203'
        KnockDownStrength=0
        FractureMeshRadius=200.0
        FracturePartVel=500.0
        ExplosionEffects=KFImpactEffectInfo'Wep_M16_M203_ARCH.M16_M203_Grenade_Explosion'
        ExplosionSound=AkEvent'WW_WEP_SA_M79.Play_WEP_SA_M79_Explosion'

        // Dynamic Light
        ExploLight=ExplosionPointLight
        ExploLightStartFadeOutTime=0.0
        ExploLightFadeOutTime=0.2

        // Camera Shake
        CamShake=CameraShake'FX_CameraShake_Arch.Grenades.Default_Grenade'
        CamShakeInnerRadius=0
        CamShakeOuterRadius=0
        CamShakeFalloff=1.f
        bOrientCameraShakeTowardsEpicenter=true
    End Object
    ExplosionTemplate=ExploTemplate0
}
