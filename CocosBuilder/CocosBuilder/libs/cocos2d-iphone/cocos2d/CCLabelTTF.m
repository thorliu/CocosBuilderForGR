/*
 * cocos2d for iPhone: http://www.cocos2d-iphone.org
 *
 * Copyright (c) 2008-2010 Ricardo Quesada
 * Copyright (c) 2011 Zynga Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */


#import "CCLabelTTF.h"
#import "Support/CGPointExtension.h"
#import "ccMacros.h"
#import "CCShaderCache.h"
#import "CCGLProgram.h"
#import "Support/CCFileUtils.h"
#import "ccDeprecated.h"

#ifdef __CC_PLATFORM_IOS
#import "Platforms/iOS/CCDirectorIOS.h"
#import <CoreText/CoreText.h>
#endif

#if CC_USE_LA88_LABELS
#define SHADER_PROGRAM kCCShader_PositionTextureColor
#else
#define SHADER_PROGRAM kCCShader_PositionTextureA8Color
#endif

@interface CCLabelTTF ()
- (BOOL) updateTexture;
- (NSString*) getFontName:(NSString*)fontName;
@end

@implementation CCLabelTTF

// -
+ (id) labelWithString:(NSString*)string fontName:(NSString*)name fontSize:(CGFloat)size
{
	return [[[self alloc] initWithString:string fontName:name fontSize:size]autorelease];
}

// hAlignment
+ (id) labelWithString:(NSString*)string fontName:(NSString*)name fontSize:(CGFloat)size dimensions:(CGSize)dimensions hAlignment:(CCTextAlignment)alignment
{
	return [[[self alloc] initWithString:string  fontName:name fontSize:size dimensions:dimensions hAlignment:alignment vAlignment:kCCVerticalTextAlignmentTop lineBreakMode:kCCLineBreakModeWordWrap]autorelease];
}

// hAlignment, vAlignment
+ (id) labelWithString:(NSString*)string fontName:(NSString*)name fontSize:(CGFloat)size dimensions:(CGSize)dimensions hAlignment:(CCTextAlignment)alignment vAlignment:(CCVerticalTextAlignment) vertAlignment
{
	return [[[self alloc] initWithString:string fontName:name fontSize:size dimensions:dimensions hAlignment:alignment vAlignment:vertAlignment]autorelease];
}

// hAlignment, lineBreakMode
+ (id) labelWithString:(NSString*)string fontName:(NSString*)name fontSize:(CGFloat)size dimensions:(CGSize)dimensions hAlignment:(CCTextAlignment)alignment lineBreakMode:(CCLineBreakMode)lineBreakMode
{
	return [[[self alloc] initWithString:string fontName:name fontSize:size dimensions:dimensions hAlignment:alignment vAlignment:kCCVerticalTextAlignmentTop lineBreakMode:lineBreakMode]autorelease];
}

// hAlignment, vAlignment, lineBreakMode
+ (id) labelWithString:(NSString*)string fontName:(NSString*)name fontSize:(CGFloat)size dimensions:(CGSize)dimensions hAlignment:(CCTextAlignment)alignment vAlignment:(CCVerticalTextAlignment) vertAlignment lineBreakMode:(CCLineBreakMode)lineBreakMode
{
	return [[[self alloc] initWithString:string fontName:name fontSize:size dimensions:dimensions hAlignment:alignment vAlignment:vertAlignment lineBreakMode:lineBreakMode]autorelease];
}

- (id) init
{
	m_shadowColor = ccc3(0, 0, 0);
    return [self initWithString:@"" fontName:@"Helvetica" fontSize:12];
}

- (id) initWithString:(NSString*)str fontName:(NSString*)name fontSize:(CGFloat)size
{
	m_shadowColor = ccc3(0, 0, 0);
	return [self initWithString:str fontName:name fontSize:size dimensions:CGSizeZero hAlignment:kCCTextAlignmentLeft vAlignment:kCCVerticalTextAlignmentTop lineBreakMode:kCCLineBreakModeWordWrap];
}

