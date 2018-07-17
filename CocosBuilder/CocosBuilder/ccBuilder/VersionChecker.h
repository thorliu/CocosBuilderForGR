//
//  VersionChecker.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/29.
//
//

#import <Foundation/Foundation.h>

@interface VersionChecker : NSObject
{
	NSString* _lastVersion;
}

+ (VersionChecker*) sharedChecker;

- (void) load;

- (NSString*) getCurrentVersion;
- (NSString*) getLastVersion;


@end
