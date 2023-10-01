Shader "Unlit/SuperFasterUnlit-Color2"
 {
    Properties{

        [NoScaleOffset]
        _Color("Main Color", Color) = (1,1,1,1)
    }

        SubShader{
            Tags { "RenderType" = "Opaque" }
            LOD 100
            Cull Off
            Pass {
                CGPROGRAM
                    #pragma vertex vert
                    #pragma fragment frag
                    #pragma target 2.0
                    #pragma multi_compile_fog

                    #include "UnityCG.cginc"

                    struct appdata_t {
                        float4 vertex : POSITION;
                        float2 texcoord : TEXCOORD0;
                        UNITY_VERTEX_INPUT_INSTANCE_ID
                    };

                    struct v2f {
                        float4 vertex : SV_POSITION;
                        float2 texcoord : TEXCOORD0;
                        UNITY_FOG_COORDS(1)
                        UNITY_VERTEX_OUTPUT_STEREO
                    };

                    fixed4 _Color;

                    v2f vert(appdata_t v)
                    {
                        v2f o;
                        UNITY_SETUP_INSTANCE_ID(v);
                        UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                        o.vertex = UnityObjectToClipPos(v.vertex);

                        o.texcoord = v.texcoord;
                        UNITY_TRANSFER_FOG(o, o.vertex);
                        return o;
                    }

                    fixed4 frag(v2f i) : SV_Target
                    {
                     fixed4 col = _Color;
                     UNITY_APPLY_FOG(i.fogCoord, col);
                     UNITY_OPAQUE_ALPHA(col.a);
                     return col;
                    }
                        ENDCG
                   }
    }
}