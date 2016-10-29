//
//  SwiftClass.swift
//  Unity-iPhone
//
//  Created by koooootake on 2016/10/29.
//
//

import Foundation
import UIKit

@available(iOS 10.0, *)
@objc(SwiftClass)
public class SwiftClass: NSObject{
    
    
    public class func swiftFirstStartRecordingMethod(){

        SpeechRecognizerManager.sharedInstance.Setting()
        
    }
    
    public class func swiftStartRecordingMethod(){
        
        try! SpeechRecognizerManager.sharedInstance.Start()
 
    }
   
    public class func swiftStopRecordingMethod(){
        
        SpeechRecognizerManager.sharedInstance.Stop()
        
    }
    
}

