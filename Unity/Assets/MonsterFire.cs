using UnityEngine;
using System.Collections.Generic;
using System.Collections;
using UnityEngine.UI;

public class MonsterFire : MonoBehaviour {

    public string str;
    private int modelNum;
    private List<GameObject> prefabs = new List<GameObject>();
    private const int maxObjectNum = 200;

    // Use this for initialization
    void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if (Input.GetKeyDown (KeyCode.H)) {
			GameObject bullet = PhotonNetwork.Instantiate ("Bullet", transform.position + new Vector3 (0.0f, 1.0f, 0.0f) + (transform.forward * 0.5f), transform.rotation, 0);
			bullet.GetComponent<Rigidbody> ().velocity = transform.forward * 15.0f;
		}

        if(Input.GetKeyDown(KeyCode.C))
        {
            chooseModelInputText("apple");
        }

        if (Input.GetKeyDown(KeyCode.B))
        {
            chooseModelInputText("gorilla");
        }

    }

    void chooseModelInputText(string message)
    {
		Debug.Log ("Unity  【"+ message +"】");
		//Swiftのクラス呼び出し
		//1分間これが呼ばれなかったらもう一度呼び出すメソッドほしい
		//SwiftClass.swiftStartRecordingMethod ();

		int num = 0;

        string pos = "Prefab/";
        pos += message;

        //GameObject temp = (GameObject)Resources.Load(modelName);
        GameObject temp = (GameObject)Resources.Load(pos);
        if (temp != null)
        {
            num = prefabs.Count;//リストが削除されることを考えていない
            //Instantiate(prefabs[num - 1], new Vector3(0f, 1f, 0f), Quaternion.identity);
            temp = PhotonNetwork.Instantiate(pos, transform.position + new Vector3(0.0f, 1.0f, 0.0f) + (transform.forward * 0.5f), transform.rotation, 0);
            prefabs.Add(temp);
            temp.GetComponent<Rigidbody>().velocity = transform.forward * 15.0f;
            checkObjectNum(num);
        }
    }


    void checkObjectNum(int num)
    {
        if(maxObjectNum <= num)
        {
            PhotonNetwork.Destroy(prefabs[0]);
            prefabs.RemoveAt(0);
        }
    }
}
