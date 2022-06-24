// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DeepWater"
{
	Properties
	{
		_Foam("Foam", Range( 0 , 0.1)) = 0.05586719
		_int("int", Range( 0 , 1)) = 0
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
		uniform float _Foam;
		uniform float _int;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth36 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth36 = saturate( abs( ( screenDepth36 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( ( 1.0 - _Foam ) ) ) );
			float FoamMask45 = distanceDepth36;
			float4 color5 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			float4 color1 = IsGammaSpace() ? float4(0.2342916,0.6132076,0.5962049,0) : float4(0.04481259,0.3341808,0.3141351,0);
			float screenDepth2 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth2 = saturate( abs( ( screenDepth2 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 6.0 ) ) );
			float DepthMask46 = ( _int * ( 1.0 - distanceDepth2 ) );
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
8;81;1394;950;1555.325;365.446;1.479439;True;False
Node;AmplifyShaderEditor.CommentaryNode;39;257.5286,155.8986;Inherit;False;989.1766;264.2247;Depthmask;6;23;24;35;2;3;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;38;255.7508,-53.71931;Inherit;False;1029.167;175.2;Foam Mask;4;45;36;8;16;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;3;307.5286,324.8193;Inherit;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;6;6.6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;305.7505,14.16064;Inherit;False;Property;_Foam;Foam;0;0;Create;True;0;0;False;0;0.05586719;0.0261;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;2;488.7646,308.3645;Inherit;False;True;True;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;35;744.2375,311.2505;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;16;608.6262,17.04205;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;592.9006,205.8985;Inherit;False;Property;_int;int;1;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;931.1602,206.7826;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;36;793.5184,-3.719471;Inherit;False;True;True;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;1088.663,-8.319834;Inherit;False;FoamMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;46;1056.953,203.3931;Inherit;False;DepthMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;66;-1052.243,-167.9479;Inherit;False;973.1187;625.29;Version 3;10;1;5;56;57;44;47;48;71;70;72;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;-1023.766,287.6538;Inherit;False;46;DepthMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-1019.077,376.6924;Inherit;False;45;FoamMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-916.7888,-33.78066;Inherit;False;Constant;_Color1;Color 1;1;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1;-818.3442,160.2626;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;0.2342916,0.6132076,0.5962049,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;48;-632.6697,352.0521;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;72;-888.7201,-122.4743;Inherit;False;45;FoamMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;70;-559.6982,36.27958;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;56;-487.42,215.0025;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;84;257.1937,1108.336;Inherit;False;1022.891;665.1667;Version2;10;74;75;76;77;78;79;80;81;82;83;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;71;-346.3157,54.8904;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;65;281.2562,451.1238;Inherit;False;973.1189;625.2901;Version1;7;58;59;60;61;62;63;64;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;331.2562,960.4139;Inherit;False;45;FoamMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;58;572.3895,691.8005;Inherit;False;Constant;_Color2;Color 0;0;0;Create;True;0;0;False;0;0.2342916,0.6132076,0.5962049,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;60;883.1138,699.4067;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;62;331.6171,874.742;Inherit;False;46;DepthMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;82;984.6439,1335.701;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;61;1089.375,710.0761;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;81;1115.084,1336.065;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;74;843.5396,1495.813;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;79;414.1711,1247.03;Inherit;False;Constant;_Color5;Color 1;1;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;59;571.5792,501.1238;Inherit;False;Constant;_Color3;Color 1;1;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;78;512.6157,1441.073;Inherit;False;Constant;_Color4;Color 0;0;0;Create;True;0;0;False;0;0.2342916,0.6132076,0.5962049,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;77;307.1938,1568.464;Inherit;False;46;DepthMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;76;311.8828,1657.503;Inherit;False;45;FoamMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;75;698.2899,1632.862;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;57;-215.8751,55.25414;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;83;771.2614,1317.09;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;442.2398,1158.336;Inherit;False;45;FoamMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;64;650.33,886.9565;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-26.14812,75.59096;Float;False;True;2;ASEMaterialInspector;0;0;Standard;DeepWater;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;85;-948.7548,584.354;Inherit;False;253.8616;142.9037;No se ve tan smooth mis colores;1;86;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;86;-913.2482,618.3812;Inherit;False;176.9307;101.4794;Quizas tiene un toon?;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;87;-660.2642,582.8746;Inherit;False;166.5748;100;Borde no queda bien;0;;1,1,1,1;0;0
WireConnection;2;0;3;0
WireConnection;35;0;2;0
WireConnection;16;0;8;0
WireConnection;23;0;24;0
WireConnection;23;1;35;0
WireConnection;36;0;16;0
WireConnection;45;0;36;0
WireConnection;46;0;23;0
WireConnection;48;0;44;0
WireConnection;48;1;47;0
WireConnection;70;0;72;0
WireConnection;56;0;5;0
WireConnection;56;1;1;0
WireConnection;56;2;48;0
WireConnection;71;0;70;0
WireConnection;71;1;56;0
WireConnection;60;0;59;0
WireConnection;60;1;58;0
WireConnection;60;2;64;0
WireConnection;82;0;83;0
WireConnection;82;1;74;0
WireConnection;61;0;60;0
WireConnection;81;0;82;0
WireConnection;74;0;79;0
WireConnection;74;1;78;0
WireConnection;74;2;75;0
WireConnection;75;0;77;0
WireConnection;75;1;76;0
WireConnection;57;0;71;0
WireConnection;83;0;80;0
WireConnection;64;0;62;0
WireConnection;64;1;63;0
WireConnection;0;0;57;0
ASEEND*/
//CHKSM=BB8E1BA1FADF53AEDE40BC26577D441073312277