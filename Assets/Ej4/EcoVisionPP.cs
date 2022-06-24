using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class EcoVisionPP : MonoBehaviour
{
    public Shader shader;
    private Material mat;

    public Slider ampSlider;
    public Slider speedSlider;
    public Slider thickSlider;

    // Start is called before the first frame update
    void Start()
    {
        mat = new Material(shader);
    }

    // Update is called once per frame
    void Update()
    {


        mat.SetFloat("_amplitude", ampSlider.value);
        mat.SetFloat("_speed",     speedSlider.value);
        mat.SetFloat("_thickness", thickSlider.value);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, mat);
    }
}
