//
//  CCB_CheckBox.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/12.
//
//

#import "CCB_CheckBox.h"

@implementation CCB_CheckBox

//@synthesize checkIsFront					= checkIsFront_;
@synthesize checked							= checked_;
@synthesize checkIsScaled					= checkIsScaled_;
@synthesize checkAnchorPoint				= checkAnchorPoint_;

@synthesize checkSpriteSliceLeft			= checkSpriteSliceLeft_;
@synthesize checkSpriteSliceRight			= checkSpriteSliceRight_;
@synthesize checkSpriteSliceTop				= checkSpriteSliceTop_;
@synthesize checkSpriteSliceBottom			= checkSpriteSliceBottom_;



- (id) init
{
	if(self = [super init])
	{
		checkSpriteOrignSize_ = CGSizeZero;
		checkAnchorPoint_ = ccp(1,1);
	}
	return self;
}


//- (void) setCheckIsFront:(BOOL)newValue
//{
//	checkIsFront_ = newValue;
//	
//	//TODO: update zOrderIndex;
//}

- (void) setChecked:(BOOL)newValue
{
	checked_ = newValue;
	
	if(checkedSprite_ != nil)
	{
		checkedSprite_.visible = newValue;
	}
}

- (void) setCheckIsScaled:(BOOL)newValue
{
	checkIsScaled_ = newValue;
	
	[self layoutElements];
}

- (void) setCheckAnchorPoint:(CGPoint)newValue
{
	checkAnchorPoint_ = newValue;
	
	[self layoutElements];
}

- (void) setCheckSpriteFrame:(CCSpriteFrame *)newValue
{
	if(checkedSprite_ != nil)
	{
		[checkedSprite_ removeFromParent];
	}
	
	if(newValue != nil)
	{
		
		checkSpriteOrignSize_ = CGSizeMake(newValue.originalSize.width, newValue.originalSize.height);
											
		checkedSprite_ = [[CCScale9Sprite alloc] initWithSpriteFrame:newValue];
		checkedSprite_.visible = checked_;
		[checkedSprite_ setIgnoreAnchorPointForPosition:NO];
		[checkedSprite_ setAnchorPoint:ccp(0,0)];
		checkedSprite_.opacity = 0xFF;
		[self layoutElements];
		
		[self addChild:checkedSprite_];
	}
}

- (void) setCheckSpriteSliceLeft:(int)newValue
{
	checkSpriteSliceLeft_ = newValue;
	
	if(checkedSprite_ != nil)
	{
		checkedSprite_.insetLeft = newValue;
	}
}

- (void) setCheckSpriteSliceRight:(int)newValue
{
	checkSpriteSliceRight_ = newValue;
	
	if(checkedSprite_ != nil)
	{
		checkedSprite_.insetRight = newValue;
	}
}

- (void) setCheckSpriteSliceTop:(int)newValue
{
	checkSpriteSliceTop_ = newValue;
	
	if(checkedSprite_ != nil)
	{
		checkedSprite_.insetTop = newValue;
	}
}

- (void) setCheckSpriteSliceBottom:(int)newValue
{
	checkSpriteSliceBottom_ = newValue;
	
	if(checkedSprite_ != nil)
	{
		checkedSprite_.insetBottom = newValue;
	}
}


- (void) setContentSize:(CGSize)contentSize
{
	[super setContentSize:contentSize];
	[self layoutElements];
}

- (void) layoutElements
{
	if(checkedSprite_ == nil) return;
	
//	if(checkSpriteSliceLeft_ == 0 && checkSpriteSliceRight_ == 0)
//	{
//		checkedSprite_.insetLeft = checkedSprite_.insetRight = checkSpriteOrignSize_.width / 3;
//	}
//	else
//	{
//		checkedSprite_.insetLeft = checkSpriteSliceLeft_;
//		checkedSprite_.insetRight = checkSpriteSliceRight_;
//		
//	}
//	
//	
//	if(checkSpriteSliceTop_ == 0 && checkSpriteSliceBottom_ == 0)
//	{
//		checkedSprite_.insetTop = checkedSprite_.insetBottom = checkSpriteOrignSize_.height / 3;
//	}
//	else
//	{
//		checkedSprite_.insetTop = checkSpriteSliceTop_;
//		checkedSprite_.insetBottom = checkSpriteSliceBottom_;
//	}
	
	CGSize c = self.contentSize;
	
	
	if(checkIsScaled_)
	{
		[checkedSprite_ setPreferedSize:self.contentSize];
	}
	else
	{
		
		c = checkSpriteOrignSize_;
		[checkedSprite_ setPreferedSize:checkSpriteOrignSize_];
	}
	
	[checkedSprite_ setIgnoreAnchorPointForPosition:NO];
	[checkedSprite_ setAnchorPoint:ccp(0,0)];
	
	
	CGSize s = self.contentSize;
	CGPoint a = ccp(checkAnchorPoint_.x, checkAnchorPoint_.y);
	a = ccp(s.width * a.x, s.height * a.y);
	
	CGPoint sa = self.anchorPoint;

	if(checkIsScaled_)
	{
		a.x = 0;
		a.y = 0;
	}
	else
	{
		a.x -= c.width * sa.x;
		a.y -= c.height * sa.y;
	}
	
	
	
	[checkedSprite_ setPosition:a];
}

@end
