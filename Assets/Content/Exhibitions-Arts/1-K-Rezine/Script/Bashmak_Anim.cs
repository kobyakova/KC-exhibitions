
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Bashmak_Anim : UdonSharpBehaviour
{
    public Animator m_AnimatorBash;
public void BoolAnimOn()
{
    m_AnimatorBash.SetBool("an_start", true);
}
public void BoolAnimOff()
{
    m_AnimatorBash.SetBool("an_start", false);
}
}
