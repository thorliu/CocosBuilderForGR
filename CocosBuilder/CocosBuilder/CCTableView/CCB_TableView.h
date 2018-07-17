//
//  CCB_TableView.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/11.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


/*
 ----------------------------------------

 NOTE:
 
	@(CCB)		itemTemplate
	@(CGSize)	itemSize
	@(enum)		direction(H/V)
	@(int)		wrapCount
 
 ----------------------------------------
 
 */



typedef enum
{
	CCTableViewDirectionHorizontal,
	CCTableViewDirectionVertical
	
}CCTableViewDirection;



@interface CCB_TableView : CCLayer
{
	CCTableViewDirection				direction_;
	CGSize								itemSize_;
	int									wrapCount_;
	NSString*							itemTemplate_;
	
//	CCClippingNode*						clipNode_;
	CCNode*								containerNode_;
//	CCLayerColor*						maskNode_;
}

@property (nonatomic, readwrite)	CCTableViewDirection		direction;
@property (nonatomic, readwrite)	CGSize						itemSize;
@property (nonatomic, readwrite)	int							wrapCount;
@property (nonatomic, copy)			NSString*					itemTemplate;

- (void) updateLayout;
- (CCNode*) createItemNode;

@end
