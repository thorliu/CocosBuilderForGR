//
//  StyleValue.m
//  CocosBuilder
//
//  Created by liuqiang on 16/1/4.
//
//

#import "StyleValue.h"

@implementation StyleValue

+ (int) hex2dec:(NSString *)str
{
	unsigned int d = 0;
	
	NSString* strDec = nil;
	
	if([str hasPrefix:@"0x"])
	{
		strDec = [str substringFromIndex:2];
	}
	else if([str hasPrefix:@"#"])
	{
		strDec = [str substringFromIndex:1];
	}
	else
	{
		strDec = str;
	}
	
	[[NSScanner scannerWithString:strDec] scanHexInt:&d];
	
	return d;
}


+ (ccColor3B) toColor3B:(NSString *)str
{
	int dec = [StyleValue hex2dec:str];
	int nRed = (dec & 0xFF0000) >> 16;
	int nGreen = (dec & 0x00FF00) >> 8;
	int nBlue = (dec & 0x0000FF);
	
	return ccc3((GLubyte)nRed, (GLubyte)nGreen, (GLubyte)nBlue);
}


+ (GLubyte) toGLubyte:(NSString *)str
{
	int nOpacity = 0;
	double nAlpha = atof([str UTF8String]) / 100.0f;
	nAlpha *= 255;
	
	nOpacity = (int)nAlpha;
	
	
	if(nOpacity < 0) nOpacity = 0;
	if(nOpacity > 255) nOpacity = 255;
	
	return (GLubyte)nOpacity;
}

@end
