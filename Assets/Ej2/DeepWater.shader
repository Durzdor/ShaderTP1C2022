// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DeepWater"
{
	Properties
	{
		_Foam("Foam", Range( 0 , 0.1)) = 0.05586719
		_Intensity("Intensity", Range( 0 , 1)) = 0
		_Height("Height", Range( 0 , 0.3)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float4 screenPos;
		};

		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Height;
		uniform float _Foam;
		uniform float _Intensity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth36 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth36 = saturate( abs( ( screenDepth36 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( ( _Height * ( 1.0 - _Foam ) ) ) ) );
			float FoamMask45 = floor( distanceDepth36 );
			float4 color5 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			float4 color1 = IsGammaSpace() ? float4(0.2342916,0.6132076,0.5962049,0) : float4(0.04481259,0.3341808,0.3141351,0);
			float screenDepth2 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth2 = saturate( abs( ( screenDepth2 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 6.0 ) ) );
			float DepthMask46 = ( _Intensity * ( 1.0 - distanceDepth2 ) );
			float4 lerpResult56 = lerp( color5 , color1 , ( DepthMask46 + FoamMask45 ));
			o.Albedo = saturate( ( ( 1.0 - FoamMask45 ) + lerpResult56 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17200
8;81;1394;950;1676.64;1039.161;2.238467;True;False
Node;AmplifyShaderEditor.CommentaryNode;38;255.7508,-53.71931;Inherit;False;1249.131;183.7541;Foam Mask;7;45;36;89;16;90;8;88;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;39;257.5286,155.8986;Inherit;False;989.1766;264.2247;Depthmask;6;23;24;35;2;3;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;8;262.9799,50.82129;Inherit;False;Property;_Foam;Foam;0;0;Create;True;0;0;False;0;0.05586719;0.0261;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;491.8904,-15.63076;Inherit;False;Property;_Height;Height;2;0;Create;True;0;0;False;0;0;0.3;0;0.3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;307.5286,324.8193;Inherit;False;Constant;_Distance;Distance;0;0;Create;True;0;0;False;0;6;6.6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;16;532.0271,54.20099;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;2;488.7646,308.3645;Inherit;False;True;True;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;763.1811,27.14;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;592.9006,205.8985;Inherit;False;Property;_Intensity;Intensity;1;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;36;927.9417,2.390635;Inherit;False;True;True;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;35;744.2375,311.2505;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;931.1602,206.7826;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;88;1172.559,3.921839;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;46;1056.953,203.3931;Inherit;False;DepthMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;1307.406,1.456335;Inherit;False;FoamMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;66;-1052.243,-167.9479;Inherit;False;973.1187;625.29;Version 3;10;1;5;56;57;44;47;48;71;70;72;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;-1023.766,287.6538;Inherit;False;46;DepthMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-1019.077,376.6924;Inherit;False;45;FoamMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-818.3442,160.2626;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;0.2342916,0.6132076,0.5962049,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;-916.7888,-33.78066;Inherit;False;Constant;_Color1;Color 1;1;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;48;-632.6697,352.0521;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;72;-888.7201,-122.4743;Inherit;False;45;FoamMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;70;-559.6982,36.27958;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;56;-487.42,215.0025;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;71;-346.3157,54.8904;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;57;-215.8751,55.25414;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-26.14812,75.59096;Float;False;True;2;ASEMaterialInspector;0;0;Standard;DeepWater;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;8;0
WireConnection;2;0;3;0
WireConnection;89;0;90;0
WireConnection;89;1;16;0
WireConnection;36;0;89;0
WireConnection;35;0;2;0
WireConnection;23;0;24;0
WireConnection;23;1;35;0
WireConnection;88;0;36;0
WireConnection;46;0;23;0
WireConnection;45;0;88;0
WireConnection;48;0;44;0
WireConnection;48;1;47;0
WireConnection;70;0;72;0
WireConnection;56;0;5;0
WireConnection;56;1;1;0
WireConnection;56;2;48;0
WireConnection;71;0;70;0
WireConnection;71;1;56;0
WireConnection;57;0;71;0
WireConnection;0;0;57;0
ASEEND*/
//CHKSM=FA0FCA210801A043E5E430D91D6BAD3D375A8BF4