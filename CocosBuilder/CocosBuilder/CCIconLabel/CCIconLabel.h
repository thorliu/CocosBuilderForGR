//
//  CCIconLabel.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/7.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "StyleManager.h"

/*
	需求:
 
	1个图标 + N个文本 (文本要支持样式)
 
 
	--------------
 
	设计: (支持多级嵌套, 父子级自适应联动)
 
	(Container) icon
	(Enum) iconDock (top,bottom,left,right)
	(Text Style)labelStyle
	(BOOL) isWaring
	(int) spacing
	(int) paddingLeft
	(int) paddingRight
	(int) paddingTop
	(int) paddingBottom
 
	---------
 
	 [icon]
	labelText

	---------
	
	labelText
	 [icon]
 
	---------
 
	[icon]labelText
 
	---------
 
	label[icon]
 
 */
typedef enum
{
	ccDockStyleCenter = 0,
	ccDockStyleTop,
	ccDockStyleBottom,
	ccDockStyleLeft,
	ccDockStyleRight
} ccDockStyle;


@interface CCIconLabel : CCNodeRGBA<CCRGBAProtocol>
{
	int paddingLeft_;
	int paddingRight_;
	int paddingTop_;
	int paddingBottom_;
	int spacing_;
	
	ccDockStyle iconDockStyle_;
	
	CCNodeRGBA* icon_;
	CCLabelTTF* label_;
	
	BOOL isWarning_;
	
	NSString* style_;
	NSString* text_;
	
	TextColorStyle colorStyle_;
}

@property (nonatomic, readwrite) ccDockStyle iconDockStyle;
@property (nonatomic, readwrite) int spacing;
@property (nonatomic, readwrite) int paddingLeft;
@property (nonatomic, readwrite) int paddingRight;
@property (nonatomic, readwrite) int paddingTop;
@property (nonatomic, readwrite) int paddingBottom;
@property (nonatomic, readwrite) BOOL isWarning;
@property (nonatomic, copy) NSString* style;
@property (nonatomic, copy) NSString* text;
@property (nonatomic, readwrite) TextColorStyle textColorStyle;

-(void)updateLayout;
-(void)updateStyle;

@end
