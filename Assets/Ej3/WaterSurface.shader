// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "WaterSurface"
{
	Properties
	{
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 32
		_Frequency("Frequency", Float) = 10
		_Radius("Radius", Float) = 0
		_DarkColor("DarkColor", Range( 0 , 1)) = 0
		_Speed("Speed", Float) = 1
		_Amplitude("Amplitude", Range( 0 , 0.1)) = 3.38
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _Frequency;
		uniform float _Speed;
		uniform float _Radius;
		uniform float _Amplitude;
		uniform float _DarkColor;
		uniform float _TessValue;

		float4 tessFunction( )
		{
			return _TessValue;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 ase_vertex3Pos = v.vertex.xyz;
			float mulTime5 = _Time.y * _Speed;
			float Distance31 = ( 1.0 - ( distance( float3(0,0,0) , ase_vertex3Pos ) * _Radius ) );
			float temp_output_25_0 = sin( ( ( ase_vertex3Pos.y * _Frequency ) + mulTime5 + Distance31 ) );
			float3 temp_cast_0 = (( temp_output_25_0 * 1 * _Amplitude )).xxx;
			v.vertex.xyz += temp_cast_0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color13 = IsGammaSpace() ? float4(0.145098,0.6901961,0.1058824,1) : float4(0.01850021,0.4341537,0.0109601,1);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float mulTime5 = _Time.y * _Speed;
			float Distance31 = ( 1.0 - ( distance( float3(0,0,0) , ase_vertex3Pos ) * _Radius ) );
			float temp_output_25_0 = sin( ( ( ase_vertex3Pos.y * _Frequency ) + mulTime5 + Distance31 ) );
			o.Emission = ( color13 * (_DarkColor + (temp_output_25_0 - 0.0) * (1.0 - _DarkColor) / (1.0 - 0.0)) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17200
8;81;1394;950;1693.747;65.02786;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;29;-1366.749,741.6119;Inherit;False;957.0001;360.4602;Distance;7;31;24;22;19;21;20;23;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;20;-1296.783,791.6119;Inherit;False;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;21;-1316.749,946.3722;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-1121.75,984.0722;Inherit;False;Property;_Radius;Radius;6;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;19;-1125.922,854.3536;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-934.548,854.0729;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;24;-775.9487,854.0724;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;31;-606.9476,848.8723;Inherit;False;Distance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1068.341,304.4672;Inherit;False;Property;_Frequency;Frequency;5;0;Create;True;0;0;False;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;2;-1091.926,148.7424;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-1105.992,400.4891;Inherit;False;Property;_Speed;Speed;8;0;Create;True;0;0;False;0;1;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-892.3901,220.1495;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-968.3475,509.5723;Inherit;False;31;Distance;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;5;-967.9927,399.4891;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-739.0049,272.8049;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-704.3452,53.09727;Inherit;False;Property;_DarkColor;DarkColor;7;0;Create;True;0;0;False;0;0;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;25;-596.5491,272.9724;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;10;-387.3452,-12.90273;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-439.3452,-217.9027;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;False;0;0.145098,0.6901961,0.1058824,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;28;-599.1475,361.3723;Inherit;False;Constant;_Vector1;Vector 1;6;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;16;-703.1685,522.3416;Inherit;False;Property;_Amplitude;Amplitude;9;0;Create;True;0;0;False;0;3.38;0.0101;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-388.5475,272.9724;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-177.3452,-47.90273;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;6;ASEMaterialInspector;0;0;Standard;WaterSurface;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;1;32;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;20;0
WireConnection;19;1;21;0
WireConnection;22;0;19;0
WireConnection;22;1;23;0
WireConnection;24;0;22;0
WireConnection;31;0;24;0
WireConnection;17;0;2;2
WireConnection;17;1;8;0
WireConnection;5;0;6;0
WireConnection;18;0;17;0
WireConnection;18;1;5;0
WireConnection;18;2;32;0
WireConnection;25;0;18;0
WireConnection;10;0;25;0
WireConnection;10;3;11;0
WireConnection;26;0;25;0
WireConnection;26;1;28;2
WireConnection;26;2;16;0
WireConnection;12;0;13;0
WireConnection;12;1;10;0
WireConnection;0;2;12;0
WireConnection;0;11;26;0
ASEEND*/
//CHKSM=275B1CBE095F3AFC17D099F4F3C6FE66810E3FCE