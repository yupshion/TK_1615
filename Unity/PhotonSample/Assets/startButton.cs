using UnityEngine;
using System.Collections;

public class startButton : MonoBehaviour {

	// Use this for initialization
	void Start () {

	}

	// Update is called once per frame
	void Update () {

	}

	/// ボタンをクリックした時の処理
	public void OnClick() {
		Debug.Log("Unity  unityFirstStartButtonMethod");
		//Swiftのクラス呼び出し
		SwiftClass.swiftFirstStartRecordingMethod ();
	}
}