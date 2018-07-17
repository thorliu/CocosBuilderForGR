//
//  StyleManager.m
//  CocosBuilder
//
//  Created by liuqiang on 15/12/31.
//
//

#import "StyleManager.h"
#import "StyleProject.h"
#import "StyleText.h"
#import "StyleImage.h"
#import "StyleButton.h"
#import "ResourceManager.h"

#include <libxml2/libxml/xmlreader.h>
#include <libxml2/libxml/parser.h>
#include <libxml2/libxml/tree.h>

#import "CCControlButton.h"
#import "CCScale9Sprite.h"

@implementation StyleManager

+ (StyleManager*) sharedManager
{
	static StyleManager* manager = NULL;
	if(!manager) manager = [[StyleManager alloc] init];
	return manager;
}


- (id) init
{
	self = [super init];
	if(!self) return NULL;
	
	projectStyles_ = [[NSMutableDictionary alloc] init];
	
	return self;
}


- (void)loadCurrentProjectStyle
{
	NSString* stylesFileName = @"styles.xml";
	stylesFileName = [[ResourceManager sharedManager] toAbsolutePath:stylesFileName];
	if(!stylesFileName) return;
	
	if([[projectStyles_ allKeys] containsObject:stylesFileName])
	{
		return;
	}
	
	const char* filepath = [stylesFileName UTF8String];
	const char* utf8 = "UTF-8";
	xmlDocPtr pdoc =  xmlReadFile(filepath, utf8, XML_PARSE_RECOVER);
	
	
	if(pdoc != NULL)
	{
		xmlNodePtr proot = xmlDocGetRootElement(pdoc);
		if(proot != NULL)
		{
			StyleProject* pProject = [[StyleProject alloc] init];
			pProject.name = stylesFileName;
			
			[projectStyles_ setObject:pProject forKey:stylesFileName];
			
			xmlNodePtr nodeGroup;
			
			for(nodeGroup  = proot->children; nodeGroup; nodeGroup = nodeGroup->next)
			{
				if(nodeGroup->type == XML_ELEMENT_NODE)
				{
//					NSLog(@"[%s]", nodeGroup->name);
					
					xmlNodePtr nodeStyle;
					for(nodeStyle = nodeGroup->children; nodeStyle; nodeStyle = nodeStyle->next)
					{
						if(nodeStyle->type == XML_ELEMENT_NODE)
						{
							@try
							{
								
								//text
								if(strcmp((const char*)nodeStyle->name, "textStyle") == 0)
								{
									StyleText* pText = [StyleText initWithXmlNode:nodeStyle];
									if(pText != nil)
									{
										[pProject.textStyles setObject:pText forKey:pText.name];
										[pProject.textStyleNames addObject:pText.name];
									}
								}
								//image
								else if(strcmp((const char*)nodeStyle->name, "imageStyle") == 0)
								{
									StyleImage* pImage = [StyleImage initWithXmlNode:nodeStyle];
									if(pImage != nil)
									{
										[pProject.imageStyles setObject:pImage forKey:pImage.name];
										[pProject.imageStyleNames addObject:pImage.name];
									}
								}
								//button
								else if(strcmp((const char*)nodeStyle->name, "buttonStyle") == 0)
								{
									StyleButton* pButton = [StyleButton initWithXmlNode:nodeStyle];
									if(pButton != nil)
									{
										[pProject.buttonStyles setObject:pButton forKey:pButton.name];
										[pProject.buttonStyleNames addObject:pButton.name];
									}
								}
								
							}
							@catch (NSException *exception)
							{
							}
						}
					}
				}
			}
		}
		
		xmlFreeDoc(pdoc);
	}
}


#pragma mark -

- (StyleProject*) getProject
{
	[self loadCurrentProjectStyle];
	
	NSString* stylesFileName = @"styles.xml";
	stylesFileName = [[ResourceManager sharedManager] toAbsolutePath:stylesFileName];
	if(!stylesFileName) return NULL;
	
	if(![[projectStyles_ allKeys] containsObject:stylesFileName])
	{
		return NULL;
	}
	
	StyleProject* project = [projectStyles_ objectForKey:stylesFileName];
	
	return project;
}


- (NSArray*) getTextStyleNames
{
	StyleProject* project = [self getProject];
	
	return project.textStyleNames;
	
//	return project.textStyles.allKeys;
}


- (NSArray*) getImageStyleNames
{
	StyleProject* project = [self getProject];
	
	return project.imageStyleNames;
	
//	return project.imageStyles.allKeys;
}


- (NSArray*) getButtonStyleNames
{
	StyleProject* project = [self getProject];
	
	return project.buttonStyleNames;
	
//	return project.buttonStyles.allKeys;
}


#pragma mark -

- (void)setTextStyle:(CCLabelTTF *)target style:(NSString *)style
{
	[self setTextStyle:target style:style textColorStyle:TextColorStyleNormal];
}

