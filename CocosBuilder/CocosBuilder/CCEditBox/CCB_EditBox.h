//
//  CCB_EditBox.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCScale9Sprite.h"
#import "CCControl.h"

@interface CCB_EditBox : CCControl
{
//	CCLayerColor*	placeHolder_;
	
	int insetLeft_;
	int insetRight_;
	int insetTop_;
	int insetBottom_;
	
	CCScale9Sprite* background_;
	
	CGSize                                  preferedSize_;
}

@property (nonatomic, readwrite) int insetLeft;
@property (nonatomic, readwrite) int insetRight;
@property (nonatomic, readwrite) int insetTop;
@property (nonatomic, readwrite) int insetBottom;
@property (nonatomic, assign) CGSize preferedSize;

-(void)setSpriteFrame:(CCSpriteFrame*)spriteFrame;
-(void)updateLayout;

@end
