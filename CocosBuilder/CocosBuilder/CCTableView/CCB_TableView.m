//
//  CCB_TableView.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/11.
//
//

#import "CCB_TableView.h"
#import "ResourceManager.h"
#import "CCBReaderInternal.h"
#import "CCBGlobals.h"
#import "CCBDocument.h"
#import "CocosBuilderAppDelegate.h"
#import "CCNode+NodeInfo.h"
#import "CCDirector.h"

@implementation CCB_TableView


@synthesize direction						= direction_;
@synthesize itemSize						= itemSize_;
@synthesize wrapCount						= wrapCount_;
@synthesize itemTemplate					= itemTemplate_;

- (id) init
{
	if(self = [super init])
	{
		itemTemplate_ = @"";
		wrapCount_ = 1;
		itemSize_ = CGSizeMake(100, 100);
		direction_ = CCTableViewDirectionHorizontal;
		
		
		containerNode_ = [[CCNode alloc] init];
		[self addChild:containerNode_];
		
		
	}
	return self;
}

- (void) setDirection:(CCTableViewDirection)v
{
	direction_ = v;
	[self updateLayout];
}

- (void) setItemSize:(CGSize)v
{
	itemSize_ = v;
	[self updateLayout];
}

- (void) setWrapCount:(int)v
{
	wrapCount_ = v;
	[self updateLayout];
}

- (void) setItemTemplate:(NSString *)v
{
	itemTemplate_ = v;
	[self updateLayout];
}

- (void) setContentSize:(CGSize)v
{
	[super setContentSize:v];
	[self updateLayout];
}

- (CCNode*) createItemNode
{
	CCLayerColor* ret = [[CCLayerColor alloc] initWithColor:ccc4(0xFF, 0, 0, 0x80) width:itemSize_.width height:itemSize_.height];
	
	ret.ignoreAnchorPointForPosition = false;
	ret.anchorPoint = CGPointZero;
	ret.scale = 0.9f;
	
	return ret;
}

- (void) updateLayout
{
	[containerNode_ removeAllChildren];
	
	if(itemTemplate_ == nil || [itemTemplate_ isEqualToString:@""])
	{
		return;
	}
	
	CocosBuilderAppDelegate* ad = [CocosBuilderAppDelegate appDelegate];
	NSString* fileNameAbs = [[ResourceManager sharedManager] toAbsolutePath:itemTemplate_];
	if([ad.currentDocument.fileName isEqualToString:fileNameAbs]) return;
	
	NSMutableDictionary* doc = [NSMutableDictionary dictionaryWithContentsOfFile:fileNameAbs];
	
	CGSize t_cs = CGSizeMake(self.contentSize.width, self.contentSize.height);
	CGSize t_is = CGSizeMake(itemSize_.width, itemSize_.height);
	
//	[clipNode_ setContentSize:t_cs];
	
//	maskNode_.scaleX = t_cs.width / 100.0f;
//	maskNode_.scaleY = t_cs.height / 100.0f;
	
	int rows = 0;
	int cols = 0;
	int wc = wrapCount_;
	if(wc < 1) wc = 1;
	
	if(t_is.width < 1 || t_is.height < 1) return;
	
	if(direction_ == CCTableViewDirectionHorizontal)
	{
		//横向
		rows = wc;
		cols = t_cs.width / t_is.width;
		if(cols * t_is.width < t_cs.width) cols++;
	}
	else
	{
		//纵向
		cols = wc;
		rows = t_cs.height / t_is.height;
		if(rows * t_is.height < t_cs.height) rows++;
	}
	
	
	for(int r = 0; r < rows; r++)
	{
		for(int c = 0; c < cols; c++)
		{
			CCNode* nodeHost = [[CCNode alloc] init];
			nodeHost.locked = YES;
			CCNode* node = nil;
			if([[doc objectForKey:@"fileType"] isEqualToString:@"CocosBuilder"] && [[doc objectForKey:@"fileVersion"] intValue] <= kCCBFileFormatVersion)
			{
				node = [CCBReaderInternal nodeGraphFromDictionary:[doc objectForKey:@"nodeGraph"] parentSize:t_is];
			}
			
			if(node == nil) continue;
	
			CGPoint item_pos = ccp(c * itemSize_.width,  r * itemSize_.height);
			item_pos.y = (t_cs.height - item_pos.y - itemSize_.height);
			
			
			[nodeHost setPosition:item_pos];
			
			[nodeHost addChild:node];
			[containerNode_ addChild:nodeHost];
//			NSLog(@"创建元素: r = %d, c = %d", r, c);
		}
	}
	
//	NSLog(@"------------------- [%dx%d]", rows, cols);
}

#pragma mark - 

-(void)beforeDraw
{
	CGRect rect = self.boundingBox;
	CGPoint posLeftBottom = ccp(rect.origin.x, rect.origin.y);
	CGPoint posRightTop = ccp(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
	
	posLeftBottom = [_parent convertToWorldSpace:posLeftBottom];
	posRightTop = [_parent convertToWorldSpace:posRightTop];
	
	
	if(YES)
	{
		glEnable(GL_SCISSOR_TEST);
	
		
#ifdef __CC_PLATFORM_IOS
		CCDirectorIOS *director = (CCDirectorIOS *) [CCDirector sharedDirector];
		s *= [director contentScaleFactor];
#endif
		
//		glScissor(screenPos.x, screenPos.y, sizePos.x, sizePos.y);
		float gl_x = posLeftBottom.x;
		float gl_y = posLeftBottom.y;
		float gl_w = posRightTop.x - posLeftBottom.x;
		float gl_h = posRightTop.y - posLeftBottom.y;
		
//		NSLog(@"glScissor(%f, %f, %f, %f)", gl_x, gl_y, gl_w, gl_h);
		glScissor(gl_x, gl_y, gl_w, gl_h);
	}
}

-(void)afterDraw {
	if (YES)
	{
		glDisable(GL_SCISSOR_TEST);
	}
}

-(void) visit
{
	// quick return if not visible
	if (!_visible)
		return;
	
	kmGLPushMatrix();
	
	//	glPushMatrix();
	
	if ( _grid && _grid.active) {
		[_grid beforeDraw];
		[self transformAncestors];
	}
	[self transform];
	[self beforeDraw];
	if(_children) {
		ccArray *arrayData = _children->data;
		NSUInteger i=0;
		
		// draw children zOrder < 0
		for( ; i < arrayData->num; i++ ) {
			CCNode *child =  arrayData->arr[i];
			if ( [child zOrder] < 0 ) {
				[child visit];
			} else
				break;
		}
		
		// self draw
		[self draw];
		
		// draw children zOrder >= 0
		for( ; i < arrayData->num; i++ ) {
			CCNode *child =  arrayData->arr[i];
			[child visit];
		}
		
	} else
		[self draw];
	
	[self afterDraw];
	if ( _grid && _grid.active)
		[_grid afterDraw:self];
	
	kmGLPopMatrix();
	
	//	glPopMatrix();
}

@end
