using UnityEngine;
using System.Collections;
using UnityEngine.SceneManagement;

public class ChangeScene : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	public void PhotonScript()
	{
		//Swiftのクラス呼び出し
		SwiftClass.swiftFirstStartRecordingMethod ();
		SceneManager.LoadScene("PhotonScript");// ←new!
	}

}
