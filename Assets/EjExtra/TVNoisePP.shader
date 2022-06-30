// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TVNoisePP"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_smallNoiseScale("smallNoiseScale", Range( 1 , 10)) = 1
		_smallNoiseAmmount("smallNoiseAmmount", Range( 0 , 0.5)) = 0.3062017
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
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float _smallNoiseAmmount;
			uniform float _smallNoiseScale;
			float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }
			float snoise( float2 v )
			{
				const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
				float2 i = floor( v + dot( v, C.yy ) );
				float2 x0 = v - i + dot( i, C.xx );
				float2 i1;
				i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
				float4 x12 = x0.xyxy + C.xxzz;
				x12.xy -= i1;
				i = mod2D289( i );
				float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
				float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
				m = m * m;
				m = m * m;
				float3 x = 2.0 * frac( p * C.www ) - 1.0;
				float3 h = abs( x ) - 0.5;
				float3 ox = floor( x + 0.5 );
				float3 a0 = x - ox;
				m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
				float3 g;
				g.x = a0.x * x0.x + h.x * x0.y;
				g.yz = a0.yz * x12.xz + h.yz * x12.yw;
				return 130.0 * dot( m, g );
			}
			


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				
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
				float2 uv0124 = i.uv.xy * ( float2( 16,9 ) * _smallNoiseAmmount ) + float2( 0,0 );
				float2 panner106 = ( 1.0 * _Time.y * float2( 0,1 ) + uv0124);
				float simplePerlin2D101 = snoise( panner106*_smallNoiseScale );
				simplePerlin2D101 = simplePerlin2D101*0.5 + 0.5;
				

				finalColor = saturate( ( tex2D( _MainTex, uv_MainTex ) + simplePerlin2D101 ) );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17200
8;81;1394;950;1103.554;303.2051;1;True;False
Node;AmplifyShaderEditor.Vector2Node;72;-487.0037,-109.4604;Inherit;False;Constant;_Ratio;Ratio;1;0;Create;True;0;0;False;0;16,9;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;66;-601.3594,62.95833;Inherit;False;Property;_smallNoiseAmmount;smallNoiseAmmount;2;0;Create;True;0;0;False;0;0.3062017;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;140;-274.0225,-103.2877;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;107;-66.11829,12.65067;Inherit;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;False;0;0,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;124;-90.08614,-126.7637;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;106;153.4998,-22.90426;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;42;174.631,-299.9232;Inherit;False;0;0;_MainTex;Shader;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;107.2758,129.3546;Inherit;False;Property;_smallNoiseScale;smallNoiseScale;0;0;Create;True;0;0;False;0;1;5;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;101;467.0695,-20.73741;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;41;318.4144,-295.7757;Inherit;True;Property;_TextureSample4;Texture Sample 4;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;139;-2288.883,-329.2617;Inherit;False;690.8879;1292.338;Default;7;134;133;135;132;136;137;138;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;753.4155,-135.0329;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-668.6033,925.4114;Inherit;False;Property;_maskScale;maskScale;8;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;70;897.4758,-135.5652;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-380.6223,673.6735;Inherit;False;Property;_linesAmmount;linesAmmount;6;0;Create;True;0;0;False;0;0.4169146;0.4169146;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;110;-281.3248,-492.9215;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;119;-777.5747,-345.3213;Inherit;False;Constant;_Float2;Float 2;6;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;136;-2176.12,421.0563;Inherit;False;Property;_linesScale1;linesScale;5;0;Create;True;0;0;False;0;60;60;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;118;-813.2637,-516.6437;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;115;-441.5309,-492.6825;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;111;-632.3181,-601.263;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-2203.383,756.91;Inherit;False;Property;_maskScale1;maskScale;9;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-641.3412,589.5577;Inherit;False;Property;_linesScale;linesScale;4;0;Create;True;0;0;False;0;60;60;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;132;-2234.728,-8.159781;Inherit;False;Property;_smallNoiseScale1;smallNoiseScale;1;0;Create;True;0;0;False;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;112;-792.3571,-610.4554;Inherit;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;137;-1897.995,60.34589;Inherit;False;Property;_smallNoiseAmmount1;smallNoiseAmmount;3;0;Create;True;0;0;False;0;0.3062017;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;133;-1915.401,505.1722;Inherit;False;Property;_linesAmmount1;linesAmmount;7;0;Create;True;0;0;False;0;0.4169146;0.4169146;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-1938.714,847.0768;Inherit;False;Property;_maskAmmount1;maskAmmount;11;0;Create;True;0;0;False;0;0.4750503;0.4750503;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;114;-584.0106,-411.7863;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;138;-2238.883,-279.2617;Inherit;False;Constant;_Ratio1;Ratio;1;0;Create;True;0;0;False;0;16,9;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;100;-403.9349,1015.578;Inherit;False;Property;_maskAmmount;maskAmmount;10;0;Create;True;0;0;False;0;0.4750503;0.4750503;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;40;1053.919,-158.2961;Float;False;True;2;ASEMaterialInspector;0;7;TVNoisePP;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;0
WireConnection;140;0;72;0
WireConnection;140;1;66;0
WireConnection;124;0;140;0
WireConnection;106;0;124;0
WireConnection;106;2;107;0
WireConnection;101;0;106;0
WireConnection;101;1;61;0
WireConnection;41;0;42;0
WireConnection;69;0;41;0
WireConnection;69;1;101;0
WireConnection;70;0;69;0
WireConnection;110;0;115;0
WireConnection;115;0;111;0
WireConnection;115;1;114;0
WireConnection;111;0;112;0
WireConnection;114;0;118;2
WireConnection;114;1;119;0
WireConnection;40;0;70;0
ASEEND*/
//CHKSM=BC5BC189D64FF5E795B863901EA30A558EF18D97