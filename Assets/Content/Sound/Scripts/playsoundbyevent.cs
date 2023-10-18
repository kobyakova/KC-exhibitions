
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class playsoundbyevent : UdonSharpBehaviour
{
   
public AudioSource aud;


   
    public void play_sound()
    {
        aud.Play();
    }
}

