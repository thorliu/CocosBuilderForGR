//
//  SequencerButtonCell.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/20.
//
//

#import <Foundation/Foundation.h>
#import <Cocoa/cocoa.h>
#import "cocos2d.h"

@interface SequencerButtonCell : NSButtonCell
{
	NSImage * imgRowBgChannel;
	BOOL      imagesLoaded;
	
	CCNode * _node;
	
}

@property (nonatomic,assign) CCNode* node;

@property (nonatomic,assign) int type;

@end
