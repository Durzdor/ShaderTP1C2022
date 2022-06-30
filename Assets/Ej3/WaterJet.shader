// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "WaterJet"
{
	Properties
	{
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 32
		_Frequency("Frequency", Float) = 0
		_Intensity("Intensity", Float) = 0.1
		_NoiseScale("NoiseScale", Float) = 1
		_Speed("Speed", Float) = 0
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

		uniform float _Speed;
		uniform float _Frequency;
		uniform float _NoiseScale;
		uniform float _Intensity;
		uniform float _TessValue;


		float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }

		float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }

		float snoise( float3 v )
		{
			const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
			float3 i = floor( v + dot( v, C.yyy ) );
			float3 x0 = v - i + dot( i, C.xxx );
			float3 g = step( x0.yzx, x0.xyz );
			float3 l = 1.0 - g;
			float3 i1 = min( g.xyz, l.zxy );
			float3 i2 = max( g.xyz, l.zxy );
			float3 x1 = x0 - i1 + C.xxx;
			float3 x2 = x0 - i2 + C.yyy;
			float3 x3 = x0 - 0.5;
			i = mod3D289( i);
			float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
			float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
			float4 x_ = floor( j / 7.0 );
			float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
			float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 h = 1.0 - abs( x ) - abs( y );
			float4 b0 = float4( x.xy, y.xy );
			float4 b1 = float4( x.zw, y.zw );
			float4 s0 = floor( b0 ) * 2.0 + 1.0;
			float4 s1 = floor( b1 ) * 2.0 + 1.0;
			float4 sh = -step( h, 0.0 );
			float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
			float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
			float3 g0 = float3( a0.xy, h.x );
			float3 g1 = float3( a0.zw, h.y );
			float3 g2 = float3( a1.xy, h.z );
			float3 g3 = float3( a1.zw, h.w );
			float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
			g0 *= norm.x;
			g1 *= norm.y;
			g2 *= norm.z;
			g3 *= norm.w;
			float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
			m = m* m;
			m = m* m;
			float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
			return 42.0 * dot( m, px);
		}


		float4 tessFunction( )
		{
			return _TessValue;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float mulTime15 = _Time.y * _Speed;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float simplePerlin3D11 = snoise( sin( ( mulTime15 + ( ase_vertex3Pos * _Frequency ) ) )*_NoiseScale );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 appendResult20 = (float3(ase_vertexNormal.x , 0.0 , ase_vertexNormal.z));
			v.vertex.xyz += ( simplePerlin3D11 * appendResult20 * _Intensity );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color22 = IsGammaSpace() ? float4(0.06052472,0.6981132,0,0) : float4(0.0049501,0.4453062,0,0);
			float mulTime15 = _Time.y * _Speed;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float simplePerlin3D11 = snoise( sin( ( mulTime15 + ( ase_vertex3Pos * _Frequency ) ) )*_NoiseScale );
			o.Emission = ( color22 * (0.5 + (simplePerlin3D11 - -1.0) * (1.0 - 0.5) / (1.0 - -1.0)) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17200
8;81;1394;950;1911.209;245.9655;1.032625;True;False
Node;AmplifyShaderEditor.CommentaryNode;29;-1712.049,-81.30921;Inherit;False;814.007;467.0012;Noise Sin;7;26;1;16;27;15;25;28;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1631.467,-31.30924;Inherit;False;Property;_Speed;Speed;8;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;1;-1662.049,93.04259;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;26;-1636.825,269.6919;Inherit;False;Property;_Frequency;Frequency;5;0;Create;True;0;0;False;0;0;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;15;-1452.265,-27.64612;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1454.255,133.7646;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-1197.982,-0.4530773;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-871.8143,345.1278;Inherit;False;Property;_NoiseScale;NoiseScale;7;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;28;-1048.042,2.134701;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;11;-695.3392,267.9212;Inherit;False;Simplex3D;False;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;17;-877.9468,425.0784;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;22;-408.5403,-200.7759;Inherit;False;Constant;_Color0;Color 0;6;0;Create;True;0;0;False;0;0.06052472,0.6981132,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;23;-290.6933,29.37498;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.5;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-498.1093,578.405;Inherit;False;Property;_Intensity;Intensity;6;0;Create;True;0;0;False;0;0.1;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;20;-654.3813,450.6747;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-147.7565,250.5463;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-56.6931,-20.02503;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;105.3,2.6;Float;False;True;6;ASEMaterialInspector;0;0;Standard;WaterJet;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;1;32;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;16;0
WireConnection;27;0;1;0
WireConnection;27;1;26;0
WireConnection;25;0;15;0
WireConnection;25;1;27;0
WireConnection;28;0;25;0
WireConnection;11;0;28;0
WireConnection;11;1;12;0
WireConnection;23;0;11;0
WireConnection;20;0;17;1
WireConnection;20;2;17;3
WireConnection;18;0;11;0
WireConnection;18;1;20;0
WireConnection;18;2;19;0
WireConnection;24;0;22;0
WireConnection;24;1;23;0
WireConnection;0;2;24;0
WireConnection;0;11;18;0
ASEEND*/
//CHKSM=15DC81DD27187948BA3BDF36798594411812BF17