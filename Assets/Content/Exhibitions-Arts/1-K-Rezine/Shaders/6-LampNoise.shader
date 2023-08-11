// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "LampNoise"
{
	Properties
	{
		_Lamp_Base_color("Lamp_Base_color", 2D) = "white" {}
		_Lamp_Emissive1("Lamp_Emissive1", 2D) = "white" {}
		_Lamp_Metallic("Lamp_Metallic", 2D) = "white" {}
		_pow("pow", Float) = 1
		_Lamp_Roughness("Lamp_Roughness", 2D) = "white" {}
		_Offset("Offset", Float) = 3
		_Lenght("Lenght", Float) = 0.5
		_TimeScale("TimeScale", Float) = 1
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
		uniform float _TimeScale;
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
			float cameraDepthFade3 = (( i.eyeDepth -_ProjectionParams.y - _Offset ) / _Lenght);
			float clampResult10 = clamp( pow( ( 1.0 - cameraDepthFade3 ) , _pow ) , (float)1 , 10000000.0 );
			float mulTime19 = _Time.y * _TimeScale;
			float3 temp_cast_2 = (mulTime19).xxx;
			float dotResult18 = dot( float3(12.9898,78.233,37.719) , temp_cast_2 );
			float clampResult24 = clamp( frac( ( dotResult18 * 143758.5 ) ) , 0.5 , 1.0 );
			o.Emission = ( tex2D( _Lamp_Emissive1, uv_Lamp_Emissive1 ) * clampResult10 * clampResult24 ).rgb;
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
1159;81;747;910;381.0687;378.0663;1.35501;True;False
Node;AmplifyShaderEditor.RangedFloatNode;21;-1143.498,627.3723;Float;False;Property;_TimeScale;TimeScale;9;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1;-1505.943,212.0433;Float;False;Property;_Offset;Offset;7;0;Create;True;0;0;False;0;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1617.607,57.46478;Float;False;Property;_Lenght;Lenght;8;0;Create;True;0;0;False;0;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;19;-801.9962,641.7913;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;22;-763.8992,369.9725;Float;False;Constant;_Vector0;Vector 0;10;0;Create;True;0;0;False;0;12.9898,78.233,37.719;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CameraDepthFade;3;-1284.559,-21.63076;Float;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;18;-446.049,435.413;Float;False;2;0;FLOAT3;12.9898,0,0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1004.687,259.3412;Float;False;Property;_pow;pow;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;5;-1010.11,-90.40393;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-271.4535,414.3232;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;143758.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;20;-129.4982,280.2727;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;6;-779.8326,25.38778;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;7;-741.1452,191.7946;Float;False;Constant;_Int3;Int 3;6;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.SamplerNode;8;-69.29897,849.9806;Float;True;Property;_Lamp_Roughness;Lamp_Roughness;5;0;Create;True;0;0;False;0;369ebca1a9cc8684ca4b932b09d0b797;369ebca1a9cc8684ca4b932b09d0b797;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-614.304,-262.744;Float;True;Property;_Lamp_Emissive1;Lamp_Emissive1;1;0;Create;True;0;0;False;0;c38d2287e30ad0c468a405fe3918265d;c38d2287e30ad0c468a405fe3918265d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;10;-238.5928,-35.72025;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1E+07;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;24;-21.29688,165.5938;Float;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;98.72178,297.0285;Float;False;Property;_Emi;Emi;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-342.3628,-475.4302;Float;True;Property;_Lamp_Base_color;Lamp_Base_color;0;0;Create;True;0;0;False;0;183560b25206bd54dae2734c87670a9b;183560b25206bd54dae2734c87670a9b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;13;-130.6845,631.6195;Float;True;Property;_Lamp_Metallic;Lamp_Metallic;2;0;Create;True;0;0;False;0;9d4d8314802bc394dbee52cbb7c9b5e6;9d4d8314802bc394dbee52cbb7c9b5e6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;15;375.7428,797.7213;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;14;221.1601,1065.384;Float;True;Property;_Lamp_Height;Lamp_Height;4;0;Create;True;0;0;False;0;46df101cee8da9d46822d3895e097182;46df101cee8da9d46822d3895e097182;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;39.49976,-143.7827;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;528,-115;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;LampNoise;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;21;0
WireConnection;3;0;2;0
WireConnection;3;1;1;0
WireConnection;18;0;22;0
WireConnection;18;1;19;0
WireConnection;5;0;3;0
WireConnection;23;0;18;0
WireConnection;20;0;23;0
WireConnection;6;0;5;0
WireConnection;6;1;4;0
WireConnection;10;0;6;0
WireConnection;10;1;7;0
WireConnection;24;0;20;0
WireConnection;15;0;8;0
WireConnection;16;0;11;0
WireConnection;16;1;10;0
WireConnection;16;2;24;0
WireConnection;0;0;12;0
WireConnection;0;2;16;0
WireConnection;0;3;13;0
WireConnection;0;4;15;0
ASEEND*/
//CHKSM=347646FA93634ECCDE6FCB0F6293E4F13665D11A