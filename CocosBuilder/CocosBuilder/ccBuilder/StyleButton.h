//
//  StyleButton.h
//  CocosBuilder
//
//  Created by liuqiang on 15/12/31.
//
//

#import <Foundation/Foundation.h>

#include <libxml2/libxml/xmlreader.h>
#include <libxml2/libxml/parser.h>
#include <libxml2/libxml/tree.h>


@interface StyleButton : NSObject
{
	NSString* name;
	
	NSString* defaultText;
	NSString* defaultBackground;
	
	NSString* pressedText;
	NSString* pressedBackground;
	
	NSString* disabledText;
	NSString* disabledBackground;
}

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* defaultText;
@property (nonatomic, copy) NSString* defaultBackground;
@property (nonatomic, copy) NSString* pressedText;
@property (nonatomic, copy) NSString* pressedBackground;
@property (nonatomic, copy) NSString* disabledText;
@property (nonatomic, copy) NSString* disabledBackground;

/** 从XML配置节点创建样式 */
+ (id) initWithXmlNode:(xmlNodePtr)xmlNode;

/** 应用样式 */
//- (void) applyStyle;

@end
