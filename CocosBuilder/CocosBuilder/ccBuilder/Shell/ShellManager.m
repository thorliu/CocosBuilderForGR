//
//  ShellManager.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/28.
//
//

#import "ShellManager.h"
#import "CocosBuilderAppDelegate.h"
#import "ResourceManager.h"
#import "CCBDocument.h"

@implementation ShellManager

+ (ShellManager*) sharedManager
{
	static ShellManager* manager = NULL;
	if(!manager) manager = [[ShellManager alloc]init];
	
	return manager;
}

- (void) addMenuItem:(NSMenu *)menuShell title:(NSString *)title
{
	NSMenuItem* item = [[[NSMenuItem alloc] initWithTitle:title action:@selector(menuItemClick:) keyEquivalent:title] autorelease];
	item.target = self;
	
	[menuShell addItem:item];
}

- (IBAction)menuItemClick:(id)sender
{
	CocosBuilderAppDelegate* ad = [CocosBuilderAppDelegate appDelegate];
	if(!ad.hasOpenedDocument) return;
	
	NSMenuItem* item = (NSMenuItem*)sender;
	
	CCBDocument* currentDocument = ad.currentDocument;
	if(currentDocument == nil) return;
	
	
	NSString* actionName = item.title;
	NSString* currentFile = currentDocument.fileName;
	
	[self execute:actionName currentfile:currentFile];
	
//	[[NSAlert alertWithMessageText:actionName defaultButton:@"OK" alternateButton:NULL otherButton:NULL informativeTextWithFormat:currentFile] runModal];
}

#pragma mark -

//定义菜单项
- (void)setupMenu:(NSMenu *)menuShell
{
//	[self addMenuItem:menuShell title:@"to C++ (default.h)"];
//	[self addMenuItem:menuShell title:@"to C++ (popup.h)"];
//	[self addMenuItem:menuShell title:@"to C++ (popup.cpp)"];
//	[self addMenuItem:menuShell title:@"to C++ (usercontrol.h)"];
//	[self addMenuItem:menuShell title:@"to C++ (usercontrol.cpp)"];
}

//执行脚本
- (void)execute:(NSString *)action currentfile:(NSString *)currentfile
{
//	NSString* shFile = @"cocosbuilder_shell/ccb2cpp.sh";
//	NSString* shCCB = currentfile;
//	NSString* shTemplate = @"";
//	
//	shFile = [[ResourceManager sharedManager] toAbsolutePath:shFile];
//	
//	if(action == @"to C++ (popup.h)")
//	{
//		shTemplate = @"popup.h";
//	}
//	else if(action == @"to C++ (popup.cpp)")
//	{
//		shTemplate = @"popup.cpp";
//	}
//	else if(action == @"to C++ (usercontrol.h)")
//	{
//		shTemplate = @"usercontrol.h";
//	}
//	else if(action == @"to C++ (usercontrol.cpp)")
//	{
//		shTemplate = @"usercontrol.cpp";
//	}
//	
//	[[NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:@[shFile, shCCB, shTemplate]] waitUntilExit];
}



@end
