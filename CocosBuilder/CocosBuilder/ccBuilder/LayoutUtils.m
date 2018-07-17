//
//  LayoutUtils.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/4.
//
//

#import "LayoutUtils.h"

@implementation LayoutUtils




/* 获取节点尺寸 */
+ (CGSize)getNodeSize:(CCNode *)node useContentSize:(BOOL)useContentSize
{
	if(node && node.visible)
	{
		if(useContentSize)
		{
			CGSize cs = node.contentSize;
			cs.width *= node.scaleX;
			cs.height *= node.scaleY;
			
			//rotation ...
			
			return cs;
		}
		else
		{
			return node.boundingBox.size;
		}
	}
	return CGSizeZero;
}

/* 获取节点尺寸 */
+ (CGSize)getNodeSize:(CCNode *)node
{
	return [LayoutUtils getNodeSize:node useContentSize:NO];
}

/* 获取描点位置 */
+ (CGPoint)getNodeAnchor:(CCNode *)node
{
	if(node == nil || node.ignoreAnchorPointForPosition)
		return CGPointZero;
	else
		return node.anchorPoint;
}

@end
