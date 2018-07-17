//
//  CCStackPanel.h
//  CocosBuilder
//
//  Created by liuqiang on 16/1/1.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LayoutPanel.h"

/** 横向对齐方式 */
typedef enum
{
	///无对齐方式
	LayoutHAlignmentNone,
	///左对齐方式
	LayoutHAlignmentLeft,
	///居中对齐方式
	LayoutHAlignmentCenter,
	///右对齐方式
	LayoutHAlignmentRight
	
} LayoutHAlignment;


/** 纵向对齐方式 */
typedef enum
{
	///无对齐方式
	LayoutVAlignmentNone,
	///上对齐方式
	LayoutVAlignmentTop,
	///居中对齐方式
	LayoutVAlignmentCenter,
	///下对齐方式
	LayoutVAlignmentBottom
} LayoutVAlignment;


/** 布局方向 */
typedef enum
{
	///从左到右
	LayoutDirectionLeftToRight,
	///从右到左
	LayoutDirectionRightToLeft,
	///从上到下
	LayoutDirectionTopToBottom,
	///从下到上
	LayoutDirectionBottomToTop
	
} LayoutDirection;


/**对子元素进行顺序排列的布局面板*/
@interface CCStackPanel : LayoutPanel
{
	
@protected
	
	LayoutDirection		layoutDirection_;
	
	LayoutHAlignment	hAlignment_;
	LayoutVAlignment	vAlignment_;
	
	int					paddingLeft_;
	int					paddingTop_;
	int					paddingRight_;
	int					paddingBottom_;
	
	int					spacingH_;
	int					spacingV_;
	
	BOOL				contractionSize_;
}

/**计算子元素需要的尺寸*/
- (CGSize) measureChildren;
/**布置子元素*/
- (void) arrangeChild:(CCNode*) child rect:(CGRect)rect size:(CGSize)size;

/**获取或设置布局方向*/
@property (nonatomic, readwrite) LayoutDirection layoutDirection;
/**获取或设置横向对齐方式*/
@property (nonatomic, readwrite) LayoutHAlignment hAlignment;
/**获取或设置纵向对齐方式*/
@property (nonatomic, readwrite) LayoutVAlignment vAlignment;
/**获取或设置左边距*/
@property (nonatomic, readwrite) int paddingLeft;
/**获取或设置上边距*/
@property (nonatomic, readwrite) int paddingTop;
/**获取或设置右边距*/
@property (nonatomic, readwrite) int paddingRight;
/**获取或设置下边距*/
@property (nonatomic, readwrite) int paddingBottom;
/**获取或设置横向间距*/
@property (nonatomic, readwrite) int spacingH;
/**获取或设置纵向间距*/
@property (nonatomic, readwrite) int spacingV;
/**获取或设置是否自动收缩尺寸*/
@property (nonatomic, readwrite) BOOL contractionSize;

@end








