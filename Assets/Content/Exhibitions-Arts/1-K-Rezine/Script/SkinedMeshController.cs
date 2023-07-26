
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class SkinedMeshController : UdonSharpBehaviour
{
    public GameObject Skate;
    public SkinnedMeshRenderer SkinMRend;
    public float fullWeightCorrect;
    public float rotateSpeed;
    public float weightScale;

    void FixedUpdate()
    {
        Vector3 posP = Networking.LocalPlayer.GetPosition();
        Vector3 posGO = Skate.transform.position;
        float LengthToSkate = (posP - posGO).magnitude;
        LengthToSkate = Mathf.Pow(LengthToSkate, 0.5f);
        float blendValue = (LengthToSkate + fullWeightCorrect) * weightScale;
        blendValue = Mathf.Clamp(blendValue, 0, 100);
        
        SkinMRend.SetBlendShapeWeight(2, blendValue);


        Skate.transform.Rotate(0,0,rotateSpeed * Time.time);
    }
}
