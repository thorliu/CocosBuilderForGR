//
//  InspectorStyleImage.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/3.
//
//

#import <Foundation/Foundation.h>
#import "InspectorValue.h"
#import "CCNode+NodeInfo.h"
#import "SequencerHandler.h"
#import "SequencerSequence.h"

@interface InspectorStyleImage : InspectorValue
{
	IBOutlet NSPopUpButton* popup;
	IBOutlet NSMenu* menu;
}
@end
