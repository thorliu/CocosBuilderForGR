//
//  StyleImage.m
//  CocosBuilder
//
//  Created by liuqiang on 15/12/31.
//
//

#import "StyleImage.h"

#import "ResourceManager.h"
#import "CCBFileUtil.h"
#import "StyleValue.h"

@implementation StyleImage

@synthesize name;
@synthesize plist;
@synthesize image;
@synthesize color;
@synthesize opacity;
@synthesize spliceLeft;
@synthesize spliceTop;
@synthesize spliceRight;
@synthesize spliceBottom;

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
	
	StyleImage* style = [[StyleImage alloc] init];
	
	//name
	xmlChar* szAttr = xmlGetProp(xmlNode, BAD_CAST "name");
	style.name = [NSString stringWithCString:((const char*)szAttr)];
	xmlFree(szAttr);
	
	//plist
	if(xmlHasProp(xmlNode, BAD_CAST "plist"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "plist");
		style.plist = [NSString stringWithCString:((const char*)szAttr)];
		xmlFree(szAttr);
	}
	
	//image
	if(xmlHasProp(xmlNode, BAD_CAST "image"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "image");
		style.image = [NSString stringWithCString:((const char*)szAttr)];
		xmlFree(szAttr);
	}
	
	//color
	if(xmlHasProp(xmlNode, BAD_CAST "color"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "color");
		style.color = [StyleValue toColor3B:[NSString stringWithCString:((const char*)szAttr)]];
		xmlFree(szAttr);
	}
	
	//opacity
	if(xmlHasProp(xmlNode, BAD_CAST "opacity"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "opacity");
		NSString* s = [NSString stringWithCString:((const char*)szAttr)];
		xmlFree(szAttr);
		style.opacity = [StyleValue toGLubyte:s];
	}
	
	//splices
	if(xmlHasProp(xmlNode, BAD_CAST "splices"))
	{
		szAttr = xmlGetProp(xmlNode, BAD_CAST "splices");
		NSString* splicesValue = [NSString stringWithCString:((const char*)szAttr)];
		xmlFree(szAttr);
		
		NSArray* splicesArray = [splicesValue componentsSeparatedByString:@","];
		if(splicesArray.count == 4)
		{
			style.spliceLeft = atoi([[splicesArray objectAtIndex:0] UTF8String]);
			style.spliceTop = atoi([[splicesArray objectAtIndex:1] UTF8String]);
			style.spliceRight = atoi([[splicesArray objectAtIndex:2] UTF8String]);
			style.spliceBottom = atoi([[splicesArray objectAtIndex:3] UTF8String]);
		}
	}
	
	
	return style;
}

- (CCSpriteFrame*) getSpriteFrame
{
	CCSpriteFrame* spriteFrame = NULL;
	
	if(plist && ![plist isEqualToString:@""])
	{
		@try
		{
			NSString* file = [[ResourceManager sharedManager] toAbsolutePath:plist];
			file = [CCBFileUtil toResolutionIndependentFile:file];
			[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:file];
			
			spriteFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:image];
		}
		@catch(NSException* exception)
		{
			spriteFrame = NULL;
		}
	}
	else if(image && ![image isEqualToString:@""])
	{
		@try
		{
			NSString* file = [CCBFileUtil toResolutionIndependentFile:image];
			CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:image];
			
			if(texture)
			{
				CGRect bounds = CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height);
				spriteFrame = [CCSpriteFrame frameWithTexture:texture rect:bounds];
			}
		}
		@catch (NSException *exception)
		{
			spriteFrame = NULL;
		}
		
	}
	
	
	if (!spriteFrame)
	{
		// Texture is missing
		CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:@"missing-texture.png"];
		CGRect bounds = CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height);
		
		spriteFrame = [CCSpriteFrame frameWithTexture:texture rect:bounds] ;
	}
	
	return spriteFrame;
}


@end
