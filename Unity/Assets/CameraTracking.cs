﻿using UnityEngine;
using System.Collections;

//キャラクターのモデルをカメラに追従させる関数

public class CameraTracking : MonoBehaviour {

	public int Childs;

	// Use this for initialization
	void Start () {
		//カメラにVRカメラ以外の子オブジェクトがついていなければカメラの子供になる
		GameObject obj = GameObject.Find ("Camera");
		int Count = obj.transform.childCount;
		if (Count == Childs) {
				transform.parent = obj.transform;
				this.transform.localPosition = new Vector3 (0, -1.7f, -0.1f);
				this.transform.localRotation = Quaternion.identity;
			}
	}
	
	// Update is called once per frame
	void Update () {

	}
}
