//
//  CCStackPanel.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/1.
//
//

#import "CCStackPanel.h"
#import "LayoutUtils.h"

@implementation CCStackPanel

#pragma mark - Properties

@synthesize layoutDirection					= layoutDirection_;
@synthesize hAlignment						= hAlignment_;
@synthesize vAlignment						= vAlignment_;
@synthesize paddingLeft						= paddingLeft_;
@synthesize paddingTop						= paddingTop_;
@synthesize paddingRight					= paddingRight_;
@synthesize paddingBottom					= paddingBottom_;
@synthesize spacingH						= spacingH_;
@synthesize spacingV						= spacingV_;
@synthesize contractionSize					= contractionSize_;


- (void) setLayoutDirection:(LayoutDirection)newValue
{
	layoutDirection_ = newValue;
//	[self updateLayout];
}

- (void) setHAlignment:(LayoutHAlignment)newValue
{
	hAlignment_ = newValue;
//	[self updateLayout];
}

- (void) setVAlignment:(LayoutVAlignment)newValue
{
	vAlignment_ = newValue;
//	[self updateLayout];
}

- (void) setPaddingLeft:(int)newValue
{
	paddingLeft_ = newValue;
//	[self updateLayout];
}

- (void) setPaddingTop:(int)newValue
{
	paddingTop_ = newValue;
//	[self updateLayout];
}

- (void) setPaddingRight:(int)newValue
{
	paddingRight_ = newValue;
//	[self updateLayout];
}

- (void) setPaddingBottom:(int)newValue
{
	paddingBottom_ = newValue;
//	[self updateLayout];
}

- (void) setContractionSize:(BOOL)newValue
{
	contractionSize_ = newValue;
//	[self updateLayout];
}

#pragma mark - Initializers

- (id) init
{
	if(self = [super init])
	{
		layoutDirection_ = LayoutDirectionTopToBottom;
		hAlignment_ = LayoutHAlignmentLeft;
		vAlignment_ = LayoutVAlignmentTop;
		
		paddingLeft_ = 0;
		paddingTop_ = 0;
		paddingRight_ = 0;
		paddingBottom_ = 0;
		
		spacingH_ = 0;
		spacingV_ = 0;
		
		opacity_ = 0xFF;
		
		contractionSize_ = NO;
	}
	
	return self;
}

#pragma mark - Methods

- (CGSize) measureChildren
{
	CGSize ret = CGSizeMake(0, 0);
	BOOL isFirstChild = YES;
	
	for(CCNode *child in self.children)
	{
		CGSize childSize = [LayoutUtils getNodeSize:child];
		
		switch (layoutDirection_)
		{
				//纵向
			case LayoutDirectionTopToBottom:
			case LayoutDirectionBottomToTop:
				if(ret.width < childSize.width) ret.width = childSize.width;
				if(!isFirstChild) ret.height += spacingV_;
				ret.height += childSize.height;
				break;
				
				//横向
			case LayoutDirectionLeftToRight:
			case LayoutDirectionRightToLeft:
				if(ret.height < childSize.height) ret.height = childSize.height;
				if(!isFirstChild) ret.width += spacingH_;
				ret.width += childSize.width;
				
				break;
		}
		
		
		isFirstChild = NO;
	}
	
	return ret;
}


