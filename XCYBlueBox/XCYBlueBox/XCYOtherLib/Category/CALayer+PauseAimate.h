//
//  CALayer+PauseAimate.h
//  MusicPlayer
//
//  Created by Y Liu on 15/12/26.
//  Copyright © 2015年 CoderYLiu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (PauseAimate)

// start animate
- (void)pauseAnimate;

// resume animate
- (void)resumeAnimate;

@end
