//
//  CCB_Ticker.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCScale9Sprite.h"
#import "CCControl.h"

@interface CCB_Ticker : CCControl
{
	CCSprite* thumb_;
	CCScale9Sprite* progress_;
	CCScale9Sprite* background_;
	
	float minValue_;
	float maxValue_;
	float currentValue_;
}

@property (nonatomic, readwrite) float minValue;
@property (nonatomic, readwrite) float maxValue;
@property (nonatomic, readwrite) float currentValue;

- (void) setThumbSpriteFrame:(CCSpriteFrame*)newValue;
- (void) setProgressSpriteFrame:(CCSpriteFrame*)newValue;
- (void) setBackgroundSpriteFrame:(CCSpriteFrame*)newValue;

- (void) updateLayout;


@end
