//
//  LayoutPanel.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/4.
//
//

#import "LayoutPanel.h"

@implementation LayoutPanel

@synthesize opacity					= opacity_;
@synthesize color					= color_;
@synthesize opacityModifyRGB		= opacityModifyRGB_;

- (void) updateLayout
{
	
}


- (void) visit
{
	[self updateLayout];
	[super visit];
}


- (void)setColor:(ccColor3B)color
{
	color_ = color;
	for (CCNode<CCRGBAProtocol> *child in self.children)
	{
		[child setColor:color];
	}
}


- (void)setOpacity:(GLubyte)opacity
{
	opacity_ = opacity;
	
	for(CCNode<CCRGBAProtocol> *child in self.children)
	{
		[child setOpacity:opacity];
	}
}

- (void)setOpacityModifyRGB:(BOOL)opacityModifyRGB
{
	opacityModifyRGB_ = opacityModifyRGB;
	
	for(CCNode<CCRGBAProtocol> *child in self.children)
	{
		[child setOpacityModifyRGB:opacityModifyRGB];
	}
}

- (void)updateDisplayedOpacity:(GLubyte)parentOpacity
{
	_displayedOpacity = opacity_ * parentOpacity/255.0;
	
	{
		for (CCNode<CCRGBAProtocol> *child in self.children)
		{
			[child setOpacity:_displayedOpacity];
		}
	}
}

- (void)updateDisplayedColor:(ccColor3B)parentColor
{
	_displayedColor.r = color_.r * parentColor.r/255.0;
	_displayedColor.g = color_.g * parentColor.g/255.0;
	_displayedColor.b = color_.b * parentColor.b/255.0;
	
	{
		for (CCNode<CCRGBAProtocol> *child in self.children)
		{
			[child setColor:_displayedColor];
		}
	}
}

@end
