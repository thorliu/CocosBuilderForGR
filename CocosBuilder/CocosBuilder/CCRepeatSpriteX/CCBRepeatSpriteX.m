//
//  CCBRepeatSpriteX.m
//  CocosBuilder
//
//  Created by liuqiang on 16/5/25.
//
//

#import "CCBRepeatSpriteX.h"
#import "CocosBuilderAppDelegate.h"
#import "CCBDocument.h"
#import "ResolutionSetting.h"


@implementation CCBRepeatSpriteX

- (float) resolutionScale
{
	CCBDocument* currentDocument = [CocosBuilderAppDelegate appDelegate].currentDocument;
	
	ResolutionSetting* resolution = [currentDocument.resolutions objectAtIndex:currentDocument.currentResolution];
	
	return resolution.scale;
}


@end
