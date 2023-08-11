// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "StecilRead"
{
	Properties
	{
		_Reference("Reference", Int) = 0
		_TextureAlbedo("Texture Albedo", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Smooth("Smooth", Range( 0 , 1)) = 0
		_Color("Color",	Color) = (1.0, 0.6, 0.6, 1.0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		Stencil
		{
			Ref [_Reference]
			Comp Equal
		}
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform int _Reference;
		uniform sampler2D _TextureAlbedo;
		uniform float4 _TextureAlbedo_ST;
		uniform float _Metallic;
		uniform float _Smooth;
		fixed4 _Color;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureAlbedo = i.uv_texcoord * _TextureAlbedo_ST.xy + _TextureAlbedo_ST.zw;
			o.Albedo = (tex2D( _TextureAlbedo, uv_TextureAlbedo ).rgb)*_Color;
			o.Metallic = _Metallic;
			o.Smoothness = _Smooth;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
1060;81;846;910;697;192;1;True;False
Node;AmplifyShaderEditor.SamplerNode;3;-461,-89;Float;True;Property;_TextureAlbedo;Texture Albedo;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;1;-306,488;Float;False;Property;_Reference;Reference;0;0;Create;True;0;0;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-463,167;Float;False;Property;_Metallic;Metallic;2;0;Create;True;0;0;True;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-435,315;Float;False;Property;_Smooth;Smooth;3;0;Create;True;0;0;True;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;StecilRead;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;True;0;True;1;255;False;-1;255;False;-1;5;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;3;0
WireConnection;2;3;6;0
WireConnection;2;4;7;0
ASEEND*/
//CHKSM=424DFA32EB07DC50E3FE9F946841D2790F681F93