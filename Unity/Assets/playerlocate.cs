using UnityEngine;
using System.Collections;

public class playerlocate : MonoBehaviour {

	// Use this for initialization
	void Start () {

		int i = PhotonNetwork.countOfPlayersInRooms;
		if (i == 0) {
			this.transform.position = new Vector3 (0, 0, 2);
			this.transform.rotation = Quaternion.identity;
		} else if (i == 1) {
			this.transform.position = new Vector3 (0, 0, 2);
			this.transform.rotation = Quaternion.identity;
			float y = 180;
			this.transform.rotation = Quaternion.Euler (0.0f, y, 0.0f);
		} else if (i == 2) {
			this.transform.position = new Vector3 (2, 0, 0);
			this.transform.rotation = Quaternion.identity;
			float y = -90;
			this.transform.rotation = Quaternion.Euler (0.0f, y, 0.0f);
		}


	}

	// Update is called once per frame
	void Update () {

	}
}