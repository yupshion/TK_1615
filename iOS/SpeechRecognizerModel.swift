//
//  SpeechRecognizerModel.swift
//  Unity-iPhone
//
//  Created by koooootake on 2016/10/28.
//
//

import Foundation
import Speech
import AudioToolbox
//更新されてエラー出たらSwift- .h　に
//#import <AudioToolbox/AudioToolbox.h>

//コールバック空
private func AudioQueueInputCallback(
    _ inUserData: UnsafeMutableRawPointer?,
    inAQ: AudioQueueRef,
    inBuffer: AudioQueueBufferRef,
    inStartTime: UnsafePointer<AudioTimeStamp>,
    inNumberPacketDescriptions: UInt32,
    inPacketDescs: UnsafePointer<AudioStreamPacketDescription>?)
{
    // Do nothing, because not recoding.
}

class SpeechRecognizerModel: NSObject{
    
    //音声認識設定
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!//言語
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var isStop = false//音声認識Stopボタンが押されたか
    var isFirst = false//始めの起動か
    
    //音量取得
    var queue: AudioQueueRef!
    var timer = Timer()
    var volume = 0//volumeを保存
    
    //設定->スタート
    func Setting(){
        
        if audioEngine.isRunning {//動いていたら
            StopVolume()
            self.audioEngine.stop()
            recognitionRequest?.endAudio()
            isStop = true
            UnitySendMessage("ObjectGenerater", "chooseModelInputText", "swiftstop")
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
            
            try! self.Start()
            isFirst = true
            SettingVolume()
        }
    }
    
    //音声認識スタート
    func Start() throws{
        
        if isFirst{
            isFirst = false
        }else{
            SettingVolume()
        }
        
        UnitySendMessage("ObjectGenerater", "chooseModelInputText", "swiftstart")
        print("↓　start swiftStartRecordingMethod\n")
        isStop = false
        
        var rangeArray = [Range<String.Index>]()
        var beforeTmp = String()
        
        var countDictionary = [String:Int]()
        
        //認識するデータの初期配列
        let jpDictionary:[String: String] = EmojiDictionary.sharedInstance.SetUp()
            
        //実行中であるとき前回のタスクをキャンセル
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        //設定
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
                let realtimeResult:String = "\(result.bestTranscription.formattedString)"
                print("Before SpeechRecognizerResult : \(realtimeResult)")
                
                //もし言葉がリアルタイムに変更したら、rangeがない領域を指定してしまう
                //前回の文章が含まれていたら、変更なしなのでそのまま置き換え
                var tmp = realtimeResult
                
                if tmp.range(of:beforeTmp) != nil{
                    beforeTmp = tmp
                    
                    //すでに出した文字置き換え
                    for rangeString in rangeArray{
                        tmp.replaceSubrange(rangeString, with: "xxx")
                    }
                    
                }else{//含まれてなかったら変更ありなのでArrayをやり直す
                    rangeArray = []
                    
                    for (word,count) in countDictionary{
                        print("\(word) : \(count)")
                        for _ in 0...(count - 1){
                            let range = tmp.range(of: "\(word)")
                            if range != nil{
                                tmp.replaceSubrange(range!, with: "xxx")
                                rangeArray.append(range!)
                            }
                        }
                    }
                }

                print("After SpeechRecognizerResult : \(tmp)\n")
                
                isFinal = result.isFinal
                
                OperationQueue().addOperation({ () -> Void in
                
                    //一致探索
                    for (jpWord,enWord) in jpDictionary{
                        
                        //もしワードが含まれていたら
                        if tmp.contains("\(jpWord)"){
                            
                            print("Swift　【\(jpWord)】 volune : \(self.volume)")
                            //Unityに送信
                            UnitySendMessage("ObjectGenerater", "chooseModelInputText", "\(enWord)_\(self.volume)")
                            
                            //何回ワードが出てきたかカウント
                            if countDictionary["\(jpWord)"] == nil{
                                
                                countDictionary["\(jpWord)"] = 0
                                
                            }
                            
                            countDictionary["\(jpWord)"] = countDictionary["\(jpWord)"]! + 1
                            
                            //出現した言葉の位置
                            let range = tmp.range(of: "\(jpWord)")
                            
                            if range != nil{
                                rangeArray.append(range!)
                            }

                        }
                        
                    }
                    
                })//別スレッド処理
            }
            
            //終了したら
            if isFinal || error != nil {
                self.StopVolume()
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                
                UnitySendMessage("ObjectGenerater", "chooseModelInputText", "swiftstop")
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
        StopVolume()
        self.audioEngine.stop()
        recognitionRequest?.endAudio()
        isStop = true
        UnitySendMessage("ObjectGenerater", "chooseModelInputText", "swiftstop")
        print("↑　end swiftStartRecordingMethod\n")
    }
    
    //音量測定セッティング
    func SettingVolume(){
        
        //データフォーマット設定
        var dataFormat = AudioStreamBasicDescription(
            mSampleRate: 44100.0,
            mFormatID: kAudioFormatLinearPCM,
            mFormatFlags: AudioFormatFlags(kLinearPCMFormatFlagIsBigEndian | kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked),
            mBytesPerPacket: 2,
            mFramesPerPacket: 1,
            mBytesPerFrame: 2,
            mChannelsPerFrame: 1,
            mBitsPerChannel: 16,
            mReserved: 0)
        
        //インプットレベルの設定
        var audioQueue: AudioQueueRef? = nil
        var error = noErr
        error = AudioQueueNewInput(
            &dataFormat,
            AudioQueueInputCallback as AudioQueueInputCallback,
            UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()),
            .none,
            .none,
            0,
            &audioQueue)
        
        if error == noErr {
            self.queue = audioQueue
        }
        
        AudioQueueStart(self.queue, nil)
        
        //音量を取得の設定
        var enabledLevelMeter: UInt32 = 1
        AudioQueueSetProperty(self.queue, kAudioQueueProperty_EnableLevelMetering, &enabledLevelMeter, UInt32(MemoryLayout<UInt32>.size))
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                          target: self,
                                          selector: #selector(SpeechRecognizerModel.DetectVolume(_:)),
                                          userInfo: nil,
                                          repeats: true)
        self.timer.fire()
        
    }
    
    //音量測定
    func DetectVolume(_ timer: Timer)
    {
        //音量取得
        var levelMeter = AudioQueueLevelMeterState()
        var propertySize = UInt32(MemoryLayout<AudioQueueLevelMeterState>.size)
        
        AudioQueueGetProperty(
            self.queue,
            kAudioQueueProperty_CurrentLevelMeterDB,
            &levelMeter,
            &propertySize)
        
        // Show the audio channel's peak and average RMS power.
        //print("peak".appendingFormat("%.2f", levelMeter.mPeakPower))
        //print("aver".appendingFormat("%.2f", levelMeter.mAveragePower),"\n")
        
        self.volume = (Int)((levelMeter.mPeakPower + 144.0) * (100.0/144.0))
        
        //print("vvvv",self.volume)
        
        
    }
    
    //音量測定ストップ
    func StopVolume()
    {
        //止めるよ
        self.timer.invalidate()
        AudioQueueFlush(self.queue)
        AudioQueueStop(self.queue, false)
        AudioQueueDispose(self.queue, true)
    }

    
}
