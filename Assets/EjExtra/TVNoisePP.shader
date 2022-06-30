// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TVNoisePP"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
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
				o.ase_texcoord4 = v.vertex;
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
				float2 temp_cast_0 = (sin( ( _Time.y + ( i.ase_texcoord4.xyz.y * 10.0 ) ) )).xx;
				float2 panner106 = ( 1.0 * _Time.y * float2( 0,1 ) + temp_cast_0);
				float simplePerlin2D101 = snoise( panner106 );
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
8;81;1394;950;1595.394;698.2093;1.46907;True;False
Node;AmplifyShaderEditor.RangedFloatNode;112;-531.2529,-318.4695;Inherit;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;118;-772.5538,-341.1714;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;119;-721.423,-162.8301;Inherit;False;Constant;_Float2;Float 2;6;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;114;-432.4019,-171.7402;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;111;-385.2525,-306.4695;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;115;-228.1566,-183.8513;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;110;-79.85806,-167.3432;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;107;183.6164,94.14693;Inherit;False;Constant;_Vector0;Vector 0;6;0;Create;True;0;0;False;0;0,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;106;383.5343,74.192;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;42;174.631,-299.9232;Inherit;False;0;0;_MainTex;Shader;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;41;318.4144,-295.7757;Inherit;True;Property;_TextureSample4;Texture Sample 4;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;101;602.2042,85.45885;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;123;-1008.332,-30.59788;Inherit;False;1052.677;344.3553;Escalar el uv para la pantalla?, modificar que partes se ven con los floats;4;66;61;72;121;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;753.4155,-135.0329;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;121;-778.3592,23.32741;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;72;-976.6336,41.12086;Inherit;False;Constant;_Ratio;Ratio;1;0;Create;True;0;0;False;0;16,9;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;61;-667.4496,146.0415;Inherit;False;Property;_smallNoiseScale;smallNoiseScale;0;0;Create;True;0;0;False;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-363.216,228.847;Inherit;False;Property;_smallNoiseAmmount;smallNoiseAmmount;1;0;Create;True;0;0;False;0;0.3062017;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-641.3412,589.5577;Inherit;False;Property;_linesScale;linesScale;2;0;Create;True;0;0;False;0;60;60;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;70;897.4758,-135.5652;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-403.9349,1015.578;Inherit;False;Property;_maskAmmount;maskAmmount;5;0;Create;True;0;0;False;0;0.4750503;0.4750503;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-380.6223,673.6735;Inherit;False;Property;_linesAmmount;linesAmmount;3;0;Create;True;0;0;False;0;0.4169146;0.4169146;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-668.6033,925.4114;Inherit;False;Property;_maskScale;maskScale;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;40;1053.919,-158.2961;Float;False;True;2;ASEMaterialInspector;0;7;TVNoisePP;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;0
WireConnection;114;0;118;2
WireConnection;114;1;119;0
WireConnection;111;0;112;0
WireConnection;115;0;111;0
WireConnection;115;1;114;0
WireConnection;110;0;115;0
WireConnection;106;0;110;0
WireConnection;106;2;107;0
WireConnection;41;0;42;0
WireConnection;101;0;106;0
WireConnection;69;0;41;0
WireConnection;69;1;101;0
WireConnection;121;0;72;0
WireConnection;70;0;69;0
WireConnection;40;0;70;0
ASEEND*/
//CHKSM=77C329A8555C2E186231A3B38B79D35DD29EE8CE