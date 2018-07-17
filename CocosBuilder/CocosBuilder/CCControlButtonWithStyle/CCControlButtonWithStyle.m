//
//  CCControlButtonWithStyle.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/1.
//
//

#import "CCControlButtonWithStyle.h"
#import "StyleManager.h"

@implementation CCControlButtonWithStyle

@synthesize style = style_;

- (NSString*) getStyle
{
	return style_;
}

- (void)setStyle:(NSString *)newValue
{
	style_ = [newValue copy];
	[self updateStyle];
}

- (void) updateStyle
{
	[[StyleManager sharedManager] setButtonStyle:self style:style_];
};

- (id) init
{
	if(self = [super init])
	{
//		[self setColor:ccc3(0xFF, 0xFF, 0xFF)];
//		[self setOpacity:0xFF];
	}
	
	return self;
}




@end
