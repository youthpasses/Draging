//
//  ViewController.h
//  Draging
//
//  Created by makai on 13-1-8.
//  Copyright (c) 2013年 makai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDragButton.h"

@interface ViewController : UIViewController<UIDragButtonDelegate>
{
    NSMutableArray *upButtons;
    NSMutableArray *downButtons;
}

- (void)addItems;
- (void)setUpButtonsFrameWithAnimate:(BOOL)_bool withoutShakingButton:(UIDragButton *)shakingButton;
- (void)setDownButtonsFrameWithAnimate:(BOOL)_bool withoutShakingButton:(UIDragButton *)shakingButton;

@end
