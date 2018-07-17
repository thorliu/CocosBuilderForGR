//
//  StyleProject.h
//  CocosBuilder
//
//  Created by liuqiang on 15/12/31.
//
//

#import <Foundation/Foundation.h>

@interface StyleProject : NSObject
{
	NSString* name;
	
	NSMutableDictionary* textStyles;
	NSMutableArray* textStyleNames;
	
	NSMutableDictionary* imageStyles;
	NSMutableArray* imageStyleNames;
	
	NSMutableDictionary* buttonStyles;
	NSMutableArray* buttonStyleNames;
}

@property (nonatomic, copy) NSString* name;
@property (nonatomic, readonly) NSMutableDictionary* textStyles;
@property (nonatomic, readonly) NSMutableDictionary* imageStyles;
@property (nonatomic, readonly) NSMutableDictionary* buttonStyles;

@property (nonatomic, readonly) NSMutableArray* textStyleNames;
@property (nonatomic, readonly) NSMutableArray* imageStyleNames;
@property (nonatomic, readonly) NSMutableArray* buttonStyleNames;

@end
