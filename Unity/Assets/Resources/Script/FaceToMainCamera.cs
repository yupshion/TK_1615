using UnityEngine;
using System.Collections;

public class FaceToMainCamera : MonoBehaviour {

	/// <summary>
	/// ビルボード処理の対象となるカメラを指定します。
	/// </summary>
	public Camera targetCamera;

	/// <summary>
	// Use this for initialization
	/// </summary>
	void Start ()
	{
		//対象のカメラが指定されない場合にはMainCameraを対象とします。
		if (this.targetCamera == null)
			targetCamera = Camera.main;
	}

	/// <summary>
	// Update is called once per frame
	/// </summary>
	void Update ()
	{
		//カメラの方向を向くようにする。
		this.transform.LookAt(this.targetCamera.transform.position);        
	}
}
