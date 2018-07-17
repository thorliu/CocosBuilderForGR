//
//  StyleProject.m
//  CocosBuilder
//
//  Created by liuqiang on 15/12/31.
//
//

#import "StyleProject.h"

@implementation StyleProject

@synthesize name;
@synthesize textStyles;
@synthesize imageStyles;
@synthesize buttonStyles;
@synthesize textStyleNames;
@synthesize imageStyleNames;
@synthesize buttonStyleNames;

- (id) init
{
	self = [super init];
	if(!self) return NULL;
	
	textStyles = [[NSMutableDictionary alloc] init];
	imageStyles = [[NSMutableDictionary alloc] init];
	buttonStyles = [[NSMutableDictionary alloc] init];
	
	textStyleNames = [[NSMutableArray alloc] init];
	imageStyleNames = [[NSMutableArray alloc] init];
	buttonStyleNames = [[NSMutableArray alloc] init];
	
	return self;
}

- (void) dealloc
{
	self.name = NULL;
	
	[textStyles release];
	[imageStyles release];
	[buttonStyles release];
	
	[textStyleNames release];
	[imageStyleNames release];
	[buttonStyleNames release];
	
	[super dealloc];
}

@end
