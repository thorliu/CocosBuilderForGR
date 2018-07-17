//
//  StyleManager.h
//  CocosBuilder
//
//  Created by liuqiang on 15/12/31.
//
//

#import <Foundation/Foundation.h>

@class StyleProject;
@class StyleText;
@class StyleImage;
@class StyleButton;
@class CCControlButton;
@class CCScale9Sprite;

@class CCLabelTTF;

typedef enum
{
	/**默认颜色*/
	TextColorStyleNormal = 0,
	/**红色*/
	TextColorStyleRed = 1,
	/**绿色*/
	TextColorStyleGreen = 2
	
} TextColorStyle;

/**
 样式管理器, 包括文本，图片，按钮等样式定义信息
 */
@interface StyleManager : NSObject
{
	NSMutableDictionary* projectStyles_;
}

/** 获取当前样式管理器 */
+ (StyleManager*) sharedManager;

/** 加载当前项目的样式定义 */
- (void) loadCurrentProjectStyle;

/** 获取所有的文本样式名称*/
- (NSArray*) getTextStyleNames;

/** 获取所有的图片样式名称*/
- (NSArray*) getImageStyleNames;

/** 获取所有的按钮样式名称*/
- (NSArray*) getButtonStyleNames;

/** 获取当前项目 */
- (StyleProject*) getProject;


/** 设置文本样式 */
- (void) setTextStyle:(CCLabelTTF*)target style:(NSString*)style;
- (void) setTextStyle:(CCLabelTTF *)target style:(NSString *)style textColorStyle:(TextColorStyle)textColorStyle;

/** 设置按导样式 */
- (void) setButtonStyle:(CCControlButton*)target style:(NSString*)style;

- (void) setButtonStateStyle:(CCControlButton*)target textStyle:(NSString*)textStyle imageStyle:(NSString*)imageStyle state:(int)state project:(StyleProject*)project;

@end

