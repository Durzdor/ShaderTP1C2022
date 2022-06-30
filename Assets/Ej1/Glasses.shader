// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Glasses"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+1" "IgnoreProjector" = "True" }
		Cull Back
		Stencil
		{
			Ref 3
			Comp Less
			Pass Replace
			Fail Replace
		}
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow 
		struct Input
		{
			half filler;
		};

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17200
8;81;1394;950;2782.327;1742.174;3.645709;True;False
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;ASEMaterialInspector;0;0;Standard;Glasses;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;1;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;True;3;False;-1;255;False;-1;255;False;-1;3;False;-1;3;False;-1;3;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
ASEEND*/
//CHKSM=636576CA99B12A1C842C23F1480E3512DFAE7FCA