//
//  CCImage.h
//  CocosBuilder
//
//  Created by liuqiang on 16/2/1.
//
//

#import <Foundation/Foundation.h>
#import "CCImage.h"
#import "CCFileUtils.h"
#import <math.h>
#import "cocos2d.h"

typedef struct
{
	unsigned int	height;
	unsigned int	width;
	int				bitsPerComponent;
	BOOL			hasAlpha;
	BOOL			isPremultipliedAlpha;
	
	BOOL			hasShadow;
	CGSize			shadowOffset;
	float			shadowBlur;
	float			shadowOpacity;
	float			shadowColorR;
	float			shadowColorG;
	float			shadowColorB;
	
	BOOL			hasStroke;
	float			strokeColorR;
	float			strokeColorG;
	float			strokeColorB;
	float			strokeSize;
	float			tintColorR;
	float			tintColorG;
	float			tintColorB;
	
	unsigned char*  data;
	
} tImageInfo;

typedef enum
{
	eFmtJpg = 0,
	eFmtPng,
	eFmtTiff,
	eFmtWebp,
	eFmtRawData,
	eFmtPvr,
	eFmtEtc,
	eFmtUnKnown
} EImageFormat;

typedef enum
{
	eAlignCenter			= 0x33,
	eAlignTop				= 0x13,
	eAlignTopRight			= 0x12,
	eAlignRight				= 0x32,
	eAlignBottomRight		= 0x22,
	eAlignBottom			= 0x23,
	eAlignBottomLeft		= 0x21,
	eAlignLeft				= 0x31,
	eAlignTopLeft			= 0x11
} ETextAlign;

@interface CCImage : NSObject
{
	unsigned char* m_pData;
	BOOL m_bHasAlpha;
	BOOL m_bPreMulti;
	unsigned int m_Width;
	unsigned int m_Height;
	int m_nBisPerComponent;
	void* m_textureObject;
	
}

@property(nonatomic, readonly) unsigned int Width;
@property(nonatomic, readonly) unsigned int Height;
@property(nonatomic, readonly) int BitsPercomponent;
@property(nonatomic, assign) void* TextureObject;

- (BOOL) initWithImageFile:(NSString*)strPath imageType:(EImageFormat)imageType;
- (BOOL) initWithImageFileThreadSafe:(NSString*)fullPath imageType:(EImageFormat)imageType;
- (BOOL) initWithImageData:(void*)pData nDataLen:(int)nDataLen eFmt:(EImageFormat)eFmt nWidth:(int)nWidth nHeight:(int)nHeight nBitsPerComponent:(int)nBitsPerComponent;

- (BOOL) initWithString:(NSString*)pText
				 nWidth:(int)nWidth
				nHeight:(int)nHeight
			 eAlignMask:(ETextAlign)eAlignMask
			  pFontName:(NSString*)pFontName
				  nSize:(int)nSize;

- (BOOL) initWithStringShadowStroke:
									(NSString*)pText
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
					   shadowColorB:(float)shadowColorB;

- (unsigned char*)getData;
- (BOOL)isPremultipliedAlpha;

- (BOOL) saveToFile:(NSString*)pszFilePath bIsToRGB:(BOOL)bIsToRGB saveToFormat:(int)saveToFormat;

//----

+ (BOOL) _initWithImage:(CGImageRef)cgImage pImageInfo:(tImageInfo)pImageInfo;
+ (BOOL) _initWithFile:(NSString*)path pImageInfo:(tImageInfo)pImageInfo;
+ (BOOL) _initWithData:(void*)pBuffer length:(int)length pImageInfo:(tImageInfo)pImageInfo;
+ (CGSize) _calculateStringSize:(NSString*)str font:(id)font constrainSize:(CGSize)constrainSize;
+ (BOOL) _initWithString:(NSString*)pText eAlign:(ETextAlign)eAlign pFontName:(NSString*)pFontName nSize:(int)nSize pInfo:(tImageInfo)pInfo;

- (BOOL) _initWithJpgData:(void*) pData nDataLen:(int)nDataLen;
- (BOOL) _initWithPngData:(void*) pData nDataLen:(int)nDataLen;
- (BOOL) _initWithTiffData:(void*) pData nDataLen:(int)nDataLen;
- (BOOL) _initWithWebData:(void*) pData nDataLen:(int)nDataLen;
- (BOOL) _initWithRawData:(void*) pData nDataLen:(int)nDataLen nWidth:(int)nWidth nHeight:(int)nHeight nBitsPerComponent:(int)nBitsPerComponent bPreMulti:(BOOL)bPreMulti;

- (BOOL) _saveImageToPNG:(NSString*)pszFilePath bIsToRGB:(BOOL)bIsToRGB;
- (BOOL) _saveImageToJPG:(NSString*)pszFilePath;



@end
