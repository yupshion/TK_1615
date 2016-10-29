//
//  voice.swift
//  Unity-iPhone
//
//  Created by koooootake on 2016/10/28.
//
//

import Foundation

class SpeechRecognizerManager:SpeechRecognizerModel{
    
    class var sharedInstance:SpeechRecognizerManager{
        
        struct Singleton{
            static var instance = SpeechRecognizerManager()
        }
        return Singleton.instance
    }
    
    override init() {
    }
    
    
    
}