- (void)setTextStyle:(CCLabelTTF *)target style:(NSString *)style textColorStyle:(TextColorStyle)textColorStyle
{
	if(target == nil) return;
	
// NOTE: 根本就没有实现描边和阴影!
	
//	[target enableStroke:ccc3(0x00, 0x00, 0xFF) Size:5 UpdateTexture:NO];
//	[target enableShadow:CGSizeMake(20, 20) Opacity:0xFF Blur:0 UpdateTexture:NO];
	
	StyleProject* project = [self getProject];
	if(project != nil)
	{
		StyleText* textStyle = [project.textStyles objectForKey:style];
		if(textStyle != nil)
		{
			target.fontName = textStyle.font;
			target.fontSize = (float)textStyle.size;
			
			if(textColorStyle == TextColorStyleGreen)
			{
				target.color = textStyle.green;
			}
			else if(textColorStyle == TextColorStyleRed)
			{
				target.color = textStyle.warning;
			}
			else
			{
				target.color = textStyle.color;
			}
			
			target.opacity = textStyle.opacity;
			return;
		}
	}
	
	//默认样式
	target.fontName = @"Helvetica";
	target.fontSize = 12;
	
	if(textColorStyle == TextColorStyleGreen)
	{
		target.color = ccc3(0x33, 0xFF, 0x00);
	}
	if(textColorStyle == TextColorStyleRed)
	{
		target.color = ccc3(0xFF, 0x33, 0x00);
	}
	else
	{
		target.color = ccc3(0xFF, 0xFF, 0xFF);
	}
	target.opacity = 0xFF;
}


- (void)setButtonStyle:(CCControlButton *)target style:(NSString *)style
{
	if(target == nil) return;
	
	
	StyleProject* project = [self getProject];
	if(project != nil)
	{
		StyleButton* buttonStyle = [project.buttonStyles objectForKey:style];
		
		if(buttonStyle != nil)
		{
			[self setButtonStateStyle:target textStyle:buttonStyle.defaultText imageStyle:buttonStyle.defaultBackground state:CCControlStateNormal project:project];
			[self setButtonStateStyle:target textStyle:buttonStyle.pressedText imageStyle:buttonStyle.pressedBackground state:CCControlStateSelected project:project];
			[self setButtonStateStyle:target textStyle:buttonStyle.disabledText imageStyle:buttonStyle.disabledBackground state:CCControlStateSelected project:project];
			return;
		}
	}
	
	[self setButtonStateStyle:target textStyle:nil imageStyle:nil state:CCControlStateNormal project:project];
	[self setButtonStateStyle:target textStyle:nil imageStyle:nil state:CCControlStateSelected project:project];
	[self setButtonStateStyle:target textStyle:nil imageStyle:nil state:CCControlStateDisabled project:project];
	
}

- (void)setButtonStateStyle:(CCControlButton *)target textStyle:(NSString *)textStyle imageStyle:(NSString *)imageStyle state:(int)state project:(StyleProject *)project
{
	if(target == nil) return;
	
	//text
	bool useDefaultText = YES;
	if(project != nil && textStyle != nil)
	{
		StyleText* st = [project.textStyles objectForKey:textStyle];
		
		if(st != nil)
		{
			[target setTitleTTF:st.font forState:state];
			[target setTitleTTFSize:st.size forState:state];
			[target setTitleColor:st.color forState:state];
			//opacity
			useDefaultText = NO;
		}
	}
	
	if(useDefaultText)
	{
		[target setTitleTTF:@"Helvetica" forState:state];
		[target setTitleTTFSize:12 forState:state];
		[target setTitleColor:ccc3(0xFF, 0xFF, 0xFF) forState:state];
		//opacity
	}
	
	//background
	bool useDefaultBackground = YES;
	if(project != nil && imageStyle != nil)
	{
		StyleImage* si = [project.imageStyles objectForKey:imageStyle];
		
		if(si != nil)
		{
			CCSpriteFrame* spriteFrame = [si getSpriteFrame];
			CGRect spriteRect = CGRectMake(si.spliceLeft, si.spliceTop, si.spliceRight, si.spliceBottom);
			CCScale9Sprite* s9 = [CCScale9Sprite spriteWithSpriteFrame:spriteFrame];
			s9.insetLeft = si.spliceLeft;
			s9.insetTop = si.spliceTop;
			s9.insetRight = si.spliceRight;
			s9.insetBottom = si.spliceBottom;
			
			[target	setBackgroundSprite:s9 forState:state];
			
			s9.opacity = si.opacity;
			[s9 setColor:si.color];
			
			useDefaultBackground = NO;
		}
	}
	
	if(useDefaultBackground)
	{
		// Texture is missing
		CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:@"missing-texture.png"];
		CGRect bounds = CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height);
		
		CCSpriteFrame* spriteFrame = [CCSpriteFrame frameWithTexture:texture rect:bounds] ;
		
		CCScale9Sprite* s9 = [CCScale9Sprite spriteWithSpriteFrame:spriteFrame];
		[target setBackgroundSprite:s9 forState:state];
	}
};

@end














