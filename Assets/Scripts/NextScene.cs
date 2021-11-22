using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class NextScene : MonoBehaviour
{
    [SerializeField] private KeyCode leftKey;
    [SerializeField] private KeyCode rightKey;
    private string CurrentSceneName;

    private void Awake()
    {
        DontDestroyOnLoad(gameObject);
    }

    private void Start()
    {
        ChangeSceneName();
    }

    private void ChangeSceneName()
    {
        string start = "Assets/";
        string end = ".unity";
        CurrentSceneName = SceneManager.GetActiveScene().path;
        
        // Test if the path contains 'start' data, if so, remove it
        if(CurrentSceneName.StartsWith(start))
            CurrentSceneName = CurrentSceneName.Substring(start.Length);
        
        // Test if the path contains 'end' data, if so, remove it
        if(CurrentSceneName.EndsWith(end))
            // ReSharper disable once StringLastIndexOfIsCultureSpecific.1
            CurrentSceneName = CurrentSceneName.Substring(0, CurrentSceneName.LastIndexOf(end));
    }

    void Update()
    {
        ChangeSceneName();
        SceneLeft();
        SceneRight();
        Quit();
    }

    private void SceneRight()
    {
        if(Input.GetKeyDown(rightKey))
        {
            if(SceneManager.GetActiveScene().buildIndex - 1 == -1)
            {
                SceneManager.LoadScene(SceneManager.sceneCountInBuildSettings-1);
            }
            else
            {
                SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex - 1);
            }
        }
    }

    private void SceneLeft()
    {
        if(Input.GetKeyDown(leftKey))
        {
            if(SceneManager.GetActiveScene().buildIndex + 1 == SceneManager.sceneCountInBuildSettings)
            {
                SceneManager.LoadScene(0);
            }
            else
            {
                SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
            }
        }
    }

    /// <summary> Basic Quit function to exit the game on "Esc". </summary>
    private void Quit()
    {
        if(Input.GetKeyDown(KeyCode.Escape))
        {
            Application.Quit();
        #if UNITY_EDITOR
            UnityEditor.EditorApplication.isPlaying = false;
        #endif
        }
    }
}
