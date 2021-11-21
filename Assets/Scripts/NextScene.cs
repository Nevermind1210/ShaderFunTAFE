using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class NextScene : MonoBehaviour
{
    private int buildIndex;
    [SerializeField] private GameObject GO;
    
    private void Awake()
    {
        DontDestroyOnLoad(GO);
    }
    
    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.LeftArrow))
        {
            SceneManager.LoadSceneAsync(buildIndex - 1);
        }
        else if(Input.GetKeyDown(KeyCode.RightArrow))
        {
            SceneManager.LoadSceneAsync(buildIndex + 1);
        }
    }
}
