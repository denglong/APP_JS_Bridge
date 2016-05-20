//
//  AppDelegate.m
//  OCJS_Bridge
//
//  Created by TanHao on 13-12-14.
//  Copyright (c) 2013年 http://www.tanhao.me. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    webView.frameLoadDelegate = self;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]];
    [webView.mainFrame loadRequest:request];
}

- (IBAction)doAction:(id)sender
{
    //设置对象
    WebScriptObject *result = [[webView windowScriptObject] callWebScriptMethod:@"JSFunction" withArguments:@[textView.string]];
    
    NSString *message = [result valueForKey:@"message"];
    [textView setString:message];
}

- (WebScriptObject *)status:(WebScriptObject *)jsObject
{
    //将JS发过来的信息显示出来
    NSString *message = [jsObject valueForKey:@"message"];
    [textView setString:message];
    
    //返回成功的信息(WebScriptObject对象不能自己创建，所以此处复用了传入的参数)
    [jsObject setValue:@"本地端已经收到消息啦！" forKey:@"message"];
    return jsObject;
}


#pragma mark -
#pragma mark WebFrameLoadDelegate

- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame
{
    [windowObject setValue:self forKey:@"native"];
}

#pragma mark -
#pragma mark WebScriptingProtocol

/*
 返回是否阻止响应该方法,
 返回NO即能响应该方法
 */
+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector
{
    if (selector == @selector(status:))
    {
        return NO;
    }
    return YES;
}

/*
 返回本地方法在JS中的名称
 */
+ (NSString *)webScriptNameForSelector:(SEL)sel
{
    if (sel == @selector(status:))
    {
        return @"ocMethod";
    }
    return nil;
}

///*
// 返回是否阻止获取该属性,
// 返回NO即能获取该属性
// */
//+ (BOOL)isKeyExcludedFromWebScript:(const char *)property
//{
//	if (strcmp(property, "sharedValue") == 0)
//    {
//        return NO;
//    }
//    return YES;
//}
//
///*
// 返回本地属性在JS中的名称
// */
//+ (NSString *)webScriptNameForKey:(const char *)name
//{
//    if (strcmp(name, "sharedValue"))
//    {
//        return @"oc_sharedValue";
//    }
//    return nil;
//}

@end
