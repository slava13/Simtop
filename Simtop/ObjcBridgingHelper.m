//
//  ObjcBridgingHelper.m
//  Simtop
//
//  Created by Slava on 9/28/20.
//  Copyright © 2020 Yaroslav Kopylov. All rights reserved.
//

#import "ObjcBridgingHelper.h"
#import <MASShortcut/MASShortcut.h>

@implementation ObjcBridgingHelper

+ (void)setupDefaultKeybindingIfNeededWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:key] == nil) {
        MASShortcut *shortcut = [[MASShortcut alloc] initWithKeyCode:kVK_ANSI_T modifierFlags:NSEventModifierFlagCommand | NSEventModifierFlagShift];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:shortcut];
        [defaults setObject:data forKey:key];
    }
}
@end

