//
//  ShellManager.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/28.
//
//

#import <Foundation/Foundation.h>

@interface ShellManager : NSObject
{
	
}

+ (ShellManager*) sharedManager;

- (void) setupMenu:(NSMenu*)menuShell;
- (void) addMenuItem:(NSMenu*)menuShell title:(NSString*)title;
- (void) execute:(NSString*)action currentfile:(NSString*)currentfile;

@end
