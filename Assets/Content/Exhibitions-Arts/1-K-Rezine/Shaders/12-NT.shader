// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "12-NT"
{
	Properties
	{
		_7LunnayaPrica_Albedo("7-LunnayaPrica_Albedo", 2D) = "white" {}
		_7LunnayaPrica_AO("7-LunnayaPrica_AO", 2D) = "white" {}
		[Normal]_7LunnayaPrica_nrm("7-LunnayaPrica_nrm", 2D) = "bump" {}
		_AO("AO", Range( 0 , 1)) = 0
		_SmoothCor("SmoothCor", Range( 0 , 1)) = 0
		_7Smooth("7-Smooth", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Off
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			half2 uv_texcoord;
		};

		uniform sampler2D _7LunnayaPrica_nrm;
		uniform half4 _7LunnayaPrica_nrm_ST;
		uniform sampler2D _7LunnayaPrica_Albedo;
		uniform half4 _7LunnayaPrica_Albedo_ST;
		uniform sampler2D _7Smooth;
		uniform half4 _7Smooth_ST;
		uniform half _SmoothCor;
		uniform sampler2D _7LunnayaPrica_AO;
		uniform half4 _7LunnayaPrica_AO_ST;
		uniform half _AO;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_7LunnayaPrica_nrm = i.uv_texcoord * _7LunnayaPrica_nrm_ST.xy + _7LunnayaPrica_nrm_ST.zw;
			o.Normal = UnpackNormal( tex2D( _7LunnayaPrica_nrm, uv_7LunnayaPrica_nrm ) );
			float2 uv_7LunnayaPrica_Albedo = i.uv_texcoord * _7LunnayaPrica_Albedo_ST.xy + _7LunnayaPrica_Albedo_ST.zw;
			half4 tex2DNode1 = tex2D( _7LunnayaPrica_Albedo, uv_7LunnayaPrica_Albedo );
			o.Albedo = tex2DNode1.rgb;
			float2 uv_7Smooth = i.uv_texcoord * _7Smooth_ST.xy + _7Smooth_ST.zw;
			float4 temp_output_24_0 = ( 1.0 - ( ( 1.0 - tex2D( _7Smooth, uv_7Smooth ) ) * _SmoothCor ) );
			o.Metallic = temp_output_24_0.r;
			o.Smoothness = temp_output_24_0.r;
			float2 uv_7LunnayaPrica_AO = i.uv_texcoord * _7LunnayaPrica_AO_ST.xy + _7LunnayaPrica_AO_ST.zw;
			o.Occlusion = ( 1.0 - ( ( 1.0 - tex2D( _7LunnayaPrica_AO, uv_7LunnayaPrica_AO ) ) * _AO ) ).r;
			o.Alpha = tex2DNode1.a;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
882;81;1029;910;400.7476;551.06;1.3;True;False
Node;AmplifyShaderEditor.SamplerNode;2;-642.2242,595.6287;Float;True;Property;_7LunnayaPrica_AO;7-LunnayaPrica_AO;1;0;Create;True;0;0;False;0;3f99457902e64dc4b90221199b1887ae;3f99457902e64dc4b90221199b1887ae;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;20;-492.4518,96.8197;Float;True;Property;_7Smooth;7-Smooth;6;0;Create;True;0;0;False;0;3f4d77a04fa576d48b19093e8f43821e;3f4d77a04fa576d48b19093e8f43821e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-207.1343,641.9028;Float;False;Property;_AO;AO;4;0;Create;True;0;0;True;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-10.20155,125.3374;Float;False;Property;_SmoothCor;SmoothCor;5;0;Create;True;0;0;True;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;15;-230.7393,479.5159;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;23;-179.7475,153.5399;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;30.9738,505.9073;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;81.0065,19.24193;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;4;-892.2816,-151.7821;Float;True;Property;_7LunnayaPrica_nrm;7-LunnayaPrica_nrm;3;1;[Normal];Create;True;0;0;False;0;002f67ce88dcbee448de15f3efbb92a2;002f67ce88dcbee448de15f3efbb92a2;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-35.20176,-454.1898;Float;True;Property;_7LunnayaPrica_Albedo;7-LunnayaPrica_Albedo;0;0;Create;True;0;0;False;0;d581ed76f97e5d742b87abb878827042;d581ed76f97e5d742b87abb878827042;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-284.4964,-343.4863;Float;True;Property;_7LunnayaPrica_metall;7-LunnayaPrica_metall;2;0;Create;True;0;0;False;0;e4ccfa78b96527e49ba5449ff4678e28;e4ccfa78b96527e49ba5449ff4678e28;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;17;98.60833,351.1108;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;24;236.2525,27.43993;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;541.507,-152.8896;Half;False;True;2;Half;ASEMaterialInspector;0;0;Standard;12-NT;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;2;Custom;0.4;True;True;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;7;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;2;0
WireConnection;23;0;20;0
WireConnection;16;0;15;0
WireConnection;16;1;14;0
WireConnection;22;0;23;0
WireConnection;22;1;21;0
WireConnection;17;0;16;0
WireConnection;24;0;22;0
WireConnection;0;0;1;0
WireConnection;0;1;4;0
WireConnection;0;3;24;0
WireConnection;0;4;24;0
WireConnection;0;5;17;0
WireConnection;0;9;1;4
ASEEND*/
//CHKSM=590979C9B91BD788F5C2690D53A789CAB8EEDCFF