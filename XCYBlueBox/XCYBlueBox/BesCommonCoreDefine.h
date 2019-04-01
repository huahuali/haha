//
//  BesCommonCoreDefine.h
//  XCYBlueBox
//
//  Created by max on 2019/3/18.
//  Copyright © 2019年 XCY. All rights reserved.
//

#ifndef BesCommonCoreDefine_h
#define BesCommonCoreDefine_h


// 多语言
#define kAppLanguage     (@"AppLanguage")

#define kChineseLanguage (@"zh-Hans")

#define kEnglishLanguage (@"en")

#define kLanguageChanged (@"AppLanguageChanged")

#define kWeXLocalizedString(key, comment) \
([[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kAppLanguage]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:@"Localizable"])

#define kUserDefaults            ([NSUserDefaults standardUserDefaults])


#endif /* BesCommonCoreDefine_h */
