//
//  TexturesBiz.h
//  CocosBuilder
//
//  Created by liuqiang on 16/3/14.
//
//

#import <Foundation/Foundation.h>





@interface TexturesBiz : NSObject
{
	NSMutableArray* projectTextures_;
	BOOL defaultHasPremultiplyAlpha_;
}

+ (TexturesBiz*) sharedTexturesBiz;

- (void) loadCurrentProjectTextures;

- (BOOL) hasPremultiplyAlpha:(NSString*)textureName;

@end
