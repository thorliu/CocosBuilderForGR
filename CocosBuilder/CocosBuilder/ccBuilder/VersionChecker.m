//
//  VersionChecker.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/29.
//
//

#import "VersionChecker.h"
#import "CocosBuilderAppDelegate.h"

@implementation VersionChecker

+ (VersionChecker*) sharedChecker
{
	static VersionChecker* checker = NULL;
	if(!checker) checker = [[VersionChecker alloc] init];
	
	return checker;
}


- (void) load
{
	
//	@try
//	{
//		NSString* baseUrl = @"http://10.0.3.8:8080/fileshare/Tools/CocosBuilder/Docs/";
//		NSString* versionUrl = @"Version.txt";
//		NSString* installUrl = @"docs.html?key=ccb_app_install&t=20160201920";
//
//		//读取版本号
//		NSString* targetVersionUrl = [[baseUrl copy] stringByAppendingString:versionUrl];
//		NSURL* targetVersionUrlObject = [NSURL URLWithString:targetVersionUrl];
//		NSURLRequest* urlRequest = [NSURLRequest requestWithURL:targetVersionUrlObject cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5];
//		NSURLResponse* response = nil;
//		NSError* error = nil;
//		NSData* data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
//
//		if(data.length == 0 || error !=nil) return;
//
//		int statusCode = [((NSHTTPURLResponse *)response) statusCode];
//
//		if(statusCode != 200) return;
//
//		_lastVersion = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//
//		NSString* _currentVersion = [self getCurrentVersion];
//
//		//对比版本号
//		int c = strcmp([_lastVersion UTF8String], [_currentVersion UTF8String]);
//
//		if(c > 0)
//		{
//
//			NSLog(@"需要更新");
//
//			NSString* targetInstallUrl = [[baseUrl copy] stringByAppendingString:installUrl];
//			NSURL* targetInstallUrlObject = [NSURL URLWithString:targetInstallUrl];
//
//			[[CocosBuilderAppDelegate appDelegate] modalDialogTitle:_lastVersion message:@"CocosBuilder已经发布新版本，请更新至最新版本."];
//
//			[[NSWorkspace sharedWorkspace] openURL:targetInstallUrlObject];
//
//			//强制退出
//	//		[NSApp terminate:self];
//		}
//		else
//		{
//			NSLog(@"已是新版");
//		}
//	}
//	@catch (NSException *exception) {
//
//	}
	

};


- (NSString*) getCurrentVersion
{
	NSString* versionPath = [[NSBundle mainBundle] pathForResource:@"Version" ofType:@"txt" inDirectory:@"version"];
	
	NSString* version = [NSString stringWithContentsOfFile:versionPath encoding:NSUTF8StringEncoding error:NULL];
	return version;
}

- (NSString*) getLastVersion
{
	return _lastVersion;
}


@end
