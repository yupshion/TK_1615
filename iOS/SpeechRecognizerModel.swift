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
//#import <AudioToolbox/AudioToolbox.h>

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
    
    //設定
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!//言語
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var isStop = false//Stopボタンが押されたか
    
    //音量
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
            SettingVolume()
            
        }
    }
    
    //スタート->スタート
    func Start() throws{
        UnitySendMessage("ObjectGenerater", "chooseModelInputText", "swiftstart")
        print("↓　start swiftStartRecordingMethod\n")
        isStop = false
        
        var rangeArray = [Range<String.Index>]()
        var beforeTmp = String()
        //var emojiArray = [String]()
        
        var countDictionary = [String:Int]()
        
        //認識するデータの初期配列
        //キーの重複禁止
        let jpDictionary = ["りんご":"apple","ゴリラ":"gorilla","リンゴ":"apple","ごりら":"gorilla",
             "よくない":"-1",
             "いいね":"1",
             "良":"1",
             "いかり":"angry",
             "怒り":"angry",
             "うわー":"astonished",
             "うれしい":"blush",
             "嬉しい":"blush",
             "嬉":"blush",
             "ごめん":"bow",
             "謝":"bow",
             "にかっ":"bowtie",
             "はくしゅ":"clap",
             "拍手":"clap",
             "ひやあせ":"cold_sweat",
             "冷汗":"cold_sweat",
             "こまる":"confounded",
             "困る":"confounded",
             "かなしい":"cry",
             "悲しい":"cry",
             "悲":"cry",
             "こまった":"disappointed_relieved",
             "困った":"disappointed_relieved",
             "困":"disappointed_relieved",
             "ざんねん":"disappointed",
             "残念":"disappointed",
             "だめだ":"dizzy_face",
             "きく":"ear",
             "聞く":"ear",
             "耳":"ear",
             "みる":"eyes",
             "おそろしい":"fearful",
             "がんばれ":"fist",
             "頑張":"fist",
             "驚":"flushed",
             "手":"hand",
             "かわいい":"heart_eyes",
             "可愛":"heart_eyes",
             "うふふ":"innocent",
             "たのしい":"joy",
             "楽しい":"joy",
             "楽":"joy",
             "きっす":"kissing_closed_eyes",
             "きす":"kissing_heart",
             "キス":"kissing_heart",
             "わら":"laughing",
             "笑":"laughing",
             "くち":"lips",
             "口":"lips",
             "ますく":"mask",
             "マスク":"mask",
             "まがお":"neutral_face",
             "真顔":"neutral_face",
             "だめ":"no_good",
             "はな":"nose",
             "鼻":"nose",
             "おっけー":"ok_hand",
             "オッケー":"ok_hand",
             "まる":"ok_woman",
             "丸":"ok_woman",
             "ぱあ":"open_hands",
             "しゅん":"pensive",
             "たすけて":"persevere",
             "助けて":"persevere",
             "うつむく":"person_frowning",
             "俯":"person_frowning",
             "ぷくー":"person_with_pouting_face",
             "した":"point_down",
             "下":"point_down",
             "ひだり":"point_left",
             "左":"point_left",
             "みぎ":"point_right",
             "右":"point_right",
             "うえ":"point_up_2",
             "上":"point_up_2",
             "いのる":"pray",
             "祈":"pray",
             "ごー":"punch",
             "げきど":"rage",
             "激怒":"rage",
             "わーい":"raised_hands",
             "はい":"raising_hand",
             "せやな":"relieved",
             "はしる":"runner",
             "走":"runner",
             "きょうふ":"scream",
             "恐怖":"scream",
             "怖":"scream",
             "恐":"scream",
             "ねる":"sleepy",
             "寝":"sleepy",
             "にっこり":"smile",
             "やった":"smiley",
             "あくま":"smiling_imp",
             "悪魔":"smiling_imp",
             "にや":"smirk",
             "ごうきゅう":"sob",
             "号泣":"sob",
             "べーだ":"stuck_out_tongue_closed_eyes",
             "べー":"stuck_out_tongue_winking_eye",
             "さんぐらす":"sunglasses",
             "サングラス":"sunglasses",
             "にがわらい":"sweat_smile",
             "苦笑":"sweat_smile",
             "うーん":"sweat",
             "あちゃー":"tired_face",
             "べろ":"tongue",
             "舌":"tongue",
             "ふん":"triumph",
             "つかれ":"unamused",
             "疲":"unamused",
             "さようなら":"wave",
             "がーん":"weary",
             "ガーン":"weary",
             "ういんく":"wink",
             "ウインク":"wink",
             "おいしい":"yum",
             "美味":"yum"]
            
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
                            UnitySendMessage("ObjectGenerater", "chooseModelInputText", "\(enWord)")
                            // \(-self.volume)
                            
                            //何回ワードが出てきたかカウント
                            if countDictionary["\(jpWord)"] == nil{
                                
                                countDictionary["\(jpWord)"] = 0
                                
                            }
                            
                            countDictionary["\(jpWord)"] = countDictionary["\(jpWord)"]! + 1
                            
                            //出現した言葉保存
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
        
        // Set data format
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
        
        // Observe input level
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
        }else{
            print("Error:\(error)")
        }
        
        AudioQueueStart(self.queue, nil)
        
        // Enable level meter
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
        // Get level
        var levelMeter = AudioQueueLevelMeterState()
        var propertySize = UInt32(MemoryLayout<AudioQueueLevelMeterState>.size)
        
        AudioQueueGetProperty(
            self.queue,
            kAudioQueueProperty_CurrentLevelMeterDB,
            &levelMeter,
            &propertySize)
        
        // Show the audio channel's peak and average RMS power.
        print("peak".appendingFormat("%.2f", levelMeter.mPeakPower))
        print("aver".appendingFormat("%.2f", levelMeter.mAveragePower),"\n")
        
        self.volume = -(Int)(levelMeter.mPeakPower)
        
    }
    
    //音量測定ストップ
    func StopVolume()
    {
        // Finish observation
        self.timer.invalidate()
        AudioQueueFlush(self.queue)
        AudioQueueStop(self.queue, false)
        AudioQueueDispose(self.queue, true)
    }

    
}
