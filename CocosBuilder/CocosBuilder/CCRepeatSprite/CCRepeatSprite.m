//
//  CCRepeatSprite.m
//  CocosBuilder
//
//  Created by liuqiang on 15/12/29.
//
//

#import "CCRepeatSprite.h"

//test
#import "StyleManager.h"

enum positions
{
	pCentre = 0,
	pTop,
	pLeft,
	pRight,
	pBottom,
	pTopRight,
	pTopLeft,
	pBottomRight,
	pBottomLeft
};

@interface CCRepeatSprite ()

- (id)initWithBatchNode:(CCSpriteBatchNode *)batchnode rect:(CGRect)rect;
- (void)updateWithBatchNode:(CCSpriteBatchNode*)batchnode rect:(CGRect)rect rotated:(BOOL)rotated;
- (void)updatePosition;

@end

@implementation CCRepeatSprite
@synthesize originalSize			= originalSize_;
@synthesize opacity					= opacity_;
@synthesize color					= color_;
@synthesize opacityModifyRGB		= opacityModifyRGB_;
@synthesize preferedSize			= preferedSize_;
@synthesize horizontalRepeat		= horizontalRepeat_;
@synthesize verticalRepeat			= verticalRepeat_;

- (void)dealloc
{
	[images				release];
	
	//TODO: 释放用于存放图片的数组
	
	[super				dealloc];
}


#pragma mark Constructor - Initializers


- (id)initWithBatchNode:(CCSpriteBatchNode *)batchnode rect:(CGRect)rect rotated:(BOOL)rotated
{
	if((self = [super init]))
	{
		if(batchnode)
		{
			[self updateWithBatchNode:batchnode rect:rect rotated:rotated];
			_anchorPoint = ccp(0.5f, 0.5f);
		}
		positionsAreDirty_ = YES;
	}
	return self;
}


- (id)initWithBatchNode:(CCSpriteBatchNode *)batchnode rect:(CGRect)rect
{
	return [self initWithBatchNode:batchnode rect:rect rotated:NO];
}


- (id)initWithFile:(NSString *)file rect:(CGRect)rect
{
	NSAssert(file != nil, @"Invalid file for sprite");
	CCSpriteBatchNode *batchnode = [CCSpriteBatchNode batchNodeWithFile:file];
	
	return [self initWithBatchNode:batchnode rect:rect];
}


+ (id)spriteWithFile:(NSString *)file rect:(CGRect)rect
{
	return [[[self alloc] initWithFile:file rect:rect] autorelease];
}


- (id)initWithFile:(NSString *)file
{
	NSAssert(file != nil, @"Invalid file for sprite");
	
	return [self initWithFile:file rect:CGRectZero];
}


+ (id)spriteWithFile:(NSString *)file
{
	return [[[self alloc] initWithFile:file] autorelease];
}


- (id)initWithSpriteFrame:(CCSpriteFrame *)spriteFrame
{
	NSAssert(spriteFrame != nil, @"Invalid file for sprite");
	
	return [self initWithSpriteFrame:spriteFrame];
}


+ (id)spriteWithSpriteFrame:(CCSpriteFrame *)spriteFrame
{
	return [[[self alloc] initWithSpriteFrame:spriteFrame] autorelease];
}


- (id)initWithSpriteFrameName:(NSString *)spriteFrameName
{
	return [self  initWithSpriteFrameName:spriteFrameName];
}


+ (id)spriteWithSpriteFrameName:(NSString *)spriteFrameName
{
	return [[[self alloc] initWithSpriteFrameName:spriteFrameName] autorelease];
}


- (id)init
{
	return [self initWithBatchNode:NULL rect:CGRectZero];
}


- (void)updateWithBatchNode:(CCSpriteBatchNode *)batchnode rect:(CGRect)rect rotated:(BOOL)rotated
{
	GLubyte opacity = opacity_;
	ccColor3B color = color_;
	
	[self removeAllChildrenWithCleanup:YES];
	
	
	if(images != batchnode)
	{
		[images release];
		images = [batchnode retain];
//		images.parentPlugIn = self;
	}
	
	spriteFrameRotated_ = rotated;
	
	
	if(CGRectEqualToRect(rect, CGRectZero))
	{
		CGSize textureSize = [[[images textureAtlas] texture] contentSize];
		
		rect = CGRectMake(0, 0, textureSize.width, textureSize.height);
	}
	
	spriteRect = rect;
//	originalSize_ = rect.size;
//	preferedSize_ = originalSize_;
	
	[self updateRepeatImages];
	
	[self setContentSize:rect.size];
	[self addChild:images];
	
	if(spritesGenerated_)
	{
		self.opacity = opacity;
		self.color = color;
	}
	spritesGenerated_ = YES;
}

#pragma Properties

- (void)setContentSize:(CGSize)size
{
	super.contentSize = size;
	positionsAreDirty_ = YES;
}


- (void)updatePosition
{
	//TODO: 更新位置
}


- (void)setPreferedSize:(CGSize)preferedSize
{
	self.contentSize = preferedSize;
	preferedSize_ = preferedSize;
	
	[self updateRepeatImages];
}


- (void)setColor:(ccColor3B)color
{
	color_ = color;
	for (CCNode<CCRGBAProtocol> *child in images.children)
	{
		[child setColor:color];
	}
}


