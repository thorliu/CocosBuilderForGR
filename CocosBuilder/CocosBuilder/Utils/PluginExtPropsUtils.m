//
//  PluginExtPropsUtils.m
//  CocosBuilder
//
//  Created by liuqiang on 16/2/4.
//
//

#import "PluginExtPropsUtils.h"
#import "NodeInfo.h"

@implementation PluginExtPropsUtils

+(BOOL)IsCustomClass:(CCNode *)node checkChildren:(BOOL)checkChildren
{
	if(node != nil)
	{
		NodeInfo* nodeInfo = node.userObject;
		if(nodeInfo != nil)
		{
			NSMutableDictionary* extraProps = nodeInfo.extraProps;
			if(extraProps != nil)
			{
		
				NSString* customClass = [extraProps objectForKey:@"customClass"];
				
				if(customClass != nil && customClass.length > 0)
				{
					return YES;
				}
				
				
				
			}
		}
	}
	
	//检查子级
	if(checkChildren)
	{
		CCArray* children = [node getChildrenPlugInContainer].children;
		for (int i = 0; i < [children count]; i++)
		{
			CCNode* child = [children objectAtIndex:i];
			if(child==nil) continue;
			
			if([PluginExtPropsUtils IsCustomClass:child checkChildren:checkChildren])
			{
				return YES;
			}
			
		}
	}
	
	return NO;
}

//判定指定的节点是否绑定了成员变量
+(BOOL)IsMemberVarAssignment:(CCNode *)node checkChildren:(BOOL)checkChildren
{
	if(node != nil)
	{
		NodeInfo* nodeInfo = node.userObject;
		if(nodeInfo != nil)
		{
			NSMutableDictionary* extraProps = nodeInfo.extraProps;
			if(extraProps != nil)
			{
				int memberVarAssignmentType = [[extraProps objectForKey:@"memberVarAssignmentType"] intValue];
				NSString* memberVarAssignmentName = [extraProps objectForKey:@"memberVarAssignmentName"];
				
				if(memberVarAssignmentType != 0 && memberVarAssignmentName != nil && memberVarAssignmentName.length > 0)
				{
					return YES;
				}
				
				
			}
		}
	}
	
	//检查子级
	if(checkChildren)
	{
		CCArray* children = [node getChildrenPlugInContainer].children;
		for (int i = 0; i < [children count]; i++)
		{
			CCNode* child = [children objectAtIndex:i];
			if(child==nil) continue;
			
			if([PluginExtPropsUtils IsMemberVarAssignment:child checkChildren:checkChildren])
			{
				return YES;
			}
			
		}
	}
	
	return NO;
}


//判定指定的节点是否绑定了事件处理
+(BOOL)IsEventSelectorAssignment:(CCNode *)node checkChildren:(BOOL)checkChildren
{
	if(node != nil)
	{
		NodeInfo* nodeInfo = node.userObject;
		if(nodeInfo != nil)
		{
			NSMutableDictionary* extraProps = nodeInfo.extraProps;
			if(extraProps != nil)
			{
				/*
				 "ccControlCtrlEvts"	0
				 "ccControlTarget"	2
				 "ccControl"			""
				 */
				NSString* ccControl = [extraProps objectForKey:@"ccControl"];
				
				if(ccControl != nil && ccControl.length > 0)
				{
					return YES;
				}
				
				
			}
		}
		
	}
	
	
	//检查子级
	if(checkChildren)
	{
		CCArray* children = [node getChildrenPlugInContainer].children;
		for (int i = 0; i < [children count]; i++)
		{
			CCNode* child = [children objectAtIndex:i];
			if(child==nil) continue;
			
			if([PluginExtPropsUtils IsEventSelectorAssignment:child checkChildren:checkChildren])
			{
				return YES;
			}
			
		}
	}
	
	return NO;
}

//判定指定的节点是否被程序员使用
+(BOOL)IsDeveloperNode:(CCNode *)node checkChildren:(BOOL)checkChildren
{
	if([PluginExtPropsUtils IsCustomClass:node checkChildren:checkChildren]) return YES;
	if([PluginExtPropsUtils IsMemberVarAssignment:node checkChildren:checkChildren]) return YES;
	if([PluginExtPropsUtils IsEventSelectorAssignment:node checkChildren:checkChildren]) return YES;
	
	return NO;
}

+(BOOL)IsUnVisibledNode:(CCNode *)node
{
	if(node != nil)
	{
		return [node nodeIsUnvisibled];
	}
	
	return NO;
}

//判定是否可以删除目标节点
+(BOOL)TryDelete:(CCNode *)node checkChildren:(BOOL)checkChildren
{
	BOOL ret = [PluginExtPropsUtils IsDeveloperNode:node checkChildren:checkChildren];
	
	if(ret)
	{
		NSLog(@"TODO: 弹一个确认框，说这是程序员用的节点，确认是不是真的要删除?");
		
		NSAlert* alert = [NSAlert alertWithMessageText:@"删除警告"
										 defaultButton:@"Yes"
									   alternateButton:@"No"
										   otherButton:NULL
							 informativeTextWithFormat:@"你尝试删除的内容中包含了一部分程序逻辑相关的部分，删除之后会导致程序运行不正常，你确认要删除么？"];
		
		NSInteger result = [alert runModal];
		if(result != NSAlertDefaultReturn) return NO;
	}
	
	return YES;
}


@end
