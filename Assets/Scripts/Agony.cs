using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;

public class Agony : MonoBehaviour
{
    public SkinnedMeshRenderer mr;

    void Update ()
    {
        if(Input.GetKeyDown(KeyCode.D))
        {
            mr.material.SetFloat("Vector1_83EFB224", Time.time);
        }
    }
}
