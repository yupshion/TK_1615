using UnityEngine;
using System.Collections;

public class ChangeSize : MonoBehaviour {

	public Vector3 size;
	public float maxValue;
	public Vector3 max = new Vector3(1.2f, 1.2f, 1.2f);
	public float minValue;
	public Vector3 min = new Vector3(1.0f, 1.0f, 1.0f);
	public bool isChangingSize = true;

	private float time;
	public float speed = 5.0f;
	private Vector3 d;
	public bool isStart = true;

	// Use this for initialization
	void Start () {

		size = this.transform.localScale;
		time = 0;
		isStart = true;
	}

	// Update is called once per frame
	void Update () {

		if (max != min) {
			d = Vector3.Scale(size, max - min);
		}
		if (maxValue != 0.0f) {
			max = new Vector3 (maxValue, maxValue, maxValue);
		}
		if (minValue != 0.0f) {
			min = new Vector3 (minValue, minValue, minValue);
		}


		time += Time.deltaTime;

		if (isChangingSize && d != Vector3.zero) {
			
			this.transform.localScale = size + Mathf.Sin(time * speed) * ( d /2.0f);
			//Debug.Log ("ChangeSize");
		}
	}
}
