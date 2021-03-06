// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/Fog-Altitude"
{
    Properties
    {
       Color ("Main Color", Color) = (1,1,1,1)
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _FogNear ("Fog Near", range (0,50)) = 5
        _FogFar ("Fog Far", range (0,50)) = 10
        _FogAltScale ("Fog Alt. Scale", range (0,10)) = 10
        _FogThinning ("Fog Thinning", range (0,100)) = 100
        _FogColor ("Fog Color", Color) = (0.5,0.5,0.5,1)
    }
    SubShader
    {
       Tags { "RenderType"="Opaque" }
        LOD 200
       
        CGPROGRAM
        #pragma vertex vert
        #pragma surface surf Lambert alpha
 
        float4 _Color;
        sampler2D _MainTex;
        float _FogNear, _FogFar, _FogAltScale, _FogThinning;
        float4 _FogColor;
 
        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
            float4 pos;
        };

        void vert (inout appdata_full v, out Input o) {
            //o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
            o.pos = mul(unity_ObjectToWorld, v.vertex);
 
        }
 
        void surf (Input IN, inout SurfaceOutput o) {
            half4 c = tex2D (_MainTex, IN.uv_MainTex);
            float d = length(IN.viewDir);
            float l = saturate((d - _FogNear) / (_FogFar - _FogNear) / clamp(IN.pos.y / _FogAltScale + 1, 1, _FogThinning));
            //o.Albedo = c.rgb * _Color.rgb;
            o.Albedo = lerp(c.rgb * _Color.rgb, _FogColor, l);
            o.Alpha = lerp(c.a * _Color.a, _FogColor.a, l);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
