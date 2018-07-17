//
//  CCB_CheckBox.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCScale9Sprite.h"
#import "CCControl.h"

@interface CCB_CheckBox : CCControl
{

//	BOOL					checkIsFront_;
	BOOL					checked_;
	BOOL					checkIsScaled_;
	
	CGPoint					checkAnchorPoint_;
	
	int						checkSpriteSliceLeft_;
	int						checkSpriteSliceRight_;
	int						checkSpriteSliceTop_;
	int						checkSpriteSliceBottom_;

	CCScale9Sprite*			checkedSprite_;
	
	CGSize					checkSpriteOrignSize_;
	

}

//@property (nonatomic, readwrite) BOOL checkIsFront;
@property (nonatomic, readwrite) BOOL checked;
@property (nonatomic, readwrite) BOOL checkIsScaled;
@property (nonatomic, readwrite) CGPoint checkAnchorPoint;

@property (nonatomic, readwrite) int checkSpriteSliceLeft;
@property (nonatomic, readwrite) int checkSpriteSliceRight;
@property (nonatomic, readwrite) int checkSpriteSliceTop;
@property (nonatomic, readwrite) int checkSpriteSliceBottom;


- (void) setCheckSpriteFrame:(CCSpriteFrame*)newValue;
- (void) layoutElements;

@end
