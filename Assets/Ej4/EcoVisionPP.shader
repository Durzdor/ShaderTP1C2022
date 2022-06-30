// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "EcoVisionPP"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_speed("speed", Range( 0 , 2)) = 1
		_amplitude("amplitude", Range( 0 , 15)) = 1
		_thickness("thickness", Range( 0 , 1)) = 0.5
		_RealAmplitude("RealAmplitude", Float) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				float4 ase_texcoord4 : TEXCOORD4;
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float _speed;
			UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
			uniform float4 _CameraDepthTexture_TexelSize;
			uniform float _amplitude;
			uniform float _RealAmplitude;
			uniform float _thickness;


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord4 = screenPos;
				
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float2 uv_MainTex = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 color49 = IsGammaSpace() ? float4(0,0.179516,0.7075472,0) : float4(0,0.02707747,0.4588115,0);
				float mulTime54 = _Time.y * _speed;
				float4 screenPos = i.ase_texcoord4;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float eyeDepth95 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
				float4 lerpResult48 = lerp( tex2D( _MainTex, uv_MainTex ) , color49 , saturate( ceil( ( ( sin( ( mulTime54 + ( eyeDepth95 * _amplitude ) ) ) * _RealAmplitude ) + (-0.5 + (_thickness - 0.0) * (0.5 - -0.5) / (1.0 - 0.0)) ) ) ));
				

				finalColor = lerpResult48;

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17200
8;81;1394;950;3291.156;1094.54;2.798768;True;False
Node;AmplifyShaderEditor.CommentaryNode;93;-2010.448,119.4154;Inherit;False;1636.408;473.3285;Version 4;14;64;55;62;54;65;68;56;60;70;72;75;95;92;126;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1960.448,169.4154;Inherit;False;Property;_speed;speed;0;0;Create;True;0;0;False;0;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;95;-1942.461,304.4477;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-1967.546,471.6339;Inherit;False;Property;_amplitude;amplitude;1;0;Create;True;0;0;False;0;1;0;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;54;-1660.148,175.9153;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-1676.009,390.5578;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;65;-1479.259,280.1187;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-1468.258,417.2385;Inherit;False;Property;_RealAmplitude;RealAmplitude;3;0;Create;True;0;0;False;0;0.5;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-1616.197,515.9167;Inherit;False;Property;_thickness;thickness;2;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;68;-1323.077,286.2452;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;126;-1218.01,424.5729;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.5;False;4;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-1170.98,295.3452;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;-963.9342,300.192;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;75;-738.2864,298.9485;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;46;-774.0999,-265.0856;Inherit;False;0;0;_MainTex;Shader;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;47;-657.0999,-268.0856;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;92;-523.9407,299.8105;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;49;-561.7599,-60.9959;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;0,0.179516,0.7075472,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;48;-114.4179,-39.51007;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;45;107.1827,-40.9334;Float;False;True;2;ASEMaterialInspector;0;7;EcoVisionPP;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;0
WireConnection;54;0;55;0
WireConnection;62;0;95;0
WireConnection;62;1;56;0
WireConnection;65;0;54;0
WireConnection;65;1;62;0
WireConnection;68;0;65;0
WireConnection;126;0;60;0
WireConnection;70;0;68;0
WireConnection;70;1;64;0
WireConnection;72;0;70;0
WireConnection;72;1;126;0
WireConnection;75;0;72;0
WireConnection;47;0;46;0
WireConnection;92;0;75;0
WireConnection;48;0;47;0
WireConnection;48;1;49;0
WireConnection;48;2;92;0
WireConnection;45;0;48;0
ASEEND*/
//CHKSM=1458896B635392499E23E4FCE5D12D26FB6862FF