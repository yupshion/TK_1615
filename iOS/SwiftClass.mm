//
//  SwiftClass.m
//  Unity-iPhone
//
//  Created by koooootake on 2016/10/29.
//
//

#import <UIKit/UIKit.h>
#import <ProductName-Swift.h>

extern "C"{
    
    //C#から呼ばれる関数
    //初期スタート
    void swiftFirstStartRecordingMethod_() {
        // Swiftのメソッドを呼び出す
        [SwiftClass swiftFirstStartRecordingMethod];

    }
    
    //連続スタート
    void swiftStartRecordingMethod_() {
        // Swiftのメソッドを呼び出す
        [SwiftClass swiftStartRecordingMethod];

    }
    
}
