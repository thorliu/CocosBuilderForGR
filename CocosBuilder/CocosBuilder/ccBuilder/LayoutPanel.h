//
//  LayoutPanel.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/4.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"



/**一个布局面板的抽象类*/
@interface LayoutPanel : CCNodeRGBA <CCRGBAProtocol>
{
	
@protected
	
	GLubyte             opacity_;
	ccColor3B           color_;
	BOOL                opacityModifyRGB_;
	
	
}

@property (nonatomic, readwrite) GLubyte opacity;
@property (nonatomic, readwrite) ccColor3B color;
@property (nonatomic, getter=doesOpacityModifyRGB) BOOL opacityModifyRGB;

/** 更新布局 */
- (void) updateLayout;

@end
