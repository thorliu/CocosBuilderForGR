//
//  StyleButton.m
//  CocosBuilder
//
//  Created by liuqiang on 15/12/31.
//
//

#import "StyleButton.h"

@implementation StyleButton

@synthesize name;
@synthesize defaultText;
@synthesize defaultBackground;
@synthesize pressedText;
@synthesize pressedBackground;
@synthesize disabledText;
@synthesize disabledBackground;

- (id) init
{
	self = [super init];
	if(!self) return NULL;
	return self;
}

- (void) dealloc
{
	self.name = NULL;
	[super dealloc];
}

+ (id) initWithXmlNode:(xmlNodePtr)xmlNode
{
	if(!xmlHasProp(xmlNode, BAD_CAST "name")) return NULL;
	
	StyleButton* style = [[StyleButton alloc] init];
	
	//name
	xmlChar* szAttr = xmlGetProp(xmlNode, BAD_CAST "name");
	style.name = [NSString stringWithCString:((const char*)szAttr)];
	xmlFree(szAttr);
	
	//defaultText
	if(xmlHasProp(xmlNode, BAD_CAST "defaultText"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "defaultText");
		style.defaultText = [NSString stringWithCString:(const char*)szAttr];
		xmlFree(szAttr);
	}
	
	//default
	if(xmlHasProp(xmlNode, BAD_CAST "default"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "default");
		style.defaultBackground = [NSString stringWithCString:(const char*)szAttr];
		xmlFree(szAttr);
	}
	
	//pressedText
	if(xmlHasProp(xmlNode, BAD_CAST "pressedText"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "pressedText");
		style.pressedText = [NSString stringWithCString:(const char*)szAttr];
		xmlFree(szAttr);
	}
	
	//pressed
	if(xmlHasProp(xmlNode, BAD_CAST "pressed"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "pressed");
		style.pressedBackground = [NSString stringWithCString:(const char*)szAttr];
		xmlFree(szAttr);
	}
	
	//defaultText
	if(xmlHasProp(xmlNode, BAD_CAST "disabledText"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "disabledText");
		style.disabledText = [NSString stringWithCString:(const char*)szAttr];
		xmlFree(szAttr);
	}
	
	//disabled
	if(xmlHasProp(xmlNode, BAD_CAST "disabled"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "disabled");
		style.disabledBackground = [NSString stringWithCString:(const char*)szAttr];
		xmlFree(szAttr);
	}
	
	
	return style;
}

@end
