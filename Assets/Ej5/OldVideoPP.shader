// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "OldVideoPP"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_intensity("intensity", Range( 0 , 0.05)) = 0

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
			
			uniform float _intensity;


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
				float2 appendResult105 = (float2(_intensity , 0.0));
				float2 uv0102 = i.uv.xy * float2( 1,1 ) + appendResult105;
				float4 color50 = IsGammaSpace() ? float4(1,0,0,0) : float4(1,0,0,0);
				float2 uv0101 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float4 color56 = IsGammaSpace() ? float4(0,1,0,0) : float4(0,1,0,0);
				float2 appendResult106 = (float2(-_intensity , 0.0));
				float2 uv0100 = i.uv.xy * float2( 1,1 ) + appendResult106;
				float4 color51 = IsGammaSpace() ? float4(0,0,1,0) : float4(0,0,1,0);
				

				finalColor = ( saturate( ( tex2D( _MainTex, uv0102 ) * color50 ) ) + saturate( ( tex2D( _MainTex, uv0101 ) * color56 ) ) + saturate( ( tex2D( _MainTex, uv0100 ) * color51 ) ) );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17200
8;81;1394;950;1403.4;434.7389;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;46;-1174.43,-65.09431;Inherit;False;Property;_intensity;intensity;0;0;Create;True;0;0;False;0;0;0;0;0.05;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;103;-845.8158,80.53027;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;105;-829.4003,-297.7389;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;106;-648.4003,155.2611;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;102;-510.6934,-565.9254;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;41;-375.0862,-190.044;Inherit;False;0;0;_MainTex;Shader;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;100;-496.8272,296.5098;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;101;-513.5023,-83.77329;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;43;-220.4919,192.6254;Inherit;True;Property;_TextureSample5;Texture Sample 5;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Instance;42;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;42;-239.4472,-209.2809;Inherit;True;Property;_TextureSample4;Texture Sample 4;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;50;-239.0424,-409.4232;Inherit;False;Constant;_Color0;Color 0;2;0;Create;True;0;0;False;0;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;56;-240.039,-7.114742;Inherit;False;Constant;_Color3;Color 3;2;0;Create;True;0;0;False;0;0,1,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;48;-237.2505,-598.5832;Inherit;True;Property;_TextureSample6;Texture Sample 5;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Instance;42;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;51;-215.679,398.1138;Inherit;False;Constant;_Color1;Color 1;2;0;Create;True;0;0;False;0;0,0,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;287.9849,227.052;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;299.4159,-344.4916;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;96;297.1296,-106.7293;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;97;441.9206,-106.7292;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;94;444.2069,-344.4915;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;99;432.776,227.0521;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;727.6923,-242.3755;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;40;974.2872,-241.8926;Float;False;True;2;ASEMaterialInspector;0;7;OldVideoPP;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;0
WireConnection;103;0;46;0
WireConnection;105;0;46;0
WireConnection;106;0;103;0
WireConnection;102;1;105;0
WireConnection;100;1;106;0
WireConnection;43;1;100;0
WireConnection;42;0;41;0
WireConnection;42;1;101;0
WireConnection;48;1;102;0
WireConnection;98;0;43;0
WireConnection;98;1;51;0
WireConnection;93;0;48;0
WireConnection;93;1;50;0
WireConnection;96;0;42;0
WireConnection;96;1;56;0
WireConnection;97;0;96;0
WireConnection;94;0;93;0
WireConnection;99;0;98;0
WireConnection;95;0;94;0
WireConnection;95;1;97;0
WireConnection;95;2;99;0
WireConnection;40;0;95;0
ASEEND*/
//CHKSM=6240C15BCA47361F43E1A028C694827F93339513