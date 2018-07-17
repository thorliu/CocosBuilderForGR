//
//  StyleText.m
//  CocosBuilder
//
//  Created by liuqiang on 15/12/31.
//
//

#import "StyleText.h"
#import "StyleValue.h"

@implementation StyleText

@synthesize name;
@synthesize font;
@synthesize size;
@synthesize opacity;
@synthesize color;
@synthesize warning;
@synthesize green;

- (id) init
{
	self = [super init];
	if(!self) return NULL;
	
	self.warning = ccc3(0xFF, 0x33, 0x00);
	self.green = ccc3(0x33, 0xFF, 0x00);
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
	
	StyleText* style = [[StyleText alloc] init];

	//name
	xmlChar* szAttr = xmlGetProp(xmlNode, BAD_CAST "name");
	style.name = [NSString stringWithCString:((const char*)szAttr)];
	xmlFree(szAttr);
	
	
	//font
	if(xmlHasProp(xmlNode, BAD_CAST "font"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "font");
		style.font = [NSString stringWithCString:((const char*)szAttr)];
		xmlFree(szAttr);
	}
	
	//size
	if(xmlHasProp(xmlNode, BAD_CAST "size"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "size");
		style.size = atof((const char*)szAttr);
		xmlFree(szAttr);
	}
	
	//color
	if(xmlHasProp(xmlNode, BAD_CAST "color"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "color");
		NSString* s = [NSString stringWithCString:((const char*)szAttr)];
		xmlFree(szAttr);
		style.color = [StyleValue toColor3B:s];
	}
	
	//warning
	if(xmlHasProp(xmlNode, BAD_CAST "warning"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "warning");
		NSString* s = [NSString stringWithCString:((const char*)szAttr)];
		xmlFree(szAttr);
		style.warning = [StyleValue toColor3B:s];
	}
	
	//green
	if(xmlHasProp(xmlNode, BAD_CAST "green"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "green");
		NSString* s = [NSString stringWithCString:((const char*)szAttr)];
		xmlFree(szAttr);
		style.green = [StyleValue toColor3B:s];
	}
	
	//opacity
	if(xmlHasProp(xmlNode, BAD_CAST "opacity"))
	{	
		szAttr = xmlGetProp(xmlNode, BAD_CAST "opacity");
		NSString* s = [NSString stringWithCString:((const char*)szAttr)];
		xmlFree(szAttr);
		style.opacity = [StyleValue toGLubyte:s];
	}
	
	return style;
}

@end
