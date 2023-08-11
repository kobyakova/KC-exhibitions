
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ToDel_ScaleSystemTest : UdonSharpBehaviour
{
    VRCPlayerApi playerApi;

    void Start()
    {
        //playerApi = Networking.LocalPlayer;
        //VRCPlayerApi._SetAvatarEyeHeightByMeters(VRCPlayerApi., 2);
        Networking.LocalPlayer.SetAvatarEyeHeightByMeters(0.01f);
    }
}
