using UnityEngine;
using System.Runtime.InteropServices;

public class SwiftClass {
	[DllImport("__Internal")]//ネイティププラグイン
	private static extern void swiftFirstStartRecordingMethod_ (); // ネイティブコード上のメソッド
	[DllImport("__Internal")]
	private static extern void swiftStartRecordingMethod_ ();    

	public static void swiftFirstStartRecordingMethod () {
		if (Application.platform == RuntimePlatform.IPhonePlayer) {//iPhone実行時以外はスルー
			swiftFirstStartRecordingMethod_ ();    // ネイティブコード上のメソッドを呼び出す
		}
	}

	public static void swiftStartRecordingMethod () {
		if (Application.platform == RuntimePlatform.IPhonePlayer) {
			swiftStartRecordingMethod_ ();    // ネイティブコード上のメソッドを呼び出す
		}
	}
}