//
//  XCYOTASettingView.m
//  XCYBlueBox
//
//  Created by zhouaitao on 2017/8/19.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYOTASettingMainView.h"

static NSString *xcyUnSelectImageName = @"login_bujizhushoujihaoIcon.png";
static NSString *xcySelecteImageName = @"login_jizhushoujihaoIcon.png";

@interface XCYOTASettingMainView ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIControl *positionView;

@property (strong, nonatomic) IBOutlet UITextField *offsetTxtfield;

@property (strong, nonatomic) IBOutlet UIButton *clearYsBtn;
@property (strong, nonatomic) IBOutlet UIButton *clearNoBtn;
- (IBAction)clearYesButtonPressed:(id)sender;
- (IBAction)clearNoButtonPressed:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *btAddrYesBtn;
@property (strong, nonatomic) IBOutlet UIButton *btAddrNoBtn;
- (IBAction)updateBTAddressYESBtnPressed:(id)sender;
- (IBAction)updateBTAddressNoBtnPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *btAddrTxtfield;


@property (strong, nonatomic) IBOutlet UIButton *btNameYesBtn;
@property (strong, nonatomic) IBOutlet UIButton *btNameNoBtn;
- (IBAction)updateBTNameYesBtnPressed:(id)sender;
- (IBAction)updateBTNameNoBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *btNameTxtfield;


@property (strong, nonatomic) IBOutlet UIButton *bleAddrYesBtn;
@property (strong, nonatomic) IBOutlet UIButton *bleAddrNoBtn;
- (IBAction)updateBLEAddrYesBtnPressed:(id)sender;
- (IBAction)updateBLEAddrNoBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *bleAddrTxtfield;

@property (strong, nonatomic) IBOutlet UIButton *bleNameYesBtn;
@property (strong, nonatomic) IBOutlet UIButton *bleNameNoBtn;

- (IBAction)updateBLENameYesBtnPressed:(id)sender;
- (IBAction)updateBLENameNoBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *bleNameTxtfield;

- (IBAction)okButtonPressed:(id)sender;
- (IBAction)cancelBtnPressed:(id)sender;

@property (assign, nonatomic) BOOL isClear;
@property (assign, nonatomic) BOOL isBTAddr;
@property (assign, nonatomic) BOOL isBTName;
@property (assign, nonatomic) BOOL isBLEAddr;
@property (assign, nonatomic) BOOL isBLEName;

@property (weak, nonatomic) id<XCYOTASettingMainViewEventDelegate> curDelegate;
@end

@implementation XCYOTASettingMainView

+ (XCYOTASettingMainView *)getOTASettingView
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"XCYOTASettingMainView" owner:self options:nil];
    
    for (id itemView in array)
    {
        if ([itemView isKindOfClass:[XCYOTASettingMainView class]])
        {
            XCYOTASettingMainView *view = (XCYOTASettingMainView*)itemView;
            
            return view;
        }
    }
    
    return nil;
}


- (void)setEventDelegate:(id<XCYOTASettingMainViewEventDelegate>)aDelegate
{
    _curDelegate = aDelegate;
}






- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    self.autoresizesSubviews = NO;
    
    [_positionView addTarget:self action:@selector(p_closeKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    
    _offsetTxtfield.text = @"18000";
    
    _isClear = YES;
    _isBTAddr = NO;
    _isBTName = NO;
    _isBLEAddr=NO;
    _isBLEName = NO;
    
    [_clearYsBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    [_btAddrNoBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    [_btNameNoBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    [_bleAddrNoBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    [_bleNameNoBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    
    _btAddrTxtfield.backgroundColor = [UIColor grayColor];
    _btNameTxtfield.backgroundColor = [UIColor grayColor];
    _bleAddrTxtfield.backgroundColor = [UIColor grayColor];
    _bleNameTxtfield.backgroundColor = [UIColor grayColor];
    
    _offsetTxtfield.delegate = self;
    _btAddrTxtfield.delegate = self;
    _btNameTxtfield.delegate = self;
    _bleAddrTxtfield.delegate = self;
    _bleNameTxtfield.delegate = self;
    
    CGFloat mainWidth = [UIDevice getScreenSize_xcy].width;
    _offsetTxtfield.width_xcy = mainWidth - _offsetTxtfield.x_xcy*2;
    _btAddrTxtfield.width_xcy = mainWidth - _btAddrTxtfield.x_xcy*2;
    _btNameTxtfield.width_xcy = mainWidth - _btNameTxtfield.x_xcy*2;
    _bleAddrTxtfield.width_xcy = mainWidth - _bleAddrTxtfield.x_xcy*2;
    _bleNameTxtfield.width_xcy = mainWidth - _bleNameTxtfield.x_xcy*2;
    
    _offsetTxtfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _btAddrTxtfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _btNameTxtfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _bleAddrTxtfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _bleNameTxtfield.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)p_closeKeyBoard{
    
    [_offsetTxtfield resignFirstResponder];
    [_btAddrTxtfield resignFirstResponder];
    [_btNameTxtfield resignFirstResponder];
    [_bleAddrTxtfield resignFirstResponder];
    [_bleNameTxtfield resignFirstResponder];
}


- (IBAction)clearYesButtonPressed:(id)sender {
    
    [_clearYsBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    [_clearNoBtn setBackgroundImage:[UIImage imageNamed:xcyUnSelectImageName] forState:UIControlStateNormal];
    _isClear = YES;
    [self p_closeKeyBoard];
}

- (IBAction)clearNoButtonPressed:(id)sender {
    
    [_clearYsBtn setBackgroundImage:[UIImage imageNamed:xcyUnSelectImageName] forState:UIControlStateNormal];
    [_clearNoBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    _isClear = NO;
    [self p_closeKeyBoard];
}

- (IBAction)updateBTAddressYESBtnPressed:(id)sender {
    
    [_btAddrYesBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    [_btAddrNoBtn setBackgroundImage:[UIImage imageNamed:xcyUnSelectImageName] forState:UIControlStateNormal];
    _isBTAddr = YES;
    _btAddrTxtfield.backgroundColor = [UIColor whiteColor];
    [self p_closeKeyBoard];
}

- (IBAction)updateBTAddressNoBtnPressed:(id)sender {
    
    [_btAddrYesBtn setBackgroundImage:[UIImage imageNamed:xcyUnSelectImageName] forState:UIControlStateNormal];
    [_btAddrNoBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    _isBTAddr = NO;
    _btAddrTxtfield.backgroundColor = [UIColor grayColor];
    _btAddrTxtfield.text = @"";
    [self p_closeKeyBoard];
}

- (IBAction)updateBTNameYesBtnPressed:(id)sender {
    
    [_btNameYesBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    [_btNameNoBtn setBackgroundImage:[UIImage imageNamed:xcyUnSelectImageName] forState:UIControlStateNormal];
    _isBTName = YES;
    
    _btNameTxtfield.backgroundColor = [UIColor whiteColor];
    [self p_closeKeyBoard];
}

- (IBAction)updateBTNameNoBtnPressed:(id)sender {
    [_btNameYesBtn setBackgroundImage:[UIImage imageNamed:xcyUnSelectImageName] forState:UIControlStateNormal];
    [_btNameNoBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    _isBTName = NO;
    _btNameTxtfield.backgroundColor = [UIColor grayColor];
    _btNameTxtfield.text = @"";
    [self p_closeKeyBoard];
}
- (IBAction)updateBLEAddrYesBtnPressed:(id)sender {
    
    [_bleAddrYesBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    [_bleAddrNoBtn setBackgroundImage:[UIImage imageNamed:xcyUnSelectImageName] forState:UIControlStateNormal];
    _isBLEAddr = YES;
    
    _bleAddrTxtfield.backgroundColor = [UIColor whiteColor];
    [self p_closeKeyBoard];
}

- (IBAction)updateBLEAddrNoBtnPressed:(id)sender {
    [_bleAddrYesBtn setBackgroundImage:[UIImage imageNamed:xcyUnSelectImageName] forState:UIControlStateNormal];
    [_bleAddrNoBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    _isBLEAddr = NO;
    _bleAddrTxtfield.backgroundColor = [UIColor grayColor];
    _bleAddrTxtfield.text = @"";
    [self p_closeKeyBoard];
}
- (IBAction)updateBLENameYesBtnPressed:(id)sender {
    
    [_bleNameYesBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    [_bleNameNoBtn setBackgroundImage:[UIImage imageNamed:xcyUnSelectImageName] forState:UIControlStateNormal];
    _isBLEName = YES;
    
    _bleNameTxtfield.backgroundColor = [UIColor whiteColor];
    [self p_closeKeyBoard];
}

- (IBAction)updateBLENameNoBtnPressed:(id)sender {
    
    [_bleNameYesBtn setBackgroundImage:[UIImage imageNamed:xcyUnSelectImageName] forState:UIControlStateNormal];
    [_bleNameNoBtn setBackgroundImage:[UIImage imageNamed:xcySelecteImageName] forState:UIControlStateNormal];
    _isBLEName = NO;
    
    _bleNameTxtfield.backgroundColor = [UIColor grayColor];
    _bleNameTxtfield.text = @"";
    [self p_closeKeyBoard];
}
- (IBAction)okButtonPressed:(id)sender {
    [self p_closeKeyBoard];
    if (![_curDelegate respondsToSelector:@selector(okBtnPressedWithData:)]) {
        return;
    }
    
    XCYOTASettingDataDo *dataDo = [[XCYOTASettingDataDo alloc] init];
   // dataDo.flashOffset = [NSString safeGet_xcy:_offsetTxtfield.text];
    dataDo.btAddr = [NSString safeGet_xcy:_btAddrTxtfield.text];
    dataDo.btName = [NSString safeGet_xcy:_btNameTxtfield.text];
    dataDo.bleAddr = [NSString safeGet_xcy:_bleAddrTxtfield.text];
    dataDo.bleName = [NSString safeGet_xcy:_bleNameTxtfield.text];
    dataDo.isClearData = _isClear;
    dataDo.isBTAddrOpen = _isBTAddr;
    dataDo.isBTNameOpen = _isBTName;
    dataDo.isBLEAddrOpen = _isBLEAddr;
    dataDo.isBLENameOpen = _isBLEName;
    
    [_curDelegate okBtnPressedWithData:dataDo];
}

- (IBAction)cancelBtnPressed:(id)sender {
    [self p_closeKeyBoard];
    
    if ([_curDelegate respondsToSelector:@selector(cancelButtonPressed)]) {
        
        [_curDelegate cancelButtonPressed];
    }
}


//Returns YES when the character entered is a number or character
- (BOOL)p_isNumberOrCharacter:(NSString *)string
{
    string = [string lowercaseString];
    NSString *allowCharacters = @"0123456789abcdef";
    NSCharacterSet *setOfnonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:allowCharacters] invertedSet];
    if ([string stringByTrimmingCharactersInSet:setOfnonNumberSet].length > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == _btAddrTxtfield) {
        if (_isBTAddr) {
            return YES;
        }
        return NO;
    }
    
    if (textField == _btNameTxtfield) {
        if (_isBTName) {
            return YES;
        }
        return NO;
    }
    
    if (textField == _bleAddrTxtfield) {
        if (_isBLEAddr) {
            return YES;
        }
        return NO;
    }
    
    if (textField == _bleNameTxtfield) {
        if (_isBLEName) {
            return YES;
        }
        return NO;
    }
    
    return YES;

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(range.length == 1 && [NSString strNilOrEmpty_xcy:string])
    {  //YES DELETE
        return YES;
    }
    
    if (textField == _offsetTxtfield) {
        
        if (textField.text.length == 8) {
            return NO;
        }
        
        BOOL isVilad = [self p_isNumberOrCharacter:string];
        return isVilad;
    }
    
    if (textField == _btAddrTxtfield || textField == _bleAddrTxtfield) {
        
        if (textField.text.length == 12) {
            return NO;
        }
        
        BOOL isVilad = [self p_isNumberOrCharacter:string];
        return isVilad;
    }
    
    NSData *inputData = [string dataUsingEncoding:NSASCIIStringEncoding];
    if (!inputData) {
        return NO;
    }
    
    NSData *data = [textField.text dataUsingEncoding:NSASCIIStringEncoding];
    if (data.length >= 32) {
        return NO;
    }

    return YES;
}
@end
