//
//  CCB_ProgressBar.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCScale9Sprite.h"

@interface CCB_ProgressBar : CCProgressTimer
{
	int insetLeft_;
	int insetRight_;
	int insetTop_;
	int insetBottom_;
	
	CCSpriteFrame* spriteFrame_;
	CCScale9Sprite* background_;
	
	CGSize                                  preferedSize_;
	
	BOOL clipMode_;
}

@property (nonatomic, readwrite) int insetLeft;
@property (nonatomic, readwrite) int insetRight;
@property (nonatomic, readwrite) int insetTop;
@property (nonatomic, readwrite) int insetBottom;
@property (nonatomic, assign) CGSize preferedSize;
@property (nonatomic, readwrite) BOOL clipMode;

- (void)setSpriteFrame:(CCSpriteFrame*) spriteFrame;
- (void)updateLayout;
- (void)updateSprite;
- (BOOL)NodeIsUnvisibled;

@end
