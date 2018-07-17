//
//  CCRepeatSprite.h
//  CocosBuilder
//
//  Created by liuqiang on 15/12/29.
//
//

#import "cocos2d.h"

/**
 * 一个支持平辅的精灵组件
 */
@interface CCRepeatSprite : CCNodeRGBA <CCRGBAProtocol>
{
@public
	CGSize              originalSize_;
	CGSize              preferedSize_;
	
	BOOL				horizontalRepeat_;
	BOOL				verticalRepeat_;
	
@protected
	CGRect              spriteRect;
	BOOL                spriteFrameRotated_;
	CGRect              capInsetsInternal_;
	BOOL                positionsAreDirty_;
	
	CCSpriteBatchNode   *images;
	
	
	BOOL                spritesGenerated_;
	
	// texture RGBA
	GLubyte             opacity_;
	ccColor3B           color_;
	BOOL                opacityModifyRGB_;
}

@property (nonatomic, readonly) CGSize originalSize;
@property (nonatomic, assign) CGSize preferedSize;
@property (nonatomic, readwrite) GLubyte opacity;
@property (nonatomic, readwrite) ccColor3B color;
@property (nonatomic, getter=doesOpacityModifyRGB) BOOL opacityModifyRGB;
@property (nonatomic, readwrite, assign) BOOL horizontalRepeat;
@property (nonatomic, readwrite, assign) BOOL verticalRepeat;

- (id)initWithFile:(NSString *)file rect:(CGRect)rect;
+ (id)spriteWithFile:(NSString *)file rect:(CGRect)rect;
- (id)initWithFile:(NSString *)file;
+ (id)spriteWithFile:(NSString *)file;
- (id)initWithSpriteFrame:(CCSpriteFrame *)spriteFrame;
+ (id)spriteWithSpriteFrame:(CCSpriteFrame *)spriteFrame;
- (id)initWithSpriteFrameName:(NSString *)spriteFrameName;
+ (id)spriteWithSpriteFrameName:(NSString *)spriteFrameName;
- (void) setSpriteFrame:(CCSpriteFrame*) spriteFrame;


- (void)updateRepeatImages;

@end
