//
//  StyleImage.h
//  CocosBuilder
//
//  Created by liuqiang on 15/12/31.
//
//

#import <Foundation/Foundation.h>

#include <libxml2/libxml/xmlreader.h>
#include <libxml2/libxml/parser.h>
#include <libxml2/libxml/tree.h>

#import "cocos2d.h"

@class CCSpriteFrame;

/** 图片样式 */
@interface StyleImage : NSObject
{
	NSString* name;
	
	NSString* plist;
	NSString* image;
	
	ccColor3B color;
	GLubyte opacity;
	
	int spliceLeft;
	int spliceTop;
	int spliceRight;
	int spliceBottom;
}

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* plist;
@property (nonatomic, copy) NSString* image;
@property (nonatomic, readwrite) ccColor3B color;
@property (nonatomic, readwrite) GLubyte opacity;
@property (nonatomic, readwrite) int spliceLeft;
@property (nonatomic, readwrite) int spliceTop;
@property (nonatomic, readwrite) int spliceRight;
@property (nonatomic, readwrite) int spliceBottom;


/** 从XML配置节点创建样式 */
+ (id) initWithXmlNode:(xmlNodePtr)xmlNode;

- (CCSpriteFrame*) getSpriteFrame;

@end
