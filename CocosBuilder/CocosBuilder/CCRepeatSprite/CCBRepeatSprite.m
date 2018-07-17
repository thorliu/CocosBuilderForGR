//
//  CCBScale9Sprite.m
//  CocosBuilder
//
//  Created by Viktor Lidholt on 4/4/13.
//
//

#import "CCBRepeatSprite.h"
#import "CocosBuilderAppDelegate.h"
#import "CCBDocument.h"
#import "ResolutionSetting.h"

@implementation CCBRepeatSprite

- (float) resolutionScale
{
	CCBDocument* currentDocument = [CocosBuilderAppDelegate appDelegate].currentDocument;
	
	ResolutionSetting* resolution = [currentDocument.resolutions objectAtIndex:currentDocument.currentResolution];
	
	return resolution.scale;
}


@end
