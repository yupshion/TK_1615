//
//  SpeechRecognizerModel.swift
//  Unity-iPhone
//
//  Created by koooootake on 2016/10/28.
//
//

import Foundation
import Speech

class SpeechRecognizerModel: NSObject{
    
    //設定
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!//言語
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var isStop = false//Stopボタンが押されたか
    
    //設定->スタート
    func Setting(){
        
        if audioEngine.isRunning {//動いていたら
            self.audioEngine.stop()
            recognitionRequest?.endAudio()
            isStop = true
            UnitySendMessage("ObjectGenerater", "chooseModelInputText", "stop")
            print("↑　end swiftStartRecordingMethod\n")
            
        } else {//止まっていたら
            print("SpeechRecognizerSetting")
            
            //音声認識の許可を求める
            SFSpeechRecognizer.requestAuthorization { authStatus in

                OperationQueue.main.addOperation {
                    switch authStatus {
                    case .authorized:
                        print("requestAuthorization : OK\n")
                    case .denied:
                        print("requestAuthorization : Denied\n")
                    case .restricted:
                        print("requestAuthorization : restricted\n")
                    case .notDetermined:
                        print("requestAuthorization : notDetermined\n")
                    }
                }
            }
            
            UnitySendMessage("ObjectGenerater", "chooseModelInputText", "start")

            try! self.Start()
  
        }
    }
    
    //スタート->スタート
    func Start() throws{
        
        print("↓　start swiftStartRecordingMethod\n")
        isStop = false
        
        var rangeArray = [Range<String.Index>]()
        var emojiArray = [String]()
        
        //認識するデータ配列
        let jpDictionary = ["りんご":"apple","ゴリラ":"gorilla"]
        let emojiDictionary = ["apple":"🍎","gorilla":"🐵"]
            
        //実行中であるとき前回のタスクをキャンセル
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        //認識前に初期化
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else { fatalError("Audio engine has no input node") }
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        //録音が終わる前の "partial (non-final)" な結果を報告してくれる
        recognitionRequest.shouldReportPartialResults = true
        
        //結果のリアルタイム取得
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                
                //音声出力結果
                var tmp:String = "\(result.bestTranscription.formattedString)"
                    
                //別スレッドを一つだけ処理
                //OperationQueue().addOperation({ () -> Void in
                    
                    //すでに出した文字置き換え
                    for (index,rangeString) in rangeArray.enumerated(){
                        tmp.replaceSubrange(rangeString, with: emojiArray[index])
                    }
                    
                    print("SpeechRecognizerResult : \(tmp)")
                    isFinal = result.isFinal

                    //一致探索
                    for (jpWord,enWord) in jpDictionary{
                        
                        //もしワードが含まれていたら
                        if tmp.contains("\(jpWord)"){
                            
                            print("Swift　【\(jpWord)】")
                            //Unityに送信
                            UnitySendMessage("ObjectGenerater", "chooseModelInputText", "\(enWord)")
                            
                            //出現した言葉保存
                            //tmp = tmp.replacingOccurrences(of: "\(jpWord)", with: "\(enWord)"))
                            let range = tmp.range(of: "\(jpWord)")
                            //絵文字だす
                            if range != nil && emojiDictionary["\(enWord)"] != nil{
                                rangeArray.append(range!)
                                emojiArray.append(emojiDictionary["\(enWord)"]!)
                            }
                            
                        }
                        
                    }
                    
                //})//別スレッド処理
                
            }
            
            //終了したら
            if isFinal || error != nil {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                print("↑　end swiftStartRecordingMethod\n")
                
                if self.isStop == false{
                    //再呼び出し
                    try! self.Start()
                    
                }
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        //マイクから得られる音声バッファが SFSpeechRecognitionRequest オブジェクトに渡される
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        try audioEngine.start()
        
    }
    
    //ストップ
    func Stop(){
        self.audioEngine.stop()
        recognitionRequest?.endAudio()
        isStop = true
        UnitySendMessage("ObjectGenerater", "chooseModelInputText", "stop")
        print("↑　end swiftStartRecordingMethod\n")
        
    }
}
