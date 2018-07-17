//
//  StyleValue.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/4.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface StyleValue : NSObject
{
	
}

/** 将16进制字符串转换为int数值 */
+ (int) hex2dec:(NSString*)str;

/** 将字符串转换为颜色值 */
+ (ccColor3B) toColor3B:(NSString*)str;

/** 将字符串转换为透明度(glubyte) */
+ (GLubyte) toGLubyte:(NSString*)str;

@end
