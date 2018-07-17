//
//  CCPlaceHolder.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/7.
//
//

#import "CCPlaceHolder.h"

@implementation CCPlaceHolder

//@synthesize nodeType;


- (id) init
{
	if(self = [super init])
	{
		[self initWithColor:ccc4(0x00, 0x99, 0xFF, 0x60) width:100 height:100];
		[self setContentSize:CGSizeMake(100, 100)];
		
//		self.nodeType = 1;
//		CCLabelTTF* label = [[CCLabelTTF alloc] initWithString:@"" fontName:@"" fontSize:20];
//		[self addChild:label];
	}
	
	return self;
}

@end
