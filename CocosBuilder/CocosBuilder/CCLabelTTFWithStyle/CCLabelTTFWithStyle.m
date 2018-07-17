//
//  CCLabelTTFWithStyle.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/1.
//
//

#import "CCLabelTTFWithStyle.h"



@implementation CCLabelTTFWithStyle

@synthesize style = style_;
@synthesize textColorStyle = colorStyle_;

- (NSString*) getStyle
{
	return style_;
}

- (void) setStyle:(NSString *)newValue
{
	style_ = [newValue copy];
	[self updateStyle];
}

- (TextColorStyle) getTextColorStyle
{
	return colorStyle_;
}

- (void) setTextColorStyle:(TextColorStyle)v
{
	colorStyle_ = v;
	[self updateStyle];
}

- (void) updateStyle
{	
	[[StyleManager sharedManager] setTextStyle:self style:style_ textColorStyle:colorStyle_];
	
}

- (id) init
{
	if(self = [super init])
	{
		_displayedOpacity = 0xFF;
		colorStyle_ = TextColorStyleNormal;
	}
	
	return self;
}

@end
