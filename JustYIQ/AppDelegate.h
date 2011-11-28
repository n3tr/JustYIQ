//
//  AppDelegate.h
//  JustYIQ
//
//  Created by n3tr on 11/29/11.
//  Copyright (c) 2011 Simpletail. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate,NSTextFieldDelegate>
{
    NSTextField* hexText;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *hexText;
@property (weak) IBOutlet NSTextField *yiqResult;
@property (weak) IBOutlet NSTextField *halfResult;
@property (weak) IBOutlet NSTextField *warmLabel;

- (IBAction)makeIt:(id)sender;
- (NSString*)getContrast50:(NSString*)hexValue;
- (NSString*)getContrastYIQ:(NSString*)hexValue;
@end
