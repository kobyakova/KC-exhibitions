// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Eshader OEM v1.3"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		[NoScaleOffset]_ORM("ORM", 2D) = "black" {}
		_SmoothCorrect("SmoothCorrect", Range( -1 , 1)) = 0
		[NoScaleOffset][Normal]_Normal("Normal", 2D) = "white" {}
		_NormalScale("NormalScale", Float) = 1
		[IntRange][Enum(Cull Off,0,Front,1,Back,2)]_CullMode("CullMode", Range( 0 , 2)) = 0
		[NoScaleOffset]_Emission("Emission", 2D) = "white" {}
		[HDR]_Emissioncolor("Emission color", Color) = (0,0,0,0)
		_AlphaClip("AlphaClip", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull [_CullMode]
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			half2 uv_texcoord;
		};

		uniform half _AlphaClip;
		uniform half _CullMode;
		uniform sampler2D _Normal;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform half _NormalScale;
		uniform sampler2D _Emission;
		uniform half4 _Emissioncolor;
		uniform sampler2D _ORM;
		uniform half _SmoothCorrect;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv0_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _Normal, uv0_Albedo ), _NormalScale );
			half4 tex2DNode2 = tex2D( _Albedo, uv0_Albedo );
			o.Albedo = tex2DNode2.rgb;
			o.Emission = ( tex2D( _Emission, uv0_Albedo ) * _Emissioncolor ).rgb;
			half4 tex2DNode3 = tex2D( _ORM, uv0_Albedo );
			o.Metallic = tex2DNode3.b;
			float temp_output_4_0 = ( 1.0 - tex2DNode3.g );
			o.Smoothness = ( temp_output_4_0 + _SmoothCorrect );
			o.Occlusion = tex2DNode3.r;
			o.Alpha = 1;
			clip( tex2DNode2.a - _AlphaClip );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
620;90;1291;908;965.5432;355.6292;1.60488;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-849.9103,-353.6654;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-584.5905,539.9365;Float;True;Property;_ORM;ORM;1;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-513.4491,-263.0661;Float;True;Property;_Normal;Normal;3;2;[NoScaleOffset];[Normal];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-523.1386,-29.35347;Float;False;Property;_NormalScale;NormalScale;4;0;Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-518.1923,86.27586;Float;True;Property;_Emission;Emission;6;1;[NoScaleOffset];Create;True;0;0;True;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;4;-198.1473,695.7115;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-503.477,887.3158;Float;False;Property;_SmoothCorrect;SmoothCorrect;2;0;Create;True;0;0;True;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;21;-428.9323,324.2081;Float;False;Property;_Emissioncolor;Emission color;7;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.UnpackScaleNormalNode;16;-194.7619,-77.90814;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-88.32056,143.9888;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1086.567,344.8654;Float;False;Property;_AlphaClip;AlphaClip;8;0;Create;True;0;0;True;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1199.479,126.8654;Float;False;Property;_CullMode;CullMode;5;2;[IntRange];[Enum];Create;True;3;Cull Off;0;Front;1;Back;2;0;True;0;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-91.45021,-389.8066;Float;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;30;80.4937,619.7381;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;68.74899,750.2267;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;347,79;Half;False;True;3;Half;ASEMaterialInspector;0;0;Standard;Eshader OEM v1.3;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;1;False;-1;0;False;-1;0;0;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;10;-1;0;True;12;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;1;25;0
WireConnection;5;1;25;0
WireConnection;14;1;25;0
WireConnection;4;0;3;2
WireConnection;16;0;5;0
WireConnection;16;1;17;0
WireConnection;22;0;14;0
WireConnection;22;1;21;0
WireConnection;2;1;25;0
WireConnection;30;0;4;0
WireConnection;30;1;28;0
WireConnection;29;0;4;0
WireConnection;29;1;28;0
WireConnection;0;0;2;0
WireConnection;0;1;16;0
WireConnection;0;2;22;0
WireConnection;0;3;3;3
WireConnection;0;4;30;0
WireConnection;0;5;3;1
WireConnection;0;10;2;4
ASEEND*/
//CHKSM=B9BF4F545DBA7BBF9C25A559030C144E61170BEE