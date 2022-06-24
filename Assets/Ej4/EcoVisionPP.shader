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
		_nose("nose", Float) = 0.5
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
			uniform float _nose;
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
				float4 lerpResult48 = lerp( tex2D( _MainTex, uv_MainTex ) , color49 , saturate( ceil( ( ( sin( ( mulTime54 + ( eyeDepth95 * _amplitude ) ) ) * _nose ) + _thickness ) ) ));
				

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
8;81;1400;950;2401.66;297.2482;1.293173;True;False
Node;AmplifyShaderEditor.CommentaryNode;93;-2010.448,119.4154;Inherit;False;1636.408;473.3285;Version 4;13;64;55;62;54;65;68;56;60;70;72;75;95;92;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1960.448,169.4154;Inherit;False;Property;_speed;speed;0;0;Create;True;0;0;False;0;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;95;-1942.461,304.4477;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-1967.546,471.6339;Inherit;False;Property;_amplitude;amplitude;3;0;Create;True;0;0;False;0;1;0;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;54;-1660.148,175.9153;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-1676.009,390.5578;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;65;-1479.259,280.1187;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-1468.258,417.2385;Inherit;False;Property;_nose;nose;9;0;Create;True;0;0;False;0;0.5;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;68;-1323.077,286.2452;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-1411.197,497.9167;Inherit;False;Property;_thickness;thickness;6;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-1170.98,295.3452;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;-963.9342,300.192;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;75;-738.2864,298.9485;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;46;-774.0999,-265.0856;Inherit;False;0;0;_MainTex;Shader;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;91;35.8054,199.2415;Inherit;False;1436.346;484.0708;Version 1;12;79;80;81;82;83;84;85;86;87;88;89;90;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;49;-561.7599,-60.9959;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;0,0.179516,0.7075472,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;125;45.27619,1231.981;Inherit;False;1684.507;489.3285;Version3;13;112;113;114;115;116;117;118;119;120;121;122;123;124;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;109;51.07413,709.3614;Inherit;False;1684.508;490.5693;Version 2;13;105;102;106;108;99;100;101;103;104;107;96;97;98;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;92;-523.9407,299.8105;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;47;-657.0999,-268.0856;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;96;129.4061,924.1365;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;106;1097.588,890.1379;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;709.9044,575.3129;Inherit;False;Constant;_Grosordenegro;Grosor de negro;5;0;Create;True;0;0;False;0;0.05791105;3;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;395.8589,930.0699;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;100;401.3739,765.8613;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;103;747.5454,870.9911;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;116;390.0611,1452.69;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;98.52424,1533.766;Inherit;False;Property;_ampli;ampli;4;0;Create;True;0;0;False;0;1;0;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;85;722.6595,325.6463;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;83;310.9695,254.4996;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;141.3744,478.9245;Inherit;False;Constant;_Frequenciadeblancos;Frequencia de blancos;4;0;Create;True;0;0;False;0;10;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;115;395.5762,1288.481;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;98;101.0741,759.3614;Inherit;False;Property;_Vel;Vel;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;370.9743,384.7253;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;102;696.9224,978.6459;Inherit;False;Property;_amp;amp;11;0;Create;True;0;0;False;0;0.5;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;565.5594,443.5781;Inherit;False;Constant;_Cantidaddenegro;Cantidad de negro;6;0;Create;True;0;0;False;0;1;0;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;81;153.8015,337.8611;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;108;1537.582,889.7565;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;101;582.2631,870.0646;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;90;1274.151,348.9503;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;48;-114.4179,-39.51007;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;884.7444,1407.911;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;122;1091.791,1412.758;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;878.6589,338.6465;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;123;1317.438,1411.514;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;112;95.27618,1281.981;Inherit;False;Property;_spd;spd;1;0;Create;True;0;0;False;0;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;114;123.6082,1446.756;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;80;52.00627,257.0419;Inherit;False;Constant;_Velocidaddepaneo;Velocidad de paneo;3;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;84;557.3776,324.7198;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;182.4786,1044.642;Inherit;False;Property;_freq;freq;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;118;652.1242,1518.166;Inherit;False;Property;_nose2;nose2;10;0;Create;True;0;0;False;0;0.5;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;124;1531.784,1412.376;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;744.7798,1083.93;Inherit;False;Property;_thick;thick;8;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;117;576.4651,1392.685;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;107;1323.236,888.8944;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;89;1058.403,348.6929;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;119;732.6472,1398.811;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;740.2224,1605.31;Inherit;False;Property;_Thik;Thik;7;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;903.5444,883.991;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;45;107.1827,-40.9334;Float;False;True;2;ASEMaterialInspector;0;7;EcoVisionPP;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;0
WireConnection;54;0;55;0
WireConnection;62;0;95;0
WireConnection;62;1;56;0
WireConnection;65;0;54;0
WireConnection;65;1;62;0
WireConnection;68;0;65;0
WireConnection;70;0;68;0
WireConnection;70;1;64;0
WireConnection;72;0;70;0
WireConnection;72;1;60;0
WireConnection;75;0;72;0
WireConnection;92;0;75;0
WireConnection;47;0;46;0
WireConnection;106;0;104;0
WireConnection;106;1;105;0
WireConnection;99;0;96;0
WireConnection;99;1;97;0
WireConnection;100;0;98;0
WireConnection;103;0;101;0
WireConnection;116;0;114;0
WireConnection;116;1;113;0
WireConnection;85;0;84;0
WireConnection;83;0;80;0
WireConnection;115;0;112;0
WireConnection;82;0;81;2
WireConnection;82;1;79;0
WireConnection;108;0;107;0
WireConnection;101;0;100;0
WireConnection;101;1;99;0
WireConnection;90;0;89;0
WireConnection;48;0;47;0
WireConnection;48;1;49;0
WireConnection;48;2;92;0
WireConnection;121;0;119;0
WireConnection;121;1;118;0
WireConnection;122;0;121;0
WireConnection;122;1;120;0
WireConnection;87;0;85;0
WireConnection;87;1;86;0
WireConnection;123;0;122;0
WireConnection;84;0;83;0
WireConnection;84;1;82;0
WireConnection;124;0;123;0
WireConnection;117;0;115;0
WireConnection;117;1;116;0
WireConnection;107;0;106;0
WireConnection;89;0;87;0
WireConnection;89;1;88;0
WireConnection;119;0;117;0
WireConnection;104;0;103;0
WireConnection;104;1;102;0
WireConnection;45;0;48;0
ASEEND*/
//CHKSM=84FFBD3A9B1AECE6BA1DB8F341999D0F317668CB