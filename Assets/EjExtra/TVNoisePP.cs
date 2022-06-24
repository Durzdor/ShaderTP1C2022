using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TVNoisePP : MonoBehaviour
{
    public Shader shader;
    private Material mat;


    public Slider smallNoiseScale, linesScale, maskScale, smallNoiseAmmount, linesAmmount, maskAmmount;
    // Start is called before the first frame update
    void Start()
    {
        mat = new Material(shader);
    }

    // Update is called once per frame
    void Update()
    {
        mat.SetFloat("_smallNoiseScale", smallNoiseScale.value);
        mat.SetFloat("_linesScale", linesScale.value);
        mat.SetFloat("_maskScale", maskScale.value);
        mat.SetFloat("_smallNoiseAmmount", smallNoiseAmmount.value);
        mat.SetFloat("_linesAmmount", linesAmmount.value);
        mat.SetFloat("_maskAmmount", maskAmmount.value);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, mat);
    }
}