- (void)setOpacity:(GLubyte)opacity
{
	opacity_ = opacity;
	
	for(CCNode<CCRGBAProtocol> *child in images.children)
	{
		[child setOpacity:opacity];
	}
}


- (void)setHorizontalRepeat:(BOOL)horizontalRepeat
{
	horizontalRepeat_ = horizontalRepeat;
	
	[self updateRepeatImages];
//	[[StyleManager sharedManager] loadCurrentProjectStyle];
}

- (void)setVerticalRepeat:(BOOL)verticalRepeat
{
	verticalRepeat_ = verticalRepeat;
	
	[self updateRepeatImages];
}


- (void)setOpacityModifyRGB:(BOOL)opacityModifyRGB
{
	opacityModifyRGB_ = opacityModifyRGB;
	
	for(CCNode<CCRGBAProtocol> *child in images.children)
	{
		[child setOpacityModifyRGB:opacityModifyRGB];
	}
}


- (void)setSpriteFrame:(CCSpriteFrame *)spriteFrame
{
	CCSpriteBatchNode *batchnode = [CCSpriteBatchNode batchNodeWithTexture:spriteFrame.texture];
	[self updateWithBatchNode:batchnode rect:spriteFrame.rect rotated:spriteFrame.rotated];
	
}


- (void)visit
{
//	NSLog(@"visit ?");
	if(positionsAreDirty_)
	{
		[self updatePosition];
		
		positionsAreDirty_ = NO;
	}
	
	[super visit];
}


- (void)updateRepeatImages
{
	[images removeAllChildrenWithCleanup:YES];
	
	
	int targetWidth = preferedSize_.width;
	int targetHeight = preferedSize_.height;
	
	if(targetWidth <= 0 || targetHeight <= 0)
	{
		return;
	}
	
	int spliceRows = 0;
	int spliceCols = 0;
	
	int spliceWidth = 0;
	int spliceHeight = 0;
	
	if(spriteFrameRotated_)
	{
		spliceHeight = spriteRect.size.height;
		spliceWidth = spriteRect.size.width;
		
		targetWidth = preferedSize_.width;
		targetHeight = preferedSize_.height;
	}
	else
	{
		spliceWidth = spriteRect.size.width;
		spliceHeight = spriteRect.size.height;
		
		targetWidth = preferedSize_.width;
		targetHeight = preferedSize_.height;
	}
	
	spliceRows = targetHeight / spliceHeight;
	spliceCols = targetWidth / spliceWidth;
	
	if(targetWidth % spliceWidth > 0) spliceCols ++;
	if(targetHeight % spliceHeight > 0) spliceRows ++;
	
	if(!horizontalRepeat_)
	{
		if(spliceCols > 1) spliceCols = 1;
	}
	
	if(!verticalRepeat_)
	{
		if(spliceRows > 1) spliceRows = 1;
	}
	
//	NSLog(@"updateRepeatImages rows = %d, cols = %d, sw = %d, sh = %d", spliceRows, spliceCols, spliceWidth, spliceHeight);
	
	
	//----
	CGRect rect = spriteRect;
	if(CGRectEqualToRect(spriteRect, CGRectZero))
	{
		CGSize textureSize = [[[images textureAtlas] texture] contentSize];
		
		rect = CGRectMake(0, 0, textureSize.width, textureSize.height);
	}
	
	if(images.texture != nil)
	{
		if(images.texture.hasPremultipliedAlpha)
		{
			[images setBlendFunc:(ccBlendFunc){GL_ONE, GL_ONE_MINUS_SRC_ALPHA}];
		}
		else
		{
			[images setBlendFunc:(ccBlendFunc){GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA}];
		}
	}

	
	for(int r = 0; r < spliceRows; r ++)
	{
		for(int c = 0; c < spliceCols; c ++)
		{
			CCSprite *splice = [[CCSprite alloc] initWithTexture:images.texture rect:rect rotated: spriteFrameRotated_];
			
			
//			if(spriteFrameRotated_)
//			{
//				splice.position = ccp(c * spliceHeight, r * spliceWidth);
//			}
//			else
			{
				splice.position = ccp(c * spliceWidth, r * spliceHeight);
			}
			
			splice.ignoreAnchorPointForPosition = NO;
			splice.anchorPoint = CGPointZero;
//			splice.parentPlugIn = self;

			[images addChild:splice];
		}
	}
	
//	if(spriteFrameRotated_)
//	{
//		_contentSize.height = spliceCols * spliceWidth;
//		_contentSize.width = spliceRows * spliceHeight;
//	}
//	else
	{
		_contentSize.width = spliceCols * spliceWidth;
		_contentSize.height = spliceRows * spliceHeight;
	}
	
	[self setOpacity:opacity_];
	[self setColor:color_];

}

- (void)updateDisplayedOpacity:(GLubyte)parentOpacity
{
    _displayedOpacity = opacity_ * parentOpacity/255.0;
    
    {
        for (CCNode<CCRGBAProtocol> *child in images.children)
        {
            [child setOpacity:_displayedOpacity];
        }
    }
}

- (void)updateDisplayedColor:(ccColor3B)parentColor
{
    _displayedColor.r = color_.r * parentColor.r/255.0;
    _displayedColor.g = color_.g * parentColor.g/255.0;
    _displayedColor.b = color_.b * parentColor.b/255.0;
    
    {
        for (CCNode<CCRGBAProtocol> *child in images.children)
        {
            [child setColor:_displayedColor];
        }
    }
}

@end