- (void) arrangeChild:(CCNode *)child rect:(CGRect)rect size:(CGSize)size
{
	if(child == nil) return;
	
	CGPoint pos = ccp(rect.origin.x, rect.origin.y);
	
	
	bool isHDirection = (layoutDirection_ == LayoutDirectionLeftToRight || layoutDirection_ == LayoutDirectionRightToLeft);
	bool isReverse = (layoutDirection_ == LayoutDirectionRightToLeft || layoutDirection_ == LayoutDirectionBottomToTop);
	
	//考虑横向对齐方式
	if(hAlignment_ == LayoutHAlignmentLeft)
	{
		if(isHDirection)
		{
			if(isReverse)
			{
				pos.x -= _contentSize.width - paddingLeft_ - paddingRight_ - size.width;
			}
			else
			{
				//default
			}
		}
		else
		{
			pos.x = paddingLeft_;
		}
	}
	else if(hAlignment_ == LayoutHAlignmentCenter)
	{
		if(isHDirection)
		{
			if(isReverse)
			{
				pos.x -= (_contentSize.width - paddingLeft_ - paddingRight_ - size.width)/2;
			}
			else
			{
				pos.x += (_contentSize.width - paddingLeft_ - paddingRight_ - size.width)/2;
			}
		}
		else
		{
			pos.x = (_contentSize.width - paddingLeft_ - paddingRight_ - rect.size.width) / 2 + paddingLeft_;
		}
	}
	else if(hAlignment_ == LayoutHAlignmentRight)
	{
		if(isHDirection)
		{
			if(isReverse)
			{
				//default
			}
			else
			{
				pos.x += (_contentSize.width - paddingLeft_ - paddingRight_ - size.width);
			}
		}
		else
		{
			pos.x = (_contentSize.width - paddingRight_ - rect.size.width);
		}
	}
	
	//考虑纵向对齐方式
	if(vAlignment_ == LayoutVAlignmentTop)
	{
		if(isHDirection)
		{
			pos.y = _contentSize.height - rect.size.height - paddingTop_;
		}
		else
		{
			if(isReverse)
			{
				pos.y += _contentSize.height - paddingTop_ - paddingBottom_ - size.height;
			}
			else
			{
				//default
			}
		}
	}
	else if(vAlignment_ == LayoutVAlignmentCenter)
	{
		if(isHDirection)
		{
			pos.y = (_contentSize.height - paddingTop_ - paddingBottom_ - rect.size.height)/ 2 + paddingTop_;
		}
		else
		{
			if(isReverse)
			{
				pos.y += (_contentSize.height - paddingTop_ - paddingBottom_ - size.height) / 2;
			}
			else
			{
				pos.y -= (_contentSize.height - paddingTop_ - paddingBottom_ - size.height) / 2;
			}
		}
	}
	else if(vAlignment_ == LayoutVAlignmentBottom)
	{
		if(isHDirection)
		{
			pos.y = paddingBottom_;
		}
		else
		{
			if(isReverse)
			{
				//default
			}
			else
			{
				pos.y -=(_contentSize.height - paddingTop_ - paddingBottom_ - size.height);
			}
		}
	}
	
	
	
	CGPoint a = child.anchorPoint;
	
	if(child.ignoreAnchorPointForPosition)
	{
		//ignoreAnchorPointForPosition机制有一个坐标BUG需要修正
		
		
		CGPoint aFixed = ccp(child.contentSize.width, child.contentSize.height);
		aFixed.x *= a.x;
		aFixed.y *= a.y;
		
		
		
		
		pos.x -= aFixed.x;
		pos.y -= aFixed.y;
		
		pos.x += rect.size.width * a.x;
		pos.y += rect.size.height * a.y;
	}
	else
	{
		pos.x += rect.size.width * a.x;
		pos.y += rect.size.height * a.y;
	}
	
	
	
	
	
	
	
	[child setPosition:pos];
}


- (void) updateLayout
{
	CGSize childrenSize = [self measureChildren];
	
	CGRect childrenRect = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
	CGRect childRect = CGRectZero;
	
	//起始位置
	switch (layoutDirection_)
	{
			//从上到下
		case LayoutDirectionTopToBottom:
		{
			childRect.origin.x = paddingLeft_;
			childRect.origin.y = childrenRect.size.height - paddingTop_;
			break;
		}
			
			//从下到上
		case LayoutDirectionBottomToTop:
		{
			childRect.origin.x = paddingLeft_;
			childRect.origin.y = paddingBottom_;
			break;
		}
			
			//从左到右
		case LayoutDirectionLeftToRight:
		{
			childRect.origin.x = paddingLeft_;
			childRect.origin.y = paddingBottom_;
			break;
		}
			
			//从右到左
		case LayoutDirectionRightToLeft:
		{
			childRect.origin.x = childrenRect.size.width - paddingRight_;
			childRect.origin.y = paddingBottom_;
			break;
		}
	}
	
	
	
	
	//----
	
	BOOL isLastChild = NO;
	
	//遍历子对象
	for(CCNode *child in self.children)
	{
		if(child == self.children.lastObject) isLastChild = YES;
		
		CGSize childSize = [LayoutUtils getNodeSize:child];
		
		childRect.size.width = childSize.width;
		childRect.size.height = childSize.height;
		
		switch (layoutDirection_)
		{
				//从上到下
			case LayoutDirectionTopToBottom:
				childRect.origin.y -= childSize.height;
				[self arrangeChild:child rect:childRect size:childrenSize];
				if(!isLastChild) childRect.origin.y -= spacingV_;
				break;
				
				//从下到上
			case LayoutDirectionBottomToTop:
				[self arrangeChild:child rect:childRect size:childrenSize];
				if(!isLastChild) childRect.origin.y += spacingV_;
				childRect.origin.y += childSize.height;
				break;
				
				//从左到右
			case LayoutDirectionLeftToRight:
				[self arrangeChild:child rect:childRect size:childrenSize];
				if(!isLastChild) childRect.origin.x += spacingH_;
				childRect.origin.x += childSize.width;
				break;
				
				//从右到左
			case LayoutDirectionRightToLeft:
				childRect.origin.x -= childSize.width;
				[self arrangeChild:child rect:childRect size:childrenSize];
				if(!isLastChild) childRect.origin.x -= spacingH_;
				break;
		}
		
	}
	
//	NSLog(@"updateLayout: %f, %f", childrenSize.width, childrenSize.height);
	
	
}

@end




