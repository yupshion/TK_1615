using UnityEngine;
using System.Collections.Generic;
using System.Collections;
using UnityEngine.UI;

public class MonsterFire : MonoBehaviour {

    public string str;
    private int modelNum;
    private List<GameObject> prefabs = new List<GameObject>();
    private const int maxObjectNum = 200;
	public GameObject particle;

    // Use this for initialization
    void Start () {
        GameObject.Find("RawImage").GetComponent<RawImage>().enabled = false;
    }

    // Update is called once per frame
    void Update () {
		if (Input.GetKeyDown (KeyCode.H)) {
			GameObject bullet = PhotonNetwork.Instantiate ("Bullet", transform.position + new Vector3 (0.0f, 1.0f, 0.0f) + (transform.forward * 0.5f), transform.rotation, 0);
			bullet.GetComponent<Rigidbody> ().velocity = transform.forward * 15.0f;
		}
/*
        if(Input.GetKeyDown(KeyCode.J))
        {
            chooseModelInputText("apple_10");
        }
        if (Input.GetKeyDown(KeyCode.K))
        {
            chooseModelInputText("apple_50");
        }
        if (Input.GetKeyDown(KeyCode.L))
        {
            chooseModelInputText("apple_100");
        }

        if (Input.GetKeyDown(KeyCode.B))
        {
            chooseModelInputText("gorilla_10");
        }
        if (Input.GetKeyDown(KeyCode.N))
        {
            chooseModelInputText("gorilla_50");
        }
        if (Input.GetKeyDown(KeyCode.M))
        {
            chooseModelInputText("gorilla_100");
        }

        if (Input.GetKeyDown(KeyCode.I))
        {
            chooseModelInputText("swiftstart");
        }
        if (Input.GetKeyDown(KeyCode.O))
        {
            chooseModelInputText("swiftstop");
        }
*/

    }

    void chooseModelInputText(string message)
    {
		Debug.Log ("Unity  【"+ message +"】");
		//Swiftのクラス呼び出し
		//1分間これが呼ばれなかったらもう一度呼び出すメソッドほしい
		//SwiftClass.swiftStartRecordingMethod ();

		int num = 0;

        if (message.IndexOf("_")<=0) {
            if (message == "swiftstart")
            {
                GameObject.Find("RawImage").GetComponent<RawImage>().enabled = true;
            }

            if (message == "swiftstop")
            {
                GameObject.Find("RawImage").GetComponent<RawImage>().enabled = false;
            }
            return;
        }

        //string[0]:word, string[1]:value for scale
        string[] stArrayData = message.Split('_');
        int objScale = int.Parse(stArrayData[1]);

        string pos = "Prefab/";
        pos += stArrayData[0];

        Debug.Log(stArrayData[0]);

        //GameObject temp = (GameObject)Resources.Load(modelName);
        GameObject temp = (GameObject)Resources.Load(pos);
        if (temp != null)
        {
            prefabs.Add(temp);
            num = prefabs.Count;//リストが削除されることを考えていない
            //Instantiate(prefabs[num - 1], new Vector3(0f, 1f, 0f), Quaternion.identity);
            temp = PhotonNetwork.Instantiate(pos, transform.position + new Vector3(0.0f, 1.0f, 0.0f) + (transform.forward * 0.5f), transform.rotation, 0);
            //			particle = Instantiate (particle, transform.position + new Vector3(0.0f, 1.0f, 0.0f) + (transform.forward * 0.5f), transform.rotation) as GameObject;
            temp.transform.localScale = new Vector3((float)((float)objScale/100.0), (float)((float)objScale / 100.0), (float)((float)objScale / 100.0));
            temp.GetComponent<Rigidbody>().velocity = transform.forward * 15.0f;
//            checkObjectNum(num);
        }
    }

/*
    void checkObjectNum(int num)
    {
        if(maxObjectNum <= num)
        {
            PhotonNetwork.Destroy(prefabs[0]);
            prefabs.RemoveAt(0);
        }
    }
*/
}
