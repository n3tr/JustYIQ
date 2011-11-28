//
//  AppDelegate.m
//  JustYIQ
//
//  Created by n3tr on 11/29/11.
//  Copyright (c) 2011 Simpletail. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize hexText = _hexText;
@synthesize yiqResult = _yiqResult;
@synthesize halfResult = _halfResult;
@synthesize warmLabel = _warmLabel;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _hexText.stringValue = @"";
    _warmLabel.stringValue = @"";
    _halfResult.stringValue = @"";
    _yiqResult.stringValue = @"";
    
    _hexText.delegate = self;
    
}

- (IBAction)makeIt:(id)sender {
    
    if (_hexText.stringValue.length < 6 
        || (_hexText.stringValue.length == 7 && ![_hexText.stringValue hasPrefix:@"#"])
        )
    {
        _warmLabel.stringValue = @"Enter HEX color (eg. 666666 or #666666)";
        return;
    }
    
    _warmLabel.stringValue = @"";
    NSString *hexValue = _hexText.stringValue;
    
    // Check for # if present cutting out
    hexValue = hexValue.length == 7 ? [hexValue substringFromIndex:1] : hexValue;
    
    _halfResult.stringValue = [self getContrast50:hexValue];
    _yiqResult.stringValue = [self getContrastYIQ:hexValue];
  
    
}

- (NSString*)getContrast50:(NSString *)hexValue{
    
    unsigned int hexInt;
    
    NSScanner *scanner = [NSScanner scannerWithString:hexValue];
    [scanner scanHexInt:&hexInt];
    
    unsigned int half = 0xffffff/2;
    
    return hexInt > half  ? @"#000000" : @"#FFFFFF";
}

- (NSString*)getContrastYIQ:(NSString *)hexValue{
    
    
    unsigned int  r,g,b;
    
    NSString *rString = [hexValue substringWithRange:NSMakeRange(0, 2)];
    NSString *gString = [hexValue substringWithRange:NSMakeRange(2, 2)];
    NSString *bString = [hexValue substringWithRange:NSMakeRange(4, 2)];
    
    NSScanner *scanner = [NSScanner scannerWithString:rString];
    [scanner scanHexInt:&r];
    
    scanner = [NSScanner scannerWithString:gString];
    [scanner scanHexInt:&g];
    
    scanner = [NSScanner scannerWithString:bString];
    [scanner scanHexInt:&b];
    
    
    unsigned int yiq = ((r*299)+(g*587)+(b*114))/1000;
    return (yiq >= 128) ? @"#000000" : @"#FFFFFF";
    
    
}

#pragma NSTextField Delegate

- (void)controlTextDidEndEditing:(NSNotification *)aNotification{
    
    NSTextField *ed = [aNotification object];
    
    if(ed.stringValue != @""){
        [self makeIt:ed];
    }
}



@end
