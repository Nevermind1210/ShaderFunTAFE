using System;
using UnityEngine;

namespace DefaultNamespace
{
    public class CameraOrbit : MonoBehaviour
    {
        public float speed;

        private void Update()
        {
            transform.Rotate(0, speed * Time.deltaTime, 0);
        }
    }
}