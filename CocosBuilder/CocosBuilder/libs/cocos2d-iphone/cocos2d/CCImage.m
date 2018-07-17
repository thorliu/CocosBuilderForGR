//
//  CCImage.m
//  CocosBuilder
//
//  Created by liuqiang on 16/2/1.
//
//

#import "CCImage.h"


@implementation CCImage

@synthesize Width					= m_Width;
@synthesize Height					= m_Height;
@synthesize BitsPercomponent		= m_nBisPerComponent;
@synthesize TextureObject			= m_textureObject;

+(BOOL)_initWithImage:(CGImageRef)cgImage pImageInfo:(tImageInfo)pImageInfo
{
	//TODO: _initWithImage
	return NO;
}

+(BOOL)_initWithFile:(NSString *)path pImageInfo:(tImageInfo)pImageInfo
{
	//TODO: _initWithFile
	return NO;
}

+(BOOL)_initWithData:(void *)pBuffer length:(int)length pImageInfo:(tImageInfo)pImageInfo
{
	//TODO: _initWithData
	return NO;
}

+(CGSize)_calculateStringSize:(NSString *)str font:(id)font constrainSize:(CGSize)constrainSize
{
//	
//	NSArray* listItems = [str componentsSeparatedByString:@"\n"];
//	CGSize dim = CGSizeZero;
//	CGSize textRect = CGSizeZero;
//	
//	textRect.width = constrainSize.width > 0 ? constrainSize.width : 0x7fffffff;
//	textRect.height = constrainSize.height > 0 ? constrainSize.height : 0x7fffffff;
//	
//	/*
//	 
//	 CGSize size = [string sizeWithAttributes:
//	 @{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]}];
//	 
//	 // Values are fractional -- you should take the ceilf to get equivalent values
//	 CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
//	 
//	 */
//	NSFont* f = font;
//	for (NSString* s in listItems)
//	{
//		CGSize tmp = [s sizeWithAttributes:@{NSFontAttributeName: [NSFont systemFontSize: 17]]
//	}
	
	return CGSizeZero;
}



#pragma mark -

-(unsigned char*)getData
{
	return NULL;
}

-(BOOL)initWithImageFile:(NSString *)strPath imageType:(EImageFormat)imageType
{
	//TODO: initWithImageFile
	return NO;
};

-(BOOL)initWithImageFileThreadSafe:(NSString *)fullPath imageType:(EImageFormat)imageType
{
	//TODO: initWithImageFileThreadSafe
	return NO;
}

-(BOOL)initWithImageData:(void *)pData nDataLen:(int)nDataLen eFmt:(EImageFormat)eFmt nWidth:(int)nWidth nHeight:(int)nHeight nBitsPerComponent:(int)nBitsPerComponent
{
	//TODO: initWithImageData
	return NO;
}

-(BOOL)_initWithRawData:(void *)pData nDataLen:(int)nDataLen nWidth:(int)nWidth nHeight:(int)nHeight nBitsPerComponent:(int)nBitsPerComponent bPreMulti:(BOOL)bPreMulti
{
	//TODO: _initWithRawData
	return NO;
}

-(BOOL)_initWithJpgData:(void *)pData nDataLen:(int)nDataLen
{
	//TODO: _initWithJpgData
	return NO;
}

-(BOOL)_initWithPngData:(void *)pData nDataLen:(int)nDataLen
{
	//TODO: _initWithPngData
	return NO;
}

-(BOOL)_saveImageToPNG:(NSString *)pszFilePath bIsToRGB:(BOOL)bIsToRGB
{
	//TODO: _saveImageToPNG
	return NO;
}

-(BOOL)_saveImageToJPG:(NSString *)pszFilePath
{
	//TODO: _saveImageToJPG
	return NO;
}

#pragma mark -

-(BOOL)saveToFile:(NSString *)pszFilePath bIsToRGB:(BOOL)bIsToRGB saveToFormat:(int)saveToFormat
{
	//saveToFile
	return NO;
}

#pragma mark -

+(BOOL)_initWithString:(NSString*)pText eAlign:(ETextAlign)eAlign pFontName:(NSString*)pFontName nSize:(int)nSize pInfo:(tImageInfo)pInfo
{
	BOOL bRet = NO;
	
	do
	{
		NSString* str = [pText copy];
		NSString* fntName = [pFontName copy];
		
		CGSize dim, constrainSize;
		constrainSize.width = pInfo.width;
		constrainSize.height = pInfo.height;
		fntName = [[fntName lastPathComponent] stringByDeletingPathExtension];
		id font = [NSFont fontWithName:fntName size:nSize];	//FIXME: UIFont
		if(font)
		{
			dim = [CCImage _calculateStringSize:str font:font constrainSize:constrainSize];
		}
		
	} while (NO);
	
	
	return NO;
}

-(BOOL)initWithString:(NSString*)pText
			   nWidth:(int)nWidth
			  nHeight:(int)nHeight eAlignMask:(ETextAlign)eAlignMask
			pFontName:(NSString*)pFontName
				nSize:(int)nSize
{
	return [self initWithStringShadowStroke:pText
									  Width:nWidth
									nHeight:nHeight
								 eAlignMask:eAlignMask
								  pFontName:pFontName
									  nSize:nSize
								  textTintR:1
								  textTintG:1
								  textTintB:1
									 shadow:NO
							  shadowOffsetX:0
							  shadowOffsetY:0
							  shadowOpacity:0
								 shadowBlur:0
									 stroke:NO
									strokeR:0
									strokeG:0
									strokeB:0
								 strokeSize:1
							   shadowColorR:0
							   shadowColorG:0
							   shadowColorB:0
			];
	
}

-(BOOL)initWithStringShadowStroke:(NSString*)pText
						   nWidth:(int)nWidth
						  nHeight:(int)nHeight
					   eAlignMask:(ETextAlign)eAlignMask
						pFontName:(NSString*)pFontName
							nSize:(int)nSize
						textTintR:(float)textTintR
						textTintG:(float)textTintG
						textTintB:(float)textTintB
						   shadow:(BOOL)shadow
					shadowOffsetX:(float)shadowOffsetX
					shadowOffsetY:(float)shadowOffsetY
					shadowOpacity:(float)shadowOpacity
					   shadowBlur:(float)shadowBlur
						   stroke:(BOOL)stroke
						  strokeR:(float)strokeR
						  strokeG:(float)strokeG
						  strokeB:(float)strokeB
					   strokeSize:(float)strokeSize
					 shadowColorR:(float)shadowColorR
					 shadowColorG:(float)shadowColorG
					 shadowColorB:(float)shadowColorB
{
	tImageInfo info;
	
	info.width = nWidth;
	info.height = nHeight;
	
	
	info.hasShadow = shadow;
	info.shadowOffset.width = shadowOffsetX;
	info.shadowOffset.height = shadowOffsetY;
	info.shadowBlur = shadowBlur;
	info.shadowOpacity = shadowOpacity;
	info.shadowColorR = shadowColorR;
	info.shadowColorG = shadowColorG;
	info.shadowColorB = shadowColorB;
	
	
	info.hasStroke = stroke;
	info.strokeColorR = strokeR;
	info.strokeColorG = strokeG;
	info.strokeColorB = strokeB;
	info.strokeSize = strokeSize;
	info.tintColorR = textTintR;
	info.tintColorG = textTintR;
	info.tintColorB = textTintB;
	
	if(![CCImage _initWithString:pText eAlign:eAlignMask pFontName:pFontName nSize:nSize pInfo:info])
	{
		return NO;
	}
	
	m_Width = info.width;
	m_Height = info.height;
	m_nBisPerComponent = info.bitsPerComponent;
	m_bHasAlpha = info.hasAlpha;
	m_bPreMulti = info.isPremultipliedAlpha;
	m_pData = info.data;
	
	
	return YES;
}

@end
