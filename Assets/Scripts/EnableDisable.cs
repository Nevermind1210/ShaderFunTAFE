using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public class EnableDisable : MonoBehaviour
{ 
    public PostProcessProfile postProcessProfile;

    // Start is called before the first frame update
    void Start()
    {
        PostEffectEnabled(false, postProcessProfile); // We will ALWAYS disable it.
        
    }
    
    /// <summary>
    /// This function will check EACH settings of the profile and will enable or disable depending on the call function.
    /// </summary>
    /// <param name="isEnabled">if we want to enable the pos-effect</param>
    /// <param name="_postProcessProfile">What profile we are using?</param>
    private void PostEffectEnabled(bool isEnabled, PostProcessProfile _postProcessProfile)
    {
        if (postProcessProfile == null) return;
        foreach (var item in postProcessProfile.settings)
        {
            item.enabled.value = isEnabled;
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        PostEffectEnabled(true, postProcessProfile);
    }

    private void OnTriggerExit(Collider other)
    {
        PostEffectEnabled(false, postProcessProfile);
    }
}
