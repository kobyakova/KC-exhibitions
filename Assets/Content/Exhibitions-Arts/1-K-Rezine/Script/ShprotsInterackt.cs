
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ShprotsInterackt : UdonSharpBehaviour
{
    public GameObject bigtoDream;
    private VRCPlayerApi _localPl;
    public float workLenght = 1;
    public Animator anim;


    void Start()
    {
        _localPl = Networking.LocalPlayer;
    }

    void Interact()
    {
        if (_localPl.isLocal)
        {

            Vector3 dist = this.transform.position - _localPl.GetPosition();

            if (dist.magnitude < workLenght)
            {
                anim.SetBool("Include", true);

            //bigtoDream.transform.localScale = new Vector3(2, 2, 2);
            }
        }
                
    }

    void FixedUpdate()
    {

        if (_localPl.isLocal)
        {

            Vector3 dist = this.transform.position - _localPl.GetPosition();
            //Debug.Log(dist.magnitude);
            if (dist.magnitude > workLenght)
            {
                anim.SetBool("Include", false);
                //bigtoDream.transform.localScale = new Vector3(0, 0, 0);
            }
        }
    }
}
