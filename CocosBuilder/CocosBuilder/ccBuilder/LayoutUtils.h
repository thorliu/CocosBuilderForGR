//
//  LayoutUtils.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/4.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LayoutUtils : NSObject
{
}

/** 获取节点尺寸 */
+ (CGSize) getNodeSize:(CCNode*)node;

/** 获取节点尺寸 */
+ (CGSize) getNodeSize:(CCNode*)node useContentSize:(BOOL)useContentSize;

/** 获取描点位置 */
+ (CGPoint) getNodeAnchor:(CCNode*)node;


@end
