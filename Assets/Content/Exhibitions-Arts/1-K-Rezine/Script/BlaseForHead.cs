
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class BlaseForHead : UdonSharpBehaviour
{

    public GameObject Bubble;
    public GameObject ForSprite;
    public float TimeStart;
    public float TimeEnd;
    public bool isStage;
    void FixedUpdate()
    {        
        
       if(isStage == true) //були були надуй пузырь
        {
            Bubble.gameObject.SetActive(true);
            ForSprite.gameObject.SetActive(false);
            TimeStart += Time.deltaTime;
            if(TimeStart < TimeEnd) //Запуск события по оконсанию времени
        {
           Bubble.transform.localScale = Bubble.transform.localScale + new Vector3(35f, 35f, 35f) * Time.deltaTime;
        }
        if(TimeStart >= TimeEnd + Random.Range (-2.5f, 0.5f)) //Запуск события по оконсанию времени
        {
            TimeStart = 0f;
            isStage = !isStage;
        } 
        }else{ //були були сдуй пузырь и спрячь его

            Bubble.transform.localScale = new Vector3(1f, 1f, 1f);
            Bubble.gameObject.SetActive(false);
            ForSprite.gameObject.SetActive(true);    
            TimeStart += Time.deltaTime;
            if(TimeStart >= 0.1f) //Запуск события по оконсанию времени
            {
                TimeStart = 0f;
                isStage = !isStage;
            }
        }
    }
}
