//
//  PluginExtPropsUtils.h
//  CocosBuilder
//
//  Created by liuqiang on 16/2/4.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PluginExtPropsUtils : NSObject
{
	
}

/**
 判定指定的节点是否绑定了定制类
 @param node 目标节点
 @param checkChildren 是否递归检查子级节点
 */
+ (BOOL)IsCustomClass:(CCNode*)node checkChildren:(BOOL)checkChildren;


/**
 判定指定的节点是否绑定了成员变量
 @param node 目标节点
 @param checkChildren 是否递归检查子级节点
 */
+ (BOOL)IsMemberVarAssignment:(CCNode*)node checkChildren:(BOOL)checkChildren;


/**
 判定指定的节点是否绑定了事件处理
 @param node 目标节点
 @param checkChildren 是否递归检查子级节点
 */
+ (BOOL)IsEventSelectorAssignment:(CCNode*)node checkChildren:(BOOL)checkChildren;


/**
 判定指定的节点是否被程序员使用
 @param node 目标节点
 @param checkChildren 是否递归检查子级节点
 */
+ (BOOL)IsDeveloperNode:(CCNode*)node checkChildren:(BOOL)checkChildren;


/**
 判定是否可以删除目标节点
 @param node 目标节点
 @param checkChildren 是否递归检查子级节点
 */
+ (BOOL)TryDelete:(CCNode*)node checkChildren:(BOOL)checkChildren;


/**
 检查节点是否是一个隐藏节点
 */
+ (BOOL)IsUnVisibledNode:(CCNode*)node;

@end
