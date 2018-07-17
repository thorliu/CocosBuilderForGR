//
//  InspectorStyleText.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/3.
//
//

#import "InspectorStyleText.h"
#import "CocosBuilderAppDelegate.h"
#import "StyleManager.h"

@implementation InspectorStyleText

- (void) willBeAdded
{
	/*
	 SequencerSequence* seq = [SequencerHandler sharedHandler].currentSequence;
	 id value = [selection valueForProperty:propertyName atTime:seq.timelinePosition sequenceId:seq.sequenceId];
	 
	 NSString* sf = [value objectAtIndex:0];
	 NSString* ssf = [value objectAtIndex:1];
	 
	 if ([ssf isEqualToString:kCCBUseRegularFile] || [ssf isEqualToString:@""]) ssf = NULL;
	 
	 [ResourceManagerUtil populateResourcePopup:popup resType:kCCBResTypeImage allowSpriteFrames:YES selectedFile:sf selectedSheet:ssf target:self];
	 
	 
	 */
	
	[menu removeAllItems];
	
	NSMenuItem* menuItem = [[[NSMenuItem alloc] initWithTitle:@"(None)" action:@selector(selectedResource:) keyEquivalent:@""] autorelease];
	menuItem.representedObject = @"";
	menuItem.target = self;
	[menu addItem:menuItem];
	
	//---
	
	NSString* currentStyleName = [selection valueForKey:@"style"];
	
	NSArray* styles = [[StyleManager sharedManager] getTextStyleNames];
	NSString* styleName = nil;
	
	for(int i = 0; i < styles.count; i ++)
	{
		styleName = [[styles objectAtIndex:i] copy];
		menuItem = [[[NSMenuItem alloc] initWithTitle:styleName action:@selector(selectedResource:) keyEquivalent:@""] autorelease];
		
		menuItem.representedObject = @"";
		menuItem.target = self;
		[menu addItem: menuItem];
	}
	
	if(currentStyleName == nil || [currentStyleName isEqualToString:@""])
	{
		[popup setTitle:@"(None)"];
	}
	else
	{
		[popup setTitle:currentStyleName];
	}
	
}


- (void) selectedResource:(id)sender
{
//	NSLog(@"selectedResource");
	
	[[CocosBuilderAppDelegate appDelegate] saveUndoStateWillChangeProperty:propertyName];
	

	NSString* sf = @"style";
	NSString* ssf = [sender title];

	if (sf && ssf)
	{
		[selection setExtraProp:sf forKey:propertyName];
		[selection setExtraProp:ssf forKey:[NSString stringWithFormat:@"%@Style", propertyName]];
		
		[selection setValue:ssf forKey:sf];
		
	
//		[TexturePropertySetter setSpriteFrameForNode:selection andProperty:propertyName withFile:sf andSheetFile:ssf];
//		
//		[self updateAnimateablePropertyValue:[NSArray arrayWithObjects:sf, ssf , nil]];
	}
}

@end
