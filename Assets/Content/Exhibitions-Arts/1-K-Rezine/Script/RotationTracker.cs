
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class RotationTracker : UdonSharpBehaviour
{
    public Vector3 CenterOffset;
    public bool TrackPlayer;
    public Transform RotatableTransform;
    public Vector3 AdjustmentRotation;
    private Quaternion ZeroRotation;
    public float MaxDetectionDistance = 1f;

    void Start()
    {
        ZeroRotation = RotatableTransform.rotation;
    }

    public void UpdateZeroRotation()
    {
        ZeroRotation = RotatableTransform.localRotation * Quaternion.Inverse(Quaternion.Euler(AdjustmentRotation));
    }

    void FixedUpdate()
    {
        if(!TrackPlayer)
            return;
        if(Vector3.Distance(this.transform.position + CenterOffset, Networking.LocalPlayer.GetPosition()) < MaxDetectionDistance)
            RotatableTransform.rotation = Quaternion.LookRotation((Networking.LocalPlayer.GetBonePosition(HumanBodyBones.Head) - (RotatableTransform.transform.position + CenterOffset)).normalized, Vector3.up) * Quaternion.Euler(AdjustmentRotation);
        else
            RotatableTransform.rotation = ZeroRotation;
    }
}
