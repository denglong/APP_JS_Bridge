//
//  AppDelegate.h
//  OCJS_Bridge
//
//  Created by TanHao on 13-12-14.
//  Copyright (c) 2013年 http://www.tanhao.me. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet WebView *webView;
    IBOutlet NSTextView *textView;
}

@property (assign) IBOutlet NSWindow *webWindow;
@property (assign) IBOutlet NSWindow *nativeWindow;

- (IBAction)doAction:(id)sender;

@end
