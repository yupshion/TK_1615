using UnityEngine;
using System.Collections;

public class ChangeSize : MonoBehaviour {

	public Vector3 size;
	public Vector3 max;
	public Vector3 min;
	public bool isChangingSize = false;

	// Use this for initialization
	void Start () {

		size = new Vector3(2, 2, 2);
		this.transform.localScale = size;
	
	}
	
	// Update is called once per frame
	void Update () {
	
		if (isChangingSize) {
			this.transform.localScale = size;
			Debug.Log ("ChangeSize");
		}
	}
}
