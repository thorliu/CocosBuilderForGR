//
//  CCB_ProgressBar.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/12.
//
//

#import "CCB_ProgressBar.h"

@implementation CCB_ProgressBar


@synthesize insetLeft						= insetLeft_;
@synthesize insetRight						= insetRight_;
@synthesize insetTop						= insetTop_;
@synthesize insetBottom						= insetBottom_;
@synthesize preferedSize                    = preferedSize_;
@synthesize clipMode						= clipMode_;



-(void)setClipMode:(BOOL)v
{
	clipMode_ = v;
	
	if(!clipMode_)
	{
		self.scaleX = 1;
		self.scaleY = 1;
	}
	
	[self updateSprite];
	[self updateLayout];
}

-(void)setPreferedSize:(CGSize)v
{
	preferedSize_.width = v.width;
	preferedSize_.height = v.height;
	[self updateLayout];
	
}

-(void)setInsetLeft:(int)v
{
	insetLeft_ = v;
	[self updateSprite];
	[self updateLayout];
}

-(void)setInsetRight:(int)v
{
	insetRight_ = v;
	[self updateSprite];
	[self updateLayout];
}

-(void)setInsetTop:(int)v
{
	insetTop_ = v;
	[self updateSprite];
	[self updateLayout];
}

-(void)setInsetBottom:(int)v
{
	insetBottom_ = v;
	[self updateSprite];
	[self updateLayout];
}

-(void)setPercentage:(float)v
{
	[super setPercentage:v];
	[self updateLayout];
}

-(void)setSpriteFrame:(CCSpriteFrame *)newValue
{
	if(spriteFrame_ != nil)
	{
		[spriteFrame_ release];
		spriteFrame_ = nil;
	}
	
	spriteFrame_ = newValue;
	[spriteFrame_ retain];
	[self updateSprite];
	[self updateLayout];
}

-(void)updateLayout
{
	if(clipMode_ && _sprite != nil)
	{
		if(spriteFrame_ != nil)
		{
			float sx = preferedSize_.width / spriteFrame_.rect.size.width;
			float sy = preferedSize_.height / spriteFrame_.rect.size.height;
			
			self.scaleX = sx;
			self.scaleY = sy;
		}
		return;
	}
	
	
	if(background_ == nil) return;
	CGSize newSize = CGSizeMake(0, 0);
	
	newSize.width = preferedSize_.width * (_percentage / 100.0f);
	newSize.height = preferedSize_.height;
	
	if(newSize.width < insetLeft_ + insetRight_) newSize.width = insetLeft_ + insetRight_;
	if(newSize.height < insetTop_ + insetBottom_) newSize.height = insetTop_ + insetBottom_;
	
//	newSize.width = 100;
//	newSize.height = 50;
	
	[background_ setPreferedSize:newSize];
	
	[self setContentSize:newSize];
}

-(void)updateSprite
{
	if(background_ != nil)
	{
		[background_ removeFromParent];
		background_ = nil;
	}
	
	if(spriteFrame_ == nil) return;
	
	[self setSprite:nil];
	
	if(clipMode_)
	{
		CCSprite* s = [[CCSprite alloc] initWithSpriteFrame:spriteFrame_];
		[self setSprite:s];
	}
	else
	{
		CGRect insets = CGRectZero;
		CGRect spriteRect = spriteFrame_.rect;
		if (spriteFrame_.rotated)
		{
			insets = CGRectMake(spriteRect.origin.x + insetBottom_,
								spriteRect.origin.y + insetLeft_,
								spriteRect.size.width - insetRight_ -insetLeft_,
								spriteRect.size.height- insetTop_ - insetBottom_);
		}
		else
		{
			insets = CGRectMake(spriteRect.origin.x + insetLeft_,
								spriteRect.origin.y + insetTop_,
								spriteRect.size.width-insetLeft_ - insetRight_,
								spriteRect.size.height-insetTop_ - insetBottom_);
		}
		
		
		background_ = [[CCScale9Sprite alloc] initWithSpriteFrame:spriteFrame_ capInsets:insets];
		
		background_.ignoreAnchorPointForPosition = NO;
		background_.anchorPoint = CGPointZero;
		
		[self addChild:background_];
	}
}


#pragma mark -

//- (void)setSpriteFrame:(CCSpriteFrame *)newValue;
//{
//	CCSprite* s = [[CCSprite alloc] initWithSpriteFrame:newValue];
//	[self setSprite:s];
//}


- (id) init
{
	if(self =  [super init])
	{
		
	}
	
	return self;
}


- (CCProgressTimerType) getProgressTimerType
{
	return kCCProgressTimerTypeBar;
}

- (CGPoint) getProgressTimerMidPoint
{
	return ccp(0,1);
}

- (CGPoint) getProgressTimerBarChangeRate
{
	return ccp(1,0);
}



@end