// hAlignment
- (id) initWithString:(NSString*)str fontName:(NSString*)name fontSize:(CGFloat)size dimensions:(CGSize)dimensions hAlignment:(CCTextAlignment)alignment
{
	m_shadowColor = ccc3(0, 0, 0);
	return [self initWithString:str fontName:name fontSize:size dimensions:dimensions hAlignment:alignment vAlignment:kCCVerticalTextAlignmentTop lineBreakMode:kCCLineBreakModeWordWrap];
}

// hAlignment, vAlignment
- (id) initWithString:(NSString*)str fontName:(NSString*)name fontSize:(CGFloat)size dimensions:(CGSize)dimensions hAlignment:(CCTextAlignment)alignment vAlignment:(CCVerticalTextAlignment) vertAlignment
{
	m_shadowColor = ccc3(0, 0, 0);
	return [self initWithString:str fontName:name fontSize:size dimensions:dimensions hAlignment:alignment vAlignment:vertAlignment lineBreakMode:kCCLineBreakModeWordWrap];
}

// hAlignment, lineBreakMode
- (id) initWithString:(NSString*)str fontName:(NSString*)name fontSize:(CGFloat)size dimensions:(CGSize)dimensions hAlignment:(CCTextAlignment)alignment lineBreakMode:(CCLineBreakMode)lineBreakMode
{
	m_shadowColor = ccc3(0, 0, 0);
	return [self initWithString:str fontName:name fontSize:size dimensions:dimensions hAlignment:alignment vAlignment:kCCVerticalTextAlignmentTop lineBreakMode:lineBreakMode];
}

// hAlignment, vAligment, lineBreakMode
- (id) initWithString:(NSString*)str  fontName:(NSString*)name fontSize:(CGFloat)size dimensions:(CGSize)dimensions hAlignment:(CCTextAlignment)alignment vAlignment:(CCVerticalTextAlignment) vertAlignment lineBreakMode:(CCLineBreakMode)lineBreakMode
{
	m_shadowColor = ccc3(0, 0, 0);
	if( (self=[super init]) )
	{

		// shader program
		self.shaderProgram = [[CCShaderCache sharedShaderCache] programForKey:SHADER_PROGRAM];

		_dimensions = dimensions;
		_hAlignment = alignment;
		_vAlignment = vertAlignment;
		_fontName = [[self getFontName: name] copy];
		_fontSize = size;
		_lineBreakMode = lineBreakMode;

		[self setString:str];
	}
	return self;
}

- (void) setString:(NSString*)str
{
	NSAssert( str, @"Invalid string" );

	if( _string.hash != str.hash ) {
		[_string release];
		_string = [str copy];
		
		
		//TODO: 阴影和边框的测试代码
//		[self enableShadow:CGSizeMake(1, -1) Opacity:1 Blur:1 UpdateTexture:YES shadowColor:ccc3(0x00, 0x00, 0xFF)];
//		[self enableStroke:ccc3(0x00, 0xFF, 0x00) Size:1 UpdateTexture:YES];
		
		[self updateTexture];
	}
}

-(NSString*) string
{
	return _string;
}

- (NSString*) getFontName:(NSString*)fontName
{
	// Custom .ttf file ?
    if ([[fontName lowercaseString] hasSuffix:@".ttf"])
    {
        // This is a file, register font with font manager
        NSString* fontFile = [[CCFileUtils sharedFileUtils] fullPathForFilename:fontName];
        NSURL* fontURL = [NSURL fileURLWithPath:fontFile];
        CTFontManagerRegisterFontsForURL((CFURLRef)fontURL, kCTFontManagerScopeProcess, NULL);

		return [[fontFile lastPathComponent] stringByDeletingPathExtension];
    }

    return fontName;
}

- (void)setFontName:(NSString*)fontName
{
    fontName = [self getFontName:fontName];
    
	if( fontName.hash != _fontName.hash ) {
		[_fontName release];
		_fontName = [fontName copy];
		
		// Force update
		if( _string )
			[self updateTexture];
	}
}

- (NSString*)fontName
{
    return _fontName;
}

- (void) setFontSize:(float)fontSize
{
	if( fontSize != _fontSize ) {
		_fontSize = fontSize;
		
		// Force update
		if( _string )
			[self updateTexture];
	}
}

- (float) fontSize
{
    return _fontSize;
}

-(void) setDimensions:(CGSize) dim
{
    if( dim.width != _dimensions.width || dim.height != _dimensions.height)
	{
        _dimensions = dim;
        
		// Force update
		if( _string )
			[self updateTexture];
    }
}

-(CGSize) dimensions
{
    return _dimensions;
}

-(void) setHorizontalAlignment:(CCTextAlignment)alignment
{
    if (alignment != _hAlignment)
    {
        _hAlignment = alignment;
        
        // Force update
		if( _string )
			[self updateTexture];

    }
}

- (CCTextAlignment) horizontalAlignment
{
    return _hAlignment;
}

-(void) setVerticalAlignment:(CCVerticalTextAlignment)verticalAlignment
{
    if (_vAlignment != verticalAlignment)
    {
        _vAlignment = verticalAlignment;
        
		// Force update
		if( _string )
			[self updateTexture];
    }
}

- (CCVerticalTextAlignment) verticalAlignment
{
    return _vAlignment;
}

- (void) dealloc
{
	[_string release];
	[_fontName release];

	[super dealloc];
}

- (NSString*) description
{
	// XXX: _string, _fontName can't be displayed here, since they might be already released

	return [NSString stringWithFormat:@"<%@ = %p | FontSize = %.1f>", [self class], self, _fontSize];
}

// Helper
- (BOOL) updateTexture
{				
	CCTexture2D *tex;
	if( _dimensions.width == 0 || _dimensions.height == 0 )
	{
		
		
		//TODO: 阴影和边框的测试代码
//		ccFontDefinition texDef = [self _prepareTextDefinition:YES];
//		tex = [[CCTexture2D alloc] initWithString:_string textDefinition:&texDef];
		
		
		tex = [[CCTexture2D alloc] initWithString:_string
										 fontName:_fontName
										 fontSize:_fontSize  * CC_CONTENT_SCALE_FACTOR()];
	}
	else
	{
		tex = [[CCTexture2D alloc] initWithString:_string
										 fontName:_fontName
										 fontSize:_fontSize  * CC_CONTENT_SCALE_FACTOR()
									   dimensions:CC_SIZE_POINTS_TO_PIXELS(_dimensions)
									   hAlignment:_hAlignment
									   vAlignment:_vAlignment
									lineBreakMode:_lineBreakMode
			   ];
	}

	if( !tex )
		return NO;
    

#ifdef __CC_PLATFORM_IOS
	// iPad ?
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
		if( CC_CONTENT_SCALE_FACTOR() == 2 )
			[tex setResolutionType:kCCResolutioniPadRetinaDisplay];
		else
			[tex setResolutionType:kCCResolutioniPad];
	}
	// iPhone ?
	else
	{
		if( CC_CONTENT_SCALE_FACTOR() == 2 )
			[tex setResolutionType:kCCResolutioniPhoneRetinaDisplay];
		else
			[tex setResolutionType:kCCResolutioniPhone];
	}
#endif
	
	[self setTexture:tex];
	[tex release];
	
	CGRect rect = CGRectZero;
	rect.size = [_texture contentSize];
	[self setTextureRect: rect];
	
	return YES;
}

- (void) enableShadow:(CGSize)shadowOffset Opacity:(float)shadowOpacity Blur:(float)shadowBlur UpdateTexture:(BOOL)updateTexture shadowColor:(ccColor3B)shadowColor
{
    
    bool valueChanged = false;
    
    if (false == m_shadowEnabled)
    {
        m_shadowEnabled = true;
        valueChanged    = true;
    }
    
    if ( (m_shadowOffset.width != shadowOffset.width) || (m_shadowOffset.height!=shadowOffset.height) )
    {
        m_shadowOffset.width  = shadowOffset.width;
        m_shadowOffset.height = shadowOffset.height;
        
        valueChanged = true;
    }
	
	if( (m_shadowColor.r != shadowColor.r || m_shadowColor.g != shadowColor.g || m_shadowColor.b != shadowColor.b))
	{
		m_shadowColor.r = shadowColor.r;
		m_shadowColor.g = shadowColor.g;
		m_shadowColor.b = shadowColor.b;
		
		valueChanged = true;
	}
		
    if (m_shadowOpacity != shadowOpacity )
    {
        m_shadowOpacity = shadowOpacity;
        valueChanged = true;
    }
    
    if (m_shadowBlur    != shadowBlur)
    {
        m_shadowBlur = shadowBlur;
        valueChanged = true;
    }
    
    
    if ( valueChanged && updateTexture )
    {
        [self updateTexture];
    }
    
}

- (void) disableShadow:(BOOL)updateTexture{
    
    if (m_shadowEnabled)
    {
        m_shadowEnabled = false;
        
        if (updateTexture)
            [self updateTexture];
        
    }
    
}

- (void) enableStroke:(ccColor3B)strokeColor Size:(float)strokeSize UpdateTexture:(BOOL)updateTexture{
    
    bool valueChanged = false;
    
    if(m_strokeEnabled == false)
    {
        m_strokeEnabled = true;
        valueChanged = true;
    }
    
    if ( (m_strokeColor.r != strokeColor.r) || (m_strokeColor.g != strokeColor.g) || (m_strokeColor.b != strokeColor.b) )
    {
        m_strokeColor = strokeColor;
        valueChanged = true;
    }
    
    if (m_strokeSize!=strokeSize)
    {
        m_strokeSize = strokeSize;
        valueChanged = true;
    }
    
    if ( valueChanged && updateTexture )
    {
        [self updateTexture];
    }
    
}

- (void) disableStroke:(BOOL)updateTexture{
    
    if (m_strokeEnabled)
    {
        m_strokeEnabled = false;
        
        if (updateTexture)
            [self updateTexture];
    }
}


- (ccFontDefinition)_prepareTextDefinition:(BOOL)adjustForResolution
{
	ccFontDefinition texDef;
	
	if(adjustForResolution)
	{
		texDef.m_fontSize = _fontSize * CC_CONTENT_SCALE_FACTOR();
	}
	else
	{
		texDef.m_fontSize = _fontSize;
	}
	
	texDef.m_fontName = [_fontName copy];
	texDef.m_alignment = _hAlignment;
	texDef.m_vertAlignment = _vAlignment;
	
	if(adjustForResolution)
	{
		texDef.m_dimensions = CC_SIZE_POINTS_TO_PIXELS(_dimensions);
	}
	else
	{
		texDef.m_dimensions = _dimensions;
	}
	
	//stroke
	if(m_strokeEnabled)
	{
		texDef.m_stroke.m_strokeEnabled = YES;
		texDef.m_stroke.m_strokeColor = m_strokeColor;
		if(adjustForResolution)
		{
			texDef.m_stroke.m_strokeSize = m_strokeSize * CC_CONTENT_SCALE_FACTOR();
		}
		else
		{
			texDef.m_stroke.m_strokeSize = m_strokeSize;
		}
	}
	else
	{
		texDef.m_stroke.m_strokeEnabled = NO;
	}
	
	//shadow
	if(m_shadowEnabled)
	{
		texDef.m_shadow.m_shadowEnabled = YES;
		texDef.m_shadow.m_shadowBlur = m_shadowBlur;
		texDef.m_shadow.m_shadowOpacity = m_shadowOpacity;
		texDef.m_shadow.m_shadowColor = m_shadowColor;
		
		if(adjustForResolution)
		{
			texDef.m_shadow.m_shadowOffset = CC_SIZE_POINTS_TO_PIXELS(m_shadowOffset);
		}
		else
		{
			texDef.m_shadow.m_shadowOffset = m_shadowOffset;
		}
	}
	else
	{
		texDef.m_shadow.m_shadowEnabled = NO;
	}
	
	texDef.m_fontFillColor = m_textFillColor;
	
	return texDef;
}

@end
