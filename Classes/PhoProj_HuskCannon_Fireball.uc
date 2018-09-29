//=============================================================================
// KFProj_HuskCannon_Fireball
//=============================================================================
// Player version for the Husk Cannon of the Husk fire ball.
//=============================================================================
// Killing Floor 2
// Copyright (C) 2017 Tripwire Interactive LLC
//=============================================================================
class PhoProj_HuskCannon_Fireball extends KFProj_HuskCannon_Fireball;

defaultproperties
{


	Begin Object Class=KFGameExplosion Name=ExploTemplate2
		Damage=65 //100		//80
		DamageRadius=100 //450 //550	//100
		DamageFalloffExponent=1.f //1.0
		DamageDelay=0.f

		// Damage Effects
		MyDamageType=class'KFDT_Explosive_HuskCannon'
		bCausesFracture=true
		MomentumTransferScale=6000.f
		KnockDownStrength=100
		FractureMeshRadius=200.0
		FracturePartVel=100.0
		ExplosionEffects=KFImpactEffectInfo'FX_Impacts_ARCH.Explosions.HuskProjectile_Explosion'
		ExplosionSound=AkEvent'WW_ZED_Husk.ZED_Husk_SFX_Ranged_Shot_Impact'
		ExplosionEmitterScale=2.f

		// Dynamic Light
		ExploLight=ExplosionPointLight
		ExploLightStartFadeOutTime = 0.0
		ExploLightFadeOutTime = 0.5

		// Camera Shake
		// Camera Shake
		CamShake = none
		bOrientCameraShakeTowardsEpicenter=true

		bIgnoreInstigator=false
    End Object
	ExplosionTemplate=ExploTemplate2


}
