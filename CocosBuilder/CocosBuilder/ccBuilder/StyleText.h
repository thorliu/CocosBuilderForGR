//
//  StyleText.h
//  CocosBuilder
//
//  Created by liuqiang on 15/12/31.
//
//

#import <Foundation/Foundation.h>
#include <libxml2/libxml/xmlreader.h>
#include <libxml2/libxml/parser.h>
#include <libxml2/libxml/tree.h>
#include "cocos2d.h"
#include "CCLabelTTF.h"





/** 文本样式 */
@interface StyleText : NSObject
{
	NSString* name;
	
	NSString* font;
	double size;
	
	ccColor3B color;
	ccColor3B warning;
	ccColor3B green;
	GLubyte opacity;
}




@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* font;
@property (nonatomic, readwrite) double size;
@property (nonatomic, readwrite) ccColor3B color;
@property (nonatomic, readwrite) ccColor3B warning;
@property (nonatomic, readwrite) ccColor3B green;
@property (nonatomic, readwrite) GLubyte opacity;

/** 从XML配置节点创建样式 */
+ (id) initWithXmlNode:(xmlNodePtr)xmlNode;



@end
