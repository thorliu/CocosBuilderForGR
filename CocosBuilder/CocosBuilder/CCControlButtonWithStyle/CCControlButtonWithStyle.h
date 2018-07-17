//
//  CCControlButtonWithStyle.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/1.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCControlButton.h"

@interface CCControlButtonWithStyle : CCControlButton
{
	NSString* style_;
}

@property (nonatomic, copy) NSString* style;

- (void) updateStyle;

@end
