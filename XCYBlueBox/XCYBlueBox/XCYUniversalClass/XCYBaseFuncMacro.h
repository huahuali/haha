//
//  XCYBaseFuncMacro.h
//  XCYBusinessCard
//
//  Created by XCY on 15-2-9.
//  Copyright (c) 2015年 XCY. All rights reserved.
//

#ifndef XCYBusinessCard_XCYBaseFuncMacro_h
#define XCYBusinessCard_XCYBaseFuncMacro_h

//单例
#undef XCYSINGLETONDECLEAR
#define XCYSINGLETONDECLEAR( ... ) \
- (instancetype)sharedInstance; \
+ (instancetype)sharedInstance;


#undef XCYSINGLETONIMPLEMENT
#define XCYSINGLETONIMPLEMENT( ... ) \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}


//静态NSInteger声明
#undef XCY_DECLARE_STATIC_PROPERTY_INT
#define XCY_DECLARE_STATIC_PROPERTY_INT(__name)\
- (NSInteger)__name; \
+ (NSInteger)__name;
#undef XCY_DEFINE_STATIC_PROPERTY_INT
#define XCY_DEFINE_STATIC_PROPERTY_INT(__name, __value )\
- (NSInteger)__name \
{ \
return (NSInteger)[[self class] __name]; \
} \
+ (NSInteger)__name \
{ \
return __value; \
}
//Release函数
#undef XCYRelease
#define XCYRelease(__name)\
[__name release],__name = nil;



#endif
