using UnityEngine;
using System.Collections;

public class CameraTracking : MonoBehaviour {


	// Use this for initialization
	void Start () {
		transform.parent = GameObject.Find("Camera").transform;

	}
	
	// Update is called once per frame
	void Update () {

	}
}
