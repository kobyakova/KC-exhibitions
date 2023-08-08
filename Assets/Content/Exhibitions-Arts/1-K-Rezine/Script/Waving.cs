
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Waving : UdonSharpBehaviour
{
    public float horizantalWav;
    public float rotWav;
    public float HwavTimeScale;
    public float RwavTimeScale;
    void FixedUpdate()
    {
        float WavePosition = Mathf.Sin(Time.time * HwavTimeScale) * horizantalWav;
        Vector3 pos = this.transform.position;
        this.transform.position = new Vector3(pos.x, pos.y + WavePosition, pos.z);

        float Waverot = Mathf.Sin(Time.time * RwavTimeScale) * rotWav;
        this.transform.Rotate(0, Waverot, 0);
    }
}
