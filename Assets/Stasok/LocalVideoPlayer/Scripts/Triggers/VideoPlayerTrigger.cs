
using Stasok.Extensions;
using Stasok.Volume;
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

namespace Stasok.LocalVideoPlayer
{
    [RequireComponent(typeof(BoxCollider))]
    [UdonBehaviourSyncMode(BehaviourSyncMode.None)]
    public class VideoPlayerTrigger : UdonSharpBehaviour 
    {
        [SerializeField] private LocalVideoPlayer videoPlayer;
        [SerializeField] private VRCUrl URL;
        [Space(8)]
        [SerializeField] private Renderer rendererVideoRecipient;
        [Space(16)]
        [SerializeField] private Transform audioTargetPoint;
        [SerializeField] private Transform volumeTargetPoint;
        [SerializeField] private Transform accessDeniedTargetPoint;

        private SmoothVolumeChanger _smoothVolumeChanger;

        private void Start()
        {
            if (videoPlayer.RemoveTriggerRenderers)
            {
                Renderer r = GetComponent<Renderer>();
                if (r) Destroy(r);
            }

            _smoothVolumeChanger = videoPlayer.SmoothVolumeChanger;
            if (rendererVideoRecipient) rendererVideoRecipient.enabled = false;
        }

        public override void OnPlayerTriggerEnter(VRCPlayerApi player) => HandleTrigger(player, true);
        public override void OnPlayerTriggerExit(VRCPlayerApi player) => HandleTrigger(player, false);

        private void HandleTrigger(VRCPlayerApi player, bool transitionState)
        {
            if (!player.isLocal) return;

            if (transitionState)
            {
                if (audioTargetPoint) _smoothVolumeChanger.AudioSource.transform.CopyPosAndRot(audioTargetPoint);
                if (volumeTargetPoint) _smoothVolumeChanger.UIVolumeSetting.transform.CopyPosAndRot(volumeTargetPoint);
                if (accessDeniedTargetPoint) videoPlayer.ErrAccessDenied.transform.CopyPosAndRot(accessDeniedTargetPoint);

                videoPlayer.PlayURL(URL);
            }
            else videoPlayer.SmoothPause();

            if (volumeTargetPoint) _smoothVolumeChanger.UIVolumeSetting.gameObject.SetActive(transitionState);
            if (rendererVideoRecipient) rendererVideoRecipient.enabled = transitionState;
        }
    }
}