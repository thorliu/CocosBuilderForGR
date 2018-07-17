//
//  TexturesBiz.m
//  CocosBuilder
//
//  Created by liuqiang on 16/3/14.
//
//

#import "TexturesBiz.h"

#import "ResourceManager.h"
#include <libxml2/libxml/xmlreader.h>
#include <libxml2/libxml/parser.h>
#include <libxml2/libxml/tree.h>

@implementation TexturesBiz

+ (TexturesBiz*) sharedTexturesBiz
{
	static TexturesBiz* instance = NULL;
	
	if(!instance) instance = [[TexturesBiz alloc] init];
	
	return instance;
}


- (id) init
{
	self = [super init];
	if(!self) return NULL;
	
	projectTextures_ = [[NSMutableArray alloc] init];
	defaultHasPremultiplyAlpha_ = YES;
	
	return self;
}

- (BOOL) hasPremultiplyAlpha:(NSString *)textureName
{
	[self loadCurrentProjectTextures];
	
	NSArray* spans = [textureName componentsSeparatedByString:@"/"];
	
	if(spans.count > 0)
	{
		NSString* szFilename = [spans objectAtIndex:spans.count-1];
		
		int len = projectTextures_.count;
		
		for (int i = 0; i < len; i ++)
		{
			NSString* tName = [projectTextures_ objectAtIndex:i];
			
			if([szFilename hasPrefix:tName])
			{
				return !defaultHasPremultiplyAlpha_;
			}
		}
		
		
	}
	
	return defaultHasPremultiplyAlpha_;
}

- (void) loadCurrentProjectTextures
{
	NSString* filename = @"textures.xml";
	filename = [[ResourceManager sharedManager] toAbsolutePath:filename];
	if(!filename) return;
	
	[projectTextures_ removeAllObjects];
	
	const char* filepath = [filename UTF8String];
	const char* utf8 = "UTF-8";
	xmlDocPtr pdoc = xmlReadFile(filepath, utf8, XML_PARSE_RECOVER);
	
	if(pdoc != NULL)
	{
		xmlNodePtr proot = xmlDocGetRootElement(pdoc);
		if(proot != NULL)
		{
			xmlNodePtr nodeGroup;
			for(nodeGroup = proot->children; nodeGroup; nodeGroup = nodeGroup->next)
			{
				if(nodeGroup->type == XML_ELEMENT_NODE)
				{
					@try
					{
						if(strcmp((const char*)nodeGroup->name, "premultipliedAlpha") == 0)
						{
							xmlChar* szAttr = nil;
							
							if(xmlHasProp(nodeGroup, BAD_CAST "default"))
							{
								szAttr = xmlGetProp(nodeGroup, BAD_CAST "default");
								if(strcmp((const char*) szAttr, "YES") == 0)
								{
									defaultHasPremultiplyAlpha_ = YES;
								}
								else
								{
									defaultHasPremultiplyAlpha_ = NO;
								}
							}
							
							xmlNodePtr nodeItem;
							for(nodeItem = nodeGroup->children; nodeItem; nodeItem = nodeItem->next)
							{
								xmlChar *szKey = xmlNodeGetContent(nodeItem);
								NSString* itemText = [NSString stringWithCString:((const char*)szKey)];
								
								itemText = [itemText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
								xmlFree(szKey);
								
								if(itemText.length > 0)
								{
									[projectTextures_ addObject:[itemText copy]];
//
								}
							}

						}
					}
					@catch (NSException *exception)
					{
						NSLog(@"ERROR");
					}
					@finally
					{
						
					}
				}
			}
		}
	}
	
	
	NSLog(@"textures: %lud", projectTextures_.count);
}

- (void) loadPremultiplayAlphaSettings:(xmlNodePtr)node
{
	}

@end
