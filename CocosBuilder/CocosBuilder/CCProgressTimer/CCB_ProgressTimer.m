//
//  CCB_ProgressTimer.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/12.
//
//

#import "CCB_ProgressTimer.h"

@implementation CCB_ProgressTimer


- (void)setSpriteFrame:(CCSpriteFrame *)newValue;
{
	CCSprite* s = [[CCSprite alloc] initWithSpriteFrame:newValue];
	[self setSprite:s];
}


- (id) init
{
	if(self =  [super init])
	{
		
	}
	
	return self;
}


@end
