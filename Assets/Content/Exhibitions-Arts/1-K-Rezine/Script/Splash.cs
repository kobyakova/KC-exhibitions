
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Splash : UdonSharpBehaviour
{
    public GameObject Target;
    public float splashPos;
    public ParticleSystem splashParticle;

    void FixedUpdate()
    {
        float rot = Target.transform.position.y;
        if(-rot< splashPos)
        {
            splashParticle.Play();

        }
        else
        {
            splashParticle.Stop();
        }
    }
}
