// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Lamp"
{
	Properties
	{
		_Lamp_Base_color("Lamp_Base_color", 2D) = "white" {}
		_Lamp_Emissive1("Lamp_Emissive1", 2D) = "white" {}
		_Lamp_Metallic("Lamp_Metallic", 2D) = "white" {}
		_pow("pow", Float) = 1
		_Lamp_Roughness("Lamp_Roughness", 2D) = "white" {}
		_Emi("Emi", Float) = 1
		_Offset("Offset", Float) = 3
		_Lenght("Lenght", Float) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float eyeDepth;
		};

		uniform sampler2D _Lamp_Base_color;
		uniform float4 _Lamp_Base_color_ST;
		uniform sampler2D _Lamp_Emissive1;
		uniform float4 _Lamp_Emissive1_ST;
		uniform float _Lenght;
		uniform float _Offset;
		uniform float _pow;
		uniform float _Emi;
		uniform sampler2D _Lamp_Metallic;
		uniform float4 _Lamp_Metallic_ST;
		uniform sampler2D _Lamp_Roughness;
		uniform float4 _Lamp_Roughness_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Lamp_Base_color = i.uv_texcoord * _Lamp_Base_color_ST.xy + _Lamp_Base_color_ST.zw;
			o.Albedo = tex2D( _Lamp_Base_color, uv_Lamp_Base_color ).rgb;
			float2 uv_Lamp_Emissive1 = i.uv_texcoord * _Lamp_Emissive1_ST.xy + _Lamp_Emissive1_ST.zw;
			float cameraDepthFade13 = (( i.eyeDepth -_ProjectionParams.y - _Offset ) / _Lenght);
			float clampResult18 = clamp( pow( ( 1.0 - cameraDepthFade13 ) , _pow ) , (float)1 , 10000000.0 );
			o.Emission = ( tex2D( _Lamp_Emissive1, uv_Lamp_Emissive1 ) * clampResult18 * _Emi ).rgb;
			float2 uv_Lamp_Metallic = i.uv_texcoord * _Lamp_Metallic_ST.xy + _Lamp_Metallic_ST.zw;
			o.Metallic = tex2D( _Lamp_Metallic, uv_Lamp_Metallic ).r;
			float2 uv_Lamp_Roughness = i.uv_texcoord * _Lamp_Roughness_ST.xy + _Lamp_Roughness_ST.zw;
			o.Smoothness = ( 1.0 - tex2D( _Lamp_Roughness, uv_Lamp_Roughness ) ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
1159;81;747;910;1105.956;57.38043;1.740201;True;True
Node;AmplifyShaderEditor.RangedFloatNode;15;-1218.981,418.337;Float;False;Property;_Offset;Offset;7;0;Create;True;0;0;False;0;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1330.645,263.7584;Float;False;Property;_Lenght;Lenght;8;0;Create;True;0;0;False;0;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CameraDepthFade;13;-997.5969,184.6629;Float;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-717.7236,465.635;Float;False;Property;_pow;pow;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;14;-723.1467,115.8897;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;25;-492.8695,231.6814;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;17;-371.5355,468.4906;Float;False;Constant;_Int3;Int 3;6;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.SamplerNode;3;-624.2551,-206.4379;Float;True;Property;_Lamp_Emissive1;Lamp_Emissive1;1;0;Create;True;0;0;False;0;c38d2287e30ad0c468a405fe3918265d;c38d2287e30ad0c468a405fe3918265d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;18;-248.5438,20.58588;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1E+07;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-208.5292,144.3347;Float;False;Property;_Emi;Emi;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-546.2534,1078.837;Float;True;Property;_Lamp_Roughness;Lamp_Roughness;5;0;Create;True;0;0;False;0;369ebca1a9cc8684ca4b932b09d0b797;369ebca1a9cc8684ca4b932b09d0b797;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-352.3137,-419.1242;Float;True;Property;_Lamp_Base_color;Lamp_Base_color;0;0;Create;True;0;0;False;0;183560b25206bd54dae2734c87670a9b;183560b25206bd54dae2734c87670a9b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;65.51197,1139.899;Float;True;Property;_Lamp_Height;Lamp_Height;4;0;Create;True;0;0;False;0;46df101cee8da9d46822d3895e097182;46df101cee8da9d46822d3895e097182;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;29.54868,-87.47647;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;8;-87.28955,1030.058;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;4;-273.8044,663.8335;Float;True;Property;_Lamp_Metallic;Lamp_Metallic;2;0;Create;True;0;0;False;0;9d4d8314802bc394dbee52cbb7c9b5e6;9d4d8314802bc394dbee52cbb7c9b5e6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;330,-95;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Lamp;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;19;0
WireConnection;13;1;15;0
WireConnection;14;0;13;0
WireConnection;25;0;14;0
WireConnection;25;1;26;0
WireConnection;18;0;25;0
WireConnection;18;1;17;0
WireConnection;9;0;3;0
WireConnection;9;1;18;0
WireConnection;9;2;10;0
WireConnection;8;0;7;0
WireConnection;0;0;2;0
WireConnection;0;2;9;0
WireConnection;0;3;4;0
WireConnection;0;4;8;0
ASEEND*/
//CHKSM=158BF23649E99F9F9CD37BC2B7761CEAD11D0F18