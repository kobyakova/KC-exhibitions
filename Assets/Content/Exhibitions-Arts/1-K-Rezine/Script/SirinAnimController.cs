
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class SirinAnimController : UdonSharpBehaviour
{
    public int[] randChances;
    public Animator Anis;
    public int animID;
    int randVal; 



    public GameObject Mask;
    Quaternion maskTrueVec;
    Vector3 maskTruePos;
    public GameObject mainStatic;
    public GameObject face;
    public float maskLooseLenght;
    public ParticleSystem parSys;

    int chancesWeight=0;

    bool eqMaskNow;
    float evade = 0;
    public float evadeTime;
    bool eqMask;


    Gradient grad = new Gradient();
    GradientColorKey[] colors = new GradientColorKey[2];
    GradientAlphaKey[] alphas = new GradientAlphaKey[2]; 

    void Start()
    {
        for (int i = 0; i < randChances.Length; i++)
        {
            chancesWeight = chancesWeight + randChances[i];
        }
        //Debug.Log(chancesWeight+ " chancesWeight");
        maskTrueVec = Mask.transform.localRotation;
        maskTruePos = Mask.transform.localPosition;

        
        colors[0] = new GradientColorKey(new Color(0.3726415f, 1f, 0.9504718f), 0.5f);
        colors[1] = new GradientColorKey(new Color(1f, 1f, 1f), 1);
        alphas[1] = new GradientAlphaKey(0f, 1f);
    }


    void FixedUpdate()
    {
        randVal = Random.Range(0, chancesWeight+1);
        //Debug.Log(randVal + " randVal");
        int weightCheck = 0;
        int lastWeight = 0;

        //Debug.Log(Time.time + " Time.deltaTime");

        float relive = evade - Time.time;        
        relive = Mathf.Clamp(relive, 0, evadeTime);
        //Debug.Log(relive + " relive");
        float reliveNor =  relive/ evadeTime ;
        //Debug.Log(reliveNor + " reliveNor");

        //Debug.Log(Anis.GetCurrentAnimatorClipInfo(0));
        for (int i = 0; i < randChances.Length; i++)
        {
            
            lastWeight = weightCheck;
            weightCheck = weightCheck + randChances[i];
            if (lastWeight <= randVal & randVal < weightCheck) animID = i;
             
            //Debug.Log(weightCheck + " weightCheck");
        }

        //Debug.Log(AnimID + " AnimID");
        Anis.SetInteger("AnimVar", animID);


        float maskL = Vector3.Distance(Mask.transform.position, face.transform.position);
        //Debug.Log(maskL + " maskL");
        var trailCol = parSys.trails;        
        if (maskL > maskLooseLenght)
        {
            Mask.transform.SetParent(mainStatic.transform);             
            Anis.speed = reliveNor;
            alphas[0] = new GradientAlphaKey(reliveNor, 0f);
            eqMask = false;
        }
        else
        {
            Mask.transform.SetParent(face.transform);
            Mask.transform.localRotation = maskTrueVec;
            Mask.transform.localPosition = maskTruePos;
            Anis.speed = 1-reliveNor;
            alphas[0] = new GradientAlphaKey(1 - reliveNor, 0f);
            eqMask = true;
        }
        grad.SetKeys(colors, alphas);
        trailCol.colorOverLifetime = grad; 

        if (eqMask!=eqMaskNow)
        {
            evade = Time.time + evadeTime;
            //Debug.Log(1-evade  + " evade");
            eqMaskNow = eqMask;
            //Debug.Log("переход"); 
        }
        //Debug.Log(eqMaskNow + " eqMaskNow" + eqMask + " eqMaskNow");
        //Anis.speed = evade - Time.deltaTime;
        //if(evade)



    }
}
