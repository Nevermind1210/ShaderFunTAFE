#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

struct appdata
{
    float4 vertex : POSITION;
    float3 normal: NORMAL;
    float2 uv : TEXCOORD0;
    float3 tangent : TANGENT;
};

struct v2f
{
    float4 vertex : SV_POSITION;
    float2 uv : TEXCOORD0;
    float3 normal : TEXCOORD1;
    float3 tangent : TEXCOORD2;
    float3 bitangent : TEXCOORD3;
    float3 worldPosition : TEXCOORD4;
    LIGHTING_COORDS(5,6);
};

sampler2D _MainTex;
sampler2D _Normals;
float4 _MainTex_ST;
float _Gloss;
float4 _Color;
float _Mag;
float _Str;

v2f vert(appdata v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    o.normal = UnityObjectToWorldNormal(v.normal);
    o.tangent = UnityObjectToWorldDir(v.tangent.xyz);
    o.bitangent = cross(o.normal, o.tangent);
    o.bitangent *= (v.tangent.w * unity_WorldTransformParams.w);
    
    
    o.worldPosition = mul(unity_ObjectToWorld, v.vertex);
    TRANSFER_VERTEX_TO_FRAGMENT(o); //Lighting
    
    return o;
}

fixed4 frag(v2f i) : SV_Target
{
    float3 albedo = tex2D(_MainTex, i.uv);
    float3 surfaceColor = albedo * _Color.rgb;
    //unpacked range is -1 to 1
    float3 tangentSpaceNormal = UnpackNormal(tex2D(_Normals, i.uv));
    
    #ifdef USE_LIGHTING
                //return float4(i.normal,1);

                //diffuse Lighting
                //lambert
                float3 N = normalize(i.normal);
                float3 L = _WorldSpaceLightPos0.xyz; //actually a direction to the light source
                float attenuation = LIGHT_ATTENUATION(i);
                //return float4(L,1);
                float3 lambert = max(0, dot(N, L));
                float3 diffuseLight = (lambert * attenuation)* _LightColor0.xyz;
                //saturate 0-1  can also work //clamp01 = saturate

                //return float4(diffuseLight,1);

                //specular lighting
                //phong
                /*float3 V = normalize(_WorldSpaceCameraPos - i.worldPosition); //direction towards the camera
                float3 R = reflect(-L,N);
                float3 specularLight = saturate(dot(V,R));
                specularLight = pow(specularLight, _Gloss); //specular exponent
                return float4(specularLight,1);*/

                //blinn phong
                float3 V = normalize(_WorldSpaceCameraPos - i.worldPosition);
                float3 H = normalize(L + V);
                float3 specularLight = saturate(dot(H, N));
                float specularExponent = exp2(_Gloss * 11);
                specularLight = pow(specularLight, specularExponent) * _Gloss; //specular exponent
                specularLight *= _LightColor0.xyz;

                // return float4(diffuseLight * _Color + specularLight,1);

                //fresnel
                float fresnel = (1 - dot(V, N)); //* (cos(_Time.y * 4)) * _Mag + _Str;

                
                return float4(_Color + specularLight + fresnel, 1);

    #else
    #ifdef IS_IN_BASE_PASS
    return _Color;
    #else
    return 0;

    #endif
}
