//
//  ObjcBridgingHelper.h
//  Simtop
//
//  Created by Slava on 9/28/20.
//  Copyright © 2020 Yaroslav Kopylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjcBridgingHelper : NSObject

/**
 This code does not work in swift for some reason.
 -[_SwiftValue encodeWithCoder:]: unrecognized selector sent to instance
 */
+ (void)setupDefaultKeybindingIfNeededWithKey:(NSString *)key;

@end
