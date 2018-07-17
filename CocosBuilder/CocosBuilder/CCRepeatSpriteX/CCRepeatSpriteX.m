//
//  CCRepeatSpriteX.m
//  CocosBuilder
//
//  Created by liuqiang on 16/5/25.
//
//

#import "CCRepeatSpriteX.h"

#define FPS	100.0f

@implementation CCRepeatSpriteX
@synthesize horizontalRepeat			= horizontalRepeat_;
@synthesize verticalRepeat				= verticalRepeat_;
@synthesize texture						= texture_;
@synthesize opacity						= opacity_;
@synthesize color						= color_;
@synthesize opacityModifyRGB			= opacityModifyRGB_;
@synthesize spriteFrame					= spriteFrame_;
@synthesize moveSpeed					= moveSpeed_;
@synthesize moveDirection				= moveDirection_;

-(id) init
{
	if(self = [super init])
	{
		horizontalRepeat_ = YES;
		verticalRepeat_ = YES;
		opacityModifyRGB_ = YES;
		color_ = ccc3(0xFF, 0xFF, 0xFF);
		opacity_ = 0xFF;
		textureRect_ = CGRectZero;
		sprite_ = [[CCSprite alloc]init];
		sprite_.ignoreAnchorPointForPosition = NO;
		sprite_.anchorPoint = CGPointZero;
		sprite_.visible = NO;
		offsetPosition_ = CGPointZero;
		[self addChild:sprite_];
		
		timer_ = [NSTimer scheduledTimerWithTimeInterval:(1.0f / FPS) target:self selector:@selector(onTick) userInfo:nil repeats:YES];
	}
	
	return self;
}

#pragma mark - Properties

-(void)setContentSize:(CGSize)v
{
	super.contentSize = v;
	[self updateDisplay];
}

-(void)setColor:(ccColor3B)v
{
	color_ = v;
	if(sprite_ != nil) [sprite_ setColor:v];
}

-(void)setOpacity:(GLubyte)v
{
	opacity_ = v;
	if(sprite_ != nil) [sprite_ setOpacity:v];
}

-(void)setOpacityModifyRGB:(BOOL)v
{
	opacityModifyRGB_ = v;
	if(sprite_ != nil) [sprite_ setOpacityModifyRGB:v];
}

-(void)setHorizontalRepeat:(BOOL)v
{
	if(horizontalRepeat_ == v) return;
	horizontalRepeat_ = v;
	[self updateDisplay];
}

-(void)setVerticalRepeat:(BOOL)v
{
	if(verticalRepeat_ == v) return;
	verticalRepeat_ = v;
	[self updateDisplay];
}

-(void)setTexture:(CCTexture2D *)v
{
	if(texture_ == v) return;
	texture_ = v;
	if(v != nil)
	{
		CGSize s = v.contentSize;
		textureRect_ = CGRectMake(0, 0, s.width, s.height);
		
		ccTexParams tp = { GL_LINEAR, GL_LINEAR, GL_REPEAT, GL_REPEAT};
		[texture_ setTexParameters:&tp];
		[sprite_ setTexture:texture_];
	}
	[self updateDisplay];
}





-(void)setSpriteFrame:(CCSpriteFrame *)v
{
	if(v != nil)
	{
		[self setTexture:v.texture];
	}
	else
	{
		[self setTexture:nil];
	}
}

#pragma mark - Biz

-(void)updateDisplay
{
	//更新显示
	if(texture_ == nil)
	{
		sprite_.visible = NO;
	}
	else
	{
		CGSize cs = self.contentSize;
		CGSize ts = texture_.contentSize;
		CGRect spriteRect = CGRectMake(0, 0, ts.width, ts.height);
		
		spriteRect.origin.x += offsetPosition_.x;
		spriteRect.origin.y += offsetPosition_.y;
		
		if(horizontalRepeat_)
		{
			spriteRect.size.width = cs.width;
		}
		
		if(verticalRepeat_)
		{
			spriteRect.size.height = cs.height;
		}
		
		[sprite_ setTextureRect:spriteRect];
		sprite_.visible = YES;
	}
}


-(void)onTick
{
	if(sprite_ == nil || texture_ == nil || fabsf(moveSpeed_) < 1) return;
	
	
	CGRect rect = sprite_.textureRect;
	
	float a = moveDirection_ / (180.0f / M_PI);
	float dist = moveSpeed_ / FPS;
	float cx = dist * cosf(a);
	float cy = dist * sinf(a);
	
	
	rect.origin.x -= cx;
	rect.origin.y -= cy;
	
	[sprite_ setTextureRect:rect];
	
	
}



@end
