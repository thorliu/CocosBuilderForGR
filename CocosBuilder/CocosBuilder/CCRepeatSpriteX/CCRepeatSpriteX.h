//
//  CCRepeatSpriteX.h
//  CocosBuilder
//
//  Created by liuqiang on 16/5/25.
//
//

#import "cocos2d.h"

@interface CCRepeatSpriteX : CCNodeRGBA<CCRGBAProtocol>
{
@public
	
	BOOL				horizontalRepeat_;
	BOOL				verticalRepeat_;
	CCTexture2D*		texture_;
	CGRect				textureRect_;
	CCSprite*			sprite_;
	CCSpriteFrame*		spriteFrame_;
	CGPoint				offsetPosition_;
	float				moveSpeed_;
	float				moveDirection_;
	NSTimer*			timer_;
	
@protected
	
	GLubyte             opacity_;
	ccColor3B           color_;
	BOOL                opacityModifyRGB_;
}

@property (nonatomic, readwrite) GLubyte opacity;
@property (nonatomic, readwrite) ccColor3B color;
@property (nonatomic, getter=doesOpacityModifyRGB) BOOL opacityModifyRGB;
@property (nonatomic, readwrite, assign) BOOL horizontalRepeat;
@property (nonatomic, readwrite, assign) BOOL verticalRepeat;
@property (nonatomic, readwrite, assign) CCTexture2D* texture;
@property (nonatomic, readwrite, assign) CCSpriteFrame* spriteFrame;
@property (nonatomic, readwrite) float moveSpeed;
@property (nonatomic, readwrite) float moveDirection;


-(void)updateDisplay;
-(void)onTick;

@end
