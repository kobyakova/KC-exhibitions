
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class SirinAnimController : UdonSharpBehaviour
{
    public int[] randChances;
    public Animator Anis;
    public int animID;
    public bool eqMask;
    
    public GameObject Mask;
    Quaternion maskTrueVec;
    Vector3 maskTruePos;
    public GameObject mainStatic;
    public GameObject face;
    public float maskLooseLenght;
    public ParticleSystem parSys;

    int chancesWeight=0;
    bool maskCheck = true;
    float evade = 0;

    void Start()
    {
        for (int i = 0; i < randChances.Length; i++)
        {
            chancesWeight = chancesWeight + randChances[i];
        }
        //Debug.Log(chancesWeight+ " chancesWeight");
        maskTrueVec = Mask.transform.localRotation;
        maskTruePos = Mask.transform.localPosition;
    }

    void FixedUpdate()
    {
        int randVal = Random.Range(0, chancesWeight+1);
        //Debug.Log(randVal + " randVal");
        int weightCheck = 0;
        int lastWeight = 0;
        



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
        var main = parSys.main;
        if (maskL > maskLooseLenght)
        {
            Mask.transform.SetParent(mainStatic.transform);             
            Anis.speed = 0;            
            main.startColor = new Color(1,1,1,0);
        }
        else
        {
            Mask.transform.SetParent(face.transform);
            Mask.transform.localRotation = maskTrueVec;
            Mask.transform.localPosition = maskTruePos;
            Anis.speed = 1;
            main.startColor = new Color(1, 1, 1, 1);
        }

        if (eqMask==true)
        {
            evade = Time.deltaTime + 1;
            Debug.Log(1-evade  + " evade");
            maskCheck = eqMask;
        }
        
        //Anis.speed = evade - Time.deltaTime;
        //if(evade)



    }
}
