//
//  InspectorStyleButton.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/3.
//
//

#import "InspectorStyleButton.h"
#import "CocosBuilderAppDelegate.h"
#import "StyleManager.h"

@implementation InspectorStyleButton

- (void) willBeAdded
{
	[menu removeAllItems];
	
	NSMenuItem* menuItem = [[[NSMenuItem alloc] initWithTitle:@"(None)" action:@selector(selectedResource:) keyEquivalent:@""] autorelease];
	menuItem.representedObject = @"";
	menuItem.target = self;
	[menu addItem:menuItem];
	
	//---
	
	NSString* currentStyleName = [selection valueForKey:@"style"];
	
	NSArray* styles = [[StyleManager sharedManager] getButtonStyleNames];
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
	[[CocosBuilderAppDelegate appDelegate] saveUndoStateWillChangeProperty:propertyName];
	
	
	NSString* sf = @"style";
	NSString* ssf = [sender title];
	
	if (sf && ssf)
	{
		[selection setExtraProp:sf forKey:propertyName];
		[selection setExtraProp:ssf forKey:[NSString stringWithFormat:@"%@Style", propertyName]];
		
		[selection setValue:ssf forKey:sf];
	}
}

@end
