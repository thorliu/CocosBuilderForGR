//
//  CCB_EditBox.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/12.
//
//

#import "CCB_EditBox.h"

@implementation CCB_EditBox

@synthesize insetLeft = insetLeft_;
@synthesize insetRight = insetRight_;
@synthesize insetTop = insetTop_;
@synthesize insetBottom = insetBottom_;
@synthesize preferedSize                    = preferedSize_;

-(id)init
{
	if(self = [super init])
	{
//		placeHolder_ = [[CCLayerColor alloc] initWithColor:ccc4(0, 0x99, 0xFF, 0x0) width:100 height:100];
//		[self addChild:placeHolder_];
		
//		placeHolder_.ignoreAnchorPointForPosition=NO;
//		placeHolder_.anchorPoint = ccp(0,0);
	}
	
	return self;
}

-(void)setContentSize:(CGSize)cs
{
	[super setContentSize:cs];
	
	[self updateLayout];
	
//	if(placeHolder_!=nil)
//	{
//		placeHolder_.scaleX = (cs.width / 100.0f);
//		placeHolder_.scaleY = (cs.height / 100.0f);
//	}
	
}

-(void)updateLayout
{
	CGSize cs = CGSizeMake(self.contentSize.width, self.contentSize.height);
	
	NSLog(@"updateLayout : %f, %f", cs.width, cs.height);
	
	if(background_ != nil)
	{
		[background_ setPreferedSize:cs];
	}
}

-(void)setInsetLeft:(int)v
{
	insetLeft_ = v;
	
	if(background_ != nil)
	{
//		background_.insetLeft = v;
		[self updateLayout];
	}
}

-(void)setInsetRight:(int)v
{
	insetRight_ = v;
	
	if(background_ != nil)
	{
//		background_.insetRight = v;
		[self updateLayout];
	}
}

-(void)setInsetTop:(int)v
{
	insetTop_ = v;
	
	if(background_ != nil)
	{
//		background_.insetTop = v;
		[self updateLayout];
	}
}

-(void)setInsetBottom:(int)v
{
	insetBottom_ = v;
	
	if(background_ != nil)
	{
//		background_.insetBottom = v;
		[self updateLayout];
	}
}

-(void)setSpriteFrame:(CCSpriteFrame *)v
{
	if(v==nil) return;
	
	if(background_ != nil)
	{
		[background_ removeFromParent];
	}
	
	background_ = [[CCScale9Sprite alloc] initWithSpriteFrame:v];
	background_.ignoreAnchorPointForPosition = YES;
	[self addChild:background_];
	
//	background_.insetLeft = insetLeft_;
//	background_.insetTop = insetTop_;
//	background_.insetRight = insetRight_;
//	background_.insetBottom = insetBottom_;
	
	[self updateLayout];
}


- (void)setPreferedSize:(CGSize)s
{
	preferedSize_   = s;
	
	[self setContentSize:s];
	
	[self updateLayout];
}


@end
