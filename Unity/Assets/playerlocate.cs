using UnityEngine;
using System.Collections;

public class playerlocate : MonoBehaviour {

	GameObject[] playerObjects;
	int playerNum;

	// Use this for initialization
	void Start () {

	}

	// Update is called once per frame
	void Update(){

		//playerNumはログイン後しばらく0なのでUpdate側で数値の変化をチェック

		if (playerNum == 0) {
		
			playerObjects = GameObject.FindGameObjectsWithTag ("Player");
			playerNum = playerObjects.Length;
			Debug.Log (playerNum);

			if (playerNum == 1) {
				this.transform.position = new Vector3 (0, 0, 4);
				float y = 180;
				this.transform.rotation = Quaternion.Euler (0.0f, y, 0.0f);
			} else if (playerNum == 2) {
				this.transform.position = new Vector3 (0, 0, -4);
				this.transform.rotation = Quaternion.identity;
			} else if (playerNum == 3) {
				this.transform.position = new Vector3 (0, 4, 0);
				this.transform.rotation = Quaternion.identity;
				float y = -90;
				this.transform.rotation = Quaternion.Euler (0.0f, y, 0.0f);
			} else if (playerNum == 4) {
				this.transform.position = new Vector3 (0, -4, 0);
				this.transform.rotation = Quaternion.identity;
				float y = 90;
				this.transform.rotation = Quaternion.Euler (0.0f, y, 0.0f);
			} else if (playerNum > 4) {
				//5人目以降。時間があれば同心円上に並べたい…
				this.transform.position = new Vector3 (0, Random.Range (-4f, 4f), Random.Range (-4f, 4f));
				this.transform.rotation = Quaternion.identity;
				float y = Random.Range (0, 360);
				this.transform.rotation = Quaternion.Euler (0.0f, y, 0.0f);
			}
		
		}

	}

}
