//
//  CCIconLabel.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/7.
//
//

#import "CCIconLabel.h"
#import "StyleManager.h"


@implementation CCIconLabel

@synthesize iconDockStyle						= iconDockStyle_;
@synthesize spacing								= spacing_;
@synthesize paddingTop							= paddingTop_;
@synthesize paddingBottom						= paddingBottom_;
@synthesize paddingLeft							= paddingLeft_;
@synthesize paddingRight						= paddingRight_;
@synthesize isWarning							= isWarning_;
@synthesize style								= style_;
@synthesize text								= text_;
@synthesize textColorStyle						= colorStyle_;

- (id) init
{
	if(self = [super init])
	{
		icon_ = [[CCNodeRGBA alloc] init];
		icon_.ignoreAnchorPointForPosition = NO;
		icon_.anchorPoint = ccp(0.5f,0.5f);
		[self addChild:icon_];
		
		label_ = [[CCLabelTTF alloc] init];
		label_.ignoreAnchorPointForPosition = NO;
		label_.anchorPoint = ccp(0.5f,0.5f);
		[self addChild:label_];
	}
	
	return self;
}

- (void) updateLayout
{
	CGSize iSize = CGSizeZero;
	CGSize tSize = label_.boundingBox.size;	//文本尺寸
	CGSize cSize = CGSizeMake(tSize.width, tSize.height); //当前尺寸 (图标+间隔+文本)
	CGPoint iPos = CGPointZero;
	CGPoint tPos = CGPointZero;
	
	if(icon_.children.count > 0)
	{
		CCNode* firstChild = [icon_.children objectAtIndex:0];
		iSize = firstChild.boundingBox.size;
	}
	
//	CGPoint ap = ccp(self.anchorPoint.x, self.anchorPoint.y);
	
	switch (iconDockStyle_)
	{
			//全部在中间
		case ccDockStyleCenter:
		{
			if(cSize.width < iSize.width) cSize.width = iSize.width;
			if(cSize.height < iSize.height) cSize.height = iSize.height;
			iPos.x = tPos.x = cSize.width / 2 + paddingLeft_;
			iPos.y = tPos.y = cSize.height / 2 + paddingBottom_;
			icon_.anchorPoint = ccp(0.5f,0.5f);
			label_.anchorPoint = ccp(0.5f,0.5f);
			break;
		}
			//图标在上
		case ccDockStyleTop:
		{
			if(cSize.width < iSize.width) cSize.width = iSize.width;
			cSize.height = iSize.height  + spacing_ + tSize.height;
			iPos.x = cSize.width / 2 + paddingLeft_;
			iPos.y = tSize.height + spacing_ + iSize.height / 2 + paddingBottom_;
			tPos.x = cSize.width / 2 + paddingLeft_;
			tPos.y = tSize.height / 2 + paddingBottom_;
			icon_.anchorPoint = ccp(0.5f,0.5f);
			label_.anchorPoint = ccp(0.5f,0.5f);
			break;
		}
			//图标在下
		case ccDockStyleBottom:
		{
			if(cSize.width < iSize.width) cSize.width = iSize.width;
			cSize.height = iSize.height  + spacing_ + tSize.height;
			iPos.x = cSize.width / 2 + paddingLeft_;
			iPos.y = iSize.height / 2 + paddingBottom_;
			tPos.x = cSize.width / 2 + paddingLeft_;
			tPos.y = iSize.height + spacing_ + tSize.height / 2 + paddingBottom_;
			icon_.anchorPoint = ccp(0.5f,0.5f);
			label_.anchorPoint = ccp(0.5f,0.5f);
			break;
		}
			//图标在左
		case ccDockStyleLeft:
		{
			if(cSize.height < iSize.height) cSize.height= iSize.height;
			cSize.width = iSize.width + spacing_ + tSize.width;
			iPos.x = iSize.width / 2 + paddingLeft_;
			iPos.y = cSize.height / 2 + paddingBottom_;
			tPos.x = iSize.width + spacing_ + tSize.width / 2 + paddingLeft_;
			tPos.y = cSize.height / 2 + paddingBottom_;
			icon_.anchorPoint = ccp(0.5f,0.5f);
			label_.anchorPoint = ccp(0.5f,0.5f);
			break;
		}
			//图标在右
		case ccDockStyleRight:
		{
			if(cSize.height < iSize.height) cSize.height= iSize.height;
			cSize.width = iSize.width + spacing_ + tSize.width;
			tPos.x = tSize.width / 2 + paddingLeft_;
			tPos.y = cSize.height / 2 + paddingBottom_;
			iPos.x = tSize.width + spacing_ + iSize.width / 2 + paddingLeft_;
			iPos.y = cSize.height / 2 + paddingBottom_;
			icon_.anchorPoint = ccp(0.5f,0.5f);
			label_.anchorPoint = ccp(0.5f,0.5f);
			break;
		}
	}
	
	[icon_ setPosition:iPos];
	[label_ setPosition:tPos];
	
	cSize.width += paddingLeft_ + paddingRight_;
	cSize.height += paddingTop_ + paddingBottom_;
	
	[self setContentSize:cSize];
}

//- (void) setContentSize:(CGSize)v
//{
//	[super setContentSize:v];
//	[self updateLayout];
//}

- (void) setIconDockStyle:(ccDockStyle)v
{
	iconDockStyle_ = v;
	[self updateLayout];
}

- (void) setSpacing:(int)v
{
	spacing_ = v;
	[self updateLayout];
}

- (void) setPaddingLeft:(int)v
{
	paddingLeft_ = v;
	[self updateLayout];
}

- (void) setPaddingRight:(int)v
{
	paddingRight_ = v;
	[self updateLayout];
}

- (void) setPaddingTop:(int)v
{
	paddingTop_ = v;
	[self updateLayout];
}

- (void) setPaddingBottom:(int)v
{
	paddingBottom_ = v;
	[self updateLayout];
}

- (void) setIsWarning:(BOOL)v
{
	isWarning_ = v;
	
	[self updateStyle];
}

- (void) setStyle:(NSString *)v
{
	
	style_ = [v copy];
	
	[self updateStyle];
	
	
	
	[self updateLayout];
}

- (void) setText:(NSString *)v
{
	text_ = [v copy];
	
	[label_ setString:v];
	
	[self updateLayout];
}

- (TextColorStyle) getTextColorStyle
{
	return colorStyle_;
}

- (void) setTextColorStyle:(TextColorStyle)v
{
	colorStyle_ = v;
	[self updateStyle];
}

- (void)updateStyle
{
	[[StyleManager sharedManager] setTextStyle:label_ style:style_ textColorStyle:colorStyle_];
}

- (CCNode*) getChildrenPlugInContainer
{
	return icon_;
}

- (void) visit
{
	[self updateLayout];
	[super visit];
}

@end
