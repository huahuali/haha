//
//  XCYBlueToothTableViewCell.m
//  XCYBlueBox
//
//  Created by XCY on 2017/4/7.
//  Copyright © 2017年 XCY. All rights reserved.
//

#import "XCYBlueToothTableViewCell.h"

static NSInteger maxWifiStrength = 100;

@interface XCYBlueToothTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *wifiStrengthImageView;
@property (strong, nonatomic) IBOutlet UILabel *bleNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *seviceNumberLabel;

@property (strong, nonatomic) IBOutlet UIImageView *jiantouImageView;



@end

@implementation XCYBlueToothTableViewCell


- (void)setBLEName:(NSString *)name
{
    if ([NSString strNilOrEmpty_xcy:name]) {
        
        name = @"Unnamed";
    }
    
    _bleNameLabel.text = name;
}


- (void)setBLEServiceNumber:(NSInteger )serviceNum
{
    
    NSString *serviceStr = @"No Services";
    if (serviceNum > 0) {
        
        serviceStr = [NSString stringWithFormat:@"%ld Services", (long)serviceNum];
    }
    
    _seviceNumberLabel.text = serviceStr;
}

- (void)setWifiStrength:(NSInteger)strength
{
    //The maximum number of images is 5
    NSInteger num = strength/(maxWifiStrength/5);
    if (num > 5) {
        num = 5;
    }

    NSString *imagName = [NSString stringWithFormat:@"xcyBlueTooth_wifi_%ld.png",(long)num];
    
    UIImage *wifiImage = [UIImage imageNamed:imagName];
    
    if (!wifiImage) {
        
        wifiImage = [self p_defaultWifiImage];
    }
    _wifiStrengthImageView.image = wifiImage;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setAutoresizesSubviews:NO];
    [self setAutoresizingMask:UIViewAutoresizingNone];
    
    [self.contentView setAutoresizesSubviews:NO];
    [self.contentView setAutoresizingMask:UIViewAutoresizingNone];
    
    CGSize mainSize = [UIDevice getScreenSize_xcy];
    [self setWidth_xcy:mainSize.width];
    [self.contentView setWidth_xcy:mainSize.width];
    
    CGFloat jianTouOriginX = mainSize.width - _jiantouImageView.width_xcy - 10;
    [_jiantouImageView setX_xcy:jianTouOriginX];
    
}

- (UIImage *)p_defaultWifiImage
{
    UIImage *image = [UIImage imageNamed:@"xcyBlueTooth_wifi_0.png"];
    return image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}

@end
