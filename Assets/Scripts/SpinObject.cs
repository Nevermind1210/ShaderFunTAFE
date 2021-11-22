using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpinObject : MonoBehaviour
{
    private Rigidbody rb;
    private float xvalue, yvalue;
    private Vector3 spin = new Vector3(4, 5, 0);
    
    private void Start()
    {
        rb = gameObject.AddComponent<Rigidbody>();
        rb.constraints = RigidbodyConstraints.FreezePosition;
    }

    private void FixedUpdate()
    {
        rb.AddTorque(spin);
    }
}
