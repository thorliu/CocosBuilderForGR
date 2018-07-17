//
//  CCLabelTTFWithStyle.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/1.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "StyleManager.h"

@interface CCLabelTTFWithStyle : CCLabelTTF
{
	NSString* style_;
	
	TextColorStyle colorStyle_;
}

@property (nonatomic, copy) NSString* style;
@property (nonatomic, readwrite) TextColorStyle textColorStyle;

- (void) updateStyle;

@end
