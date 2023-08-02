
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
    public float maxWeight = 30;
    public float waveTimeScale = 1;
    public float waveLength = 1;

    void FixedUpdate()
    {
        Vector3 posP = Networking.LocalPlayer.GetPosition();
        Vector3 posGO = Skate.transform.position;
        float LengthToSkate = (posP - posGO).magnitude;
        LengthToSkate = Mathf.Pow(LengthToSkate, 0.5f);
        float blendValue = (LengthToSkate + fullWeightCorrect) * weightScale;
        blendValue = Mathf.Clamp(blendValue, 0, maxWeight);
        
        SkinMRend.SetBlendShapeWeight(2, blendValue);

        float WavePosition = Mathf.Sin(Time.time* waveTimeScale)* waveLength;
        Vector3 pos = Skate.transform.position;
        Skate.transform.position = new Vector3(pos.x, pos.y+WavePosition, pos.z);
        //Skate.transform.Rotate(0, WavePosition, 0);
    }
}
