Shader "Unlit/Lighting MuiltShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Gloss("Gloss", range(0,1)) = 1
        _Color("Colour", color) = (1,1,1,1)
        _Mag("Mag", range(0,1)) = 0.5
        _Str("Str", range(0,1)) = 0.5
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        Pass
        {
            Tags
            {
                "LightMode" = "ForwardBase"
            }
            // "Always"
            // "ForwardAdd"
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdadd
            
            #include "InclLighting.cginc"
            
            ENDCG
        }
        // Add Pass
        Pass
        {
            Tags {"LightMode" = "ForwardAdd"}
            Blend One One // src *1 + dst*1 

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdadd

            #include "InclLighting.cginc"
            ENDCG
        }
    }
}