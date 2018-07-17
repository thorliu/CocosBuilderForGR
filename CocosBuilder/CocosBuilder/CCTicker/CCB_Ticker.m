//
//  CCB_Ticker.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/12.
//
//

#import "CCB_Ticker.h"

@implementation CCB_Ticker


@synthesize minValue		= minValue_;
@synthesize maxValue		= maxValue_;
@synthesize currentValue	= currentValue_;

-(id)init
{
	if(self = [super init])
	{
		minValue_ = 0;
		maxValue_ = 100;
		currentValue_ = 50;
	}
	
	return self;
}

-(void) setContentSize:(CGSize)v
{
	[super setContentSize:v];
	[self updateLayout];
}

-(void) updateLayout
{
	CGSize cs = self.contentSize;
	CGPoint a = ccp(0, cs.height / 2);
	float c = (currentValue_ - minValue_) / (maxValue_ - minValue_);
	if(c<0) c= 0;
	if(c>1) c= 1;
	
	if(background_ != nil)
	{
		CGSize bs = progress_.preferedSize;
		[background_ setPosition:a];
		[background_ setPreferedSize:CGSizeMake(cs.width, bs.height)];
	}
	
	if(progress_ != nil)
	{
		CGSize ps = progress_.preferedSize;
		[progress_ setPosition:a];
//		[progress_ setPreferedSize:CGSizeMake(cs.width * c, ps.height)];
		progress_.scaleX = (cs.width * c) / progress_.originalSize.width;
	}
	
	if(thumb_ != nil)
	{
		a.x = cs.width * c;
		[thumb_ setPosition:a];
	}
}

- (void) setMinValue:(float)v
{
	minValue_ = v;
	
	[self updateLayout];
}

- (void) setMaxValue:(float)v
{
	maxValue_ = v;
	
	[self updateLayout];
}

- (void) setCurrentValue:(float)v
{
	currentValue_ = v;
	[self updateLayout];
}


- (void)setThumbSpriteFrame:(CCSpriteFrame *)newValue
{
	if(newValue==nil) return;
	
	if(thumb_ != nil)
	{
		[thumb_ removeFromParent];
	}
	
	thumb_ = [[CCSprite alloc] initWithSpriteFrame:newValue];
	thumb_.ignoreAnchorPointForPosition = NO;
	thumb_.anchorPoint = ccp(0.5, 0.5);
	[self addChild:thumb_ z:3];
	
	[self updateLayout];
}

-(void)setProgressSpriteFrame:(CCSpriteFrame *)newValue
{
	if(newValue==nil) return;
	
	if(progress_ != nil)
	{
		[progress_ removeFromParent];
	}
	
	progress_ = [[CCScale9Sprite alloc] initWithSpriteFrame:newValue];
	progress_.ignoreAnchorPointForPosition = NO;
	progress_.anchorPoint = ccp(0, 0.5);
	[self addChild:progress_ z: 2];
	
	[self updateLayout];
}

-(void)setBackgroundSpriteFrame:(CCSpriteFrame *)newValue
{
	if(newValue==nil) return;
	
	if(background_ != nil)
	{
		[background_ removeFromParent];
	}
	
	background_ = [[CCScale9Sprite alloc] initWithSpriteFrame:newValue];
	background_.ignoreAnchorPointForPosition = NO;
	background_.anchorPoint = ccp(0, 0.5);
	[self addChild:background_ z:1];
	
	[self updateLayout];
}


@end
