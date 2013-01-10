//
//  ViewController.m
//  Draging
//
//  Created by makai on 13-1-8.
//  Copyright (c) 2013年 makai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc
{
    [upButtons release], upButtons = nil;
    [downButtons release], downButtons = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addItems];
}

- (void)addItems
{
    upButtons = [[NSMutableArray alloc] init];
    
    UIDragButton *button1 = [[UIDragButton alloc] initWithFrame:CGRectMake(142, 100, 100, 100) andImage:[UIImage imageNamed:@"1.png"] inView:self.view];
    UIDragButton *button2 = [[UIDragButton alloc] initWithFrame:CGRectMake(334, 100, 100, 100) andImage:[UIImage imageNamed:@"2.png"] inView:self.view];
    UIDragButton *button3 = [[UIDragButton alloc] initWithFrame:CGRectMake(526, 100, 100, 100) andImage:[UIImage imageNamed:@"3.png"] inView:self.view];
    UIDragButton *button4 = [[UIDragButton alloc] initWithFrame:CGRectMake(142, 300, 100, 100) andImage:[UIImage imageNamed:@"4.png"] inView:self.view];
    UIDragButton *button5 = [[UIDragButton alloc] initWithFrame:CGRectMake(334, 300, 100, 100) andImage:[UIImage imageNamed:@"5.png"] inView:self.view];
    UIDragButton *button6 = [[UIDragButton alloc] initWithFrame:CGRectMake(526, 300, 100, 100) andImage:[UIImage imageNamed:@"6.png"] inView:self.view];
    UIDragButton *button7 = [[UIDragButton alloc] initWithFrame:CGRectMake(142, 500, 100, 100) andImage:[UIImage imageNamed:@"7.png"] inView:self.view];
    
    [upButtons addObject:button1];
    [upButtons addObject:button2];
    [upButtons addObject:button3];
    [upButtons addObject:button4];
    [upButtons addObject:button5];
    [upButtons addObject:button6];
    [upButtons addObject:button7];

    for ( int i = 0; i < [upButtons count]; i++) {
        UIDragButton *button = [upButtons objectAtIndex:i];
        [button setLocation:up];
        [button setDelegate:self];
        [button setTag:i];
        [self.view addSubview:button];
    }
    
    [button1 release], button1 = nil;
    [button2 release], button2 = nil;
    [button3 release], button3 = nil;
    [button4 release], button4 = nil;
    [button5 release], button5 = nil;
    [button6 release], button6 = nil;
    [button7 release], button7 = nil;
    [self setUpButtonsFrameWithAnimate:NO withoutShakingButton:nil];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 850, 768, 2)];
    [label setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:label];
    
    
    downButtons = [[NSMutableArray alloc] init];
    
    UIDragButton *button8 = [[UIDragButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andImage:[UIImage imageNamed:@"8.png"] inView:self.view];
    UIDragButton *button9 = [[UIDragButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andImage:[UIImage imageNamed:@"9.png"] inView:self.view];
    UIDragButton *button10 = [[UIDragButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andImage:[UIImage imageNamed:@"10.png"] inView:self.view];

    [downButtons addObject:button8];
    [downButtons addObject:button9];
    [downButtons addObject:button10];

    for (int i = 0; i < [downButtons count]; i++) {
        UIDragButton *button = [downButtons objectAtIndex:i];
        [button setLocation:down];
        [button setDelegate:self];
        [button setTag:([upButtons count] + i)];
        [self.view addSubview:button];
    }
        
    [button8 release], button8 = nil;
    [button9 release], button9 = nil;
    [button10 release], button10 = nil;
    
    if ([downButtons count] <= 0) return;
    
    [self setDownButtonsFrameWithAnimate:NO withoutShakingButton:nil];
}

#pragma mark - 设置按钮的frame

- (void)checkLocationOfOthersWithButton:(UIDragButton *)shakingButton
{
    switch (shakingButton.location) {
        case up:
        {
            int indexOfShakingButton = 0;
            for ( int i = 0; i < [upButtons count]; i++) {
                if (((UIDragButton *)[upButtons objectAtIndex:i]).tag == shakingButton.tag) {
                    indexOfShakingButton = i;
                    break;
                }
            }
            for (int i = 0; i < [upButtons count]; i++) {
                UIDragButton *button = (UIDragButton *)[upButtons objectAtIndex:i];
                if (button.tag != shakingButton.tag){
                    if (CGRectIntersectsRect(shakingButton.frame, button.frame)) {
                        [upButtons exchangeObjectAtIndex:i withObjectAtIndex:indexOfShakingButton];
                        [self setUpButtonsFrameWithAnimate:YES withoutShakingButton:shakingButton];
                        break;
                    }
                }
            }
            
            break;
        }
        case down:
        {
            int indexOfShakingButton = 0;
            for ( int i = 0; i < [downButtons count]; i++) {
                if (((UIDragButton *)[downButtons objectAtIndex:i]).tag == shakingButton.tag) {
                    indexOfShakingButton = i;
                    break;
                }
            }
            for (int i = 0; i < [downButtons count]; i++) {
                UIDragButton *button = (UIDragButton *)[downButtons objectAtIndex:i];
                if (button.tag != shakingButton.tag){
                    if (CGRectIntersectsRect(shakingButton.frame, button.frame)) {
                        [downButtons exchangeObjectAtIndex:i withObjectAtIndex:indexOfShakingButton];
                        [self setDownButtonsFrameWithAnimate:YES withoutShakingButton:shakingButton];
                        break;
                    }
                }
            }
            
            break;
        }
        default:
            break;
    }
}

- (void)setUpButtonsFrameWithAnimate:(BOOL)_bool withoutShakingButton:(UIDragButton *)shakingButton
{
    int count = [upButtons count];
    if (shakingButton != nil) {
        if (_bool) {
            [UIView animateWithDuration:0.4 animations:^{
                for (int y = 0; y <= count / 3; y++) {
                    for (int x = 0; x < 3; x++) {
                        int i = 3 * y + x;
                        if (i < count) {
                            UIDragButton *button = (UIDragButton *)[upButtons objectAtIndex:i];
                            if (button.tag != shakingButton.tag) {
                                [button setFrame:CGRectMake(100 + x * 220, 48 + y * 256, 100, 100)];
                            }
                            [button setLastCenter:CGPointMake(100 + x * 220 + 50, 48 + y * 256 + 50)];
                        }
                    }
                }
            }];
        }else{
            for (int y = 0; y <= count / 3; y++) {
                for (int x = 0; x < 3; x++) {
                    int i = 3 * y + x;
                    if (i < count) {
                        UIDragButton *button = (UIDragButton *)[upButtons objectAtIndex:i];
                        if (button.tag != shakingButton.tag) {
                            [button setFrame:CGRectMake(100 + x * 220, 48 + y * 256, 100, 100)];
                        }
                        [button setLastCenter:CGPointMake(100 + x * 220 + 50, 48 + y * 256 + 50)];
                    }
                }
            }
        }

    }else{
        if (_bool) {
            [UIView animateWithDuration:0.4 animations:^{
                for (int y = 0; y <= count / 3; y++) {
                    for (int x = 0; x < 3; x++) {
                        int i = 3 * y + x;
                        if (i < count) {
                            UIDragButton *button = (UIDragButton *)[upButtons objectAtIndex:i];
                            [button setFrame:CGRectMake(100 + x * 220, 48 + y * 256, 100, 100)];
                            [button setLastCenter:CGPointMake(100 + x * 220 + 50, 48 + y * 256 + 50)];
                        }
                    }
                }
            }];
        }else{
            for (int y = 0; y <= count / 3; y++) {
                for (int x = 0; x < 3; x++) {
                    int i = 3 * y + x;
                    if (i < count) {
                        UIDragButton *button = (UIDragButton *)[upButtons objectAtIndex:i];
                        [button setFrame:CGRectMake(100 + x * 220, 48 + y * 256, 100, 100)];
                        [button setLastCenter:CGPointMake(100 + x * 220 + 50, 48 + y * 256 + 50)];
                    }
                }
            }
        }
    }
}

- (void)setDownButtonsFrameWithAnimate:(BOOL)_bool withoutShakingButton:(UIDragButton *)shakingButton
{
    float interval = 768 / (downButtons.count + 1);
    if (shakingButton != nil) {
        if (_bool) {
            
            [UIView animateWithDuration:0.4 animations:^{
                for (int i = 0; i < [downButtons count]; i++) {
                    UIDragButton *button = (UIDragButton *)[downButtons objectAtIndex:i];
                    if (shakingButton.tag != button.tag) {
                        [button setFrame:CGRectMake((i + 1) * interval - 40, 880, 80, 80)];
                    }
                    [button setLastCenter:CGPointMake((i + 1) * interval, 880 + 40)];
                }
            }];
            
        }else{
            for (int i = 0; i < [downButtons count]; i++) {
                UIDragButton *button = (UIDragButton *)[downButtons objectAtIndex:i];
                if (shakingButton.tag != button.tag) {
                    [button setFrame:CGRectMake((i + 1) * interval - 40, 880, 80, 80)];
                }
                [button setLastCenter:CGPointMake((i + 1) * interval, 880 + 40)];
            }
        }
    }else{
        if (_bool) {
            
            [UIView animateWithDuration:0.4 animations:^{
                for (int i = 0; i < [downButtons count]; i++) {
                    UIDragButton *button = (UIDragButton *)[downButtons objectAtIndex:i];
                    [button setFrame:CGRectMake((i + 1) * interval - 40, 880, 80, 80)];
                    [button setLastCenter:CGPointMake((i + 1) * interval, 880 + 40)];
                }
            }];
            
        }else{
            for (int i = 0; i < [downButtons count]; i++) {
                UIDragButton *button = (UIDragButton *)[downButtons objectAtIndex:i];
                [button setFrame:CGRectMake((i + 1) * interval - 40, 880, 80, 80)];
                [button setLastCenter:CGPointMake((i + 1) * interval, 880 + 40)];
            }
        }

    }
}


#pragma mark - UIDragButton Delegate

- (void)removeShakingButton:(UIDragButton *)button fromUpButtons:(BOOL)_bool
{
    if (_bool) {
        if ([upButtons containsObject:button]) {
            [upButtons removeObject:button];
        }
    }else{
        if ([downButtons containsObject:button]) {
            [downButtons removeObject:button];
        }
    }
}

- (void)arrangeUpButtonsWithButton:(UIDragButton *)button andAdd:(BOOL)_bool
{
    if (_bool) {
        if (![upButtons containsObject:button]) {
            [upButtons addObject:button];
        }
    }else{
        [upButtons removeObject:button];
        int insertIndex = [downButtons count];
        for (int i = 0; i <= [downButtons count]; i++) {
            if (i == 0) {
                if (button.center.x <= ((UIDragButton *)[downButtons objectAtIndex:i]).center.x) {
                    insertIndex = i;
                    break;
                }
            }else if (i == downButtons.count){
                break;
            }else if (0 < i && i < downButtons.count){
                UIDragButton *button1 = (UIDragButton *)[downButtons objectAtIndex:i - 1];
                UIDragButton *button2 = (UIDragButton *)[downButtons objectAtIndex:i];
                if ((button.center.x > button1.center.x) && (button.center.x <= button2.center.x)) {
                    insertIndex = i;
                    break;
                }
            }
        }
        NSLog(@"insertIndex = %d", insertIndex);
        [downButtons insertObject:button atIndex:insertIndex];
    }
    
    if (upButtons.count <= 0) return;
    [self setUpButtonsFrameWithAnimate:YES withoutShakingButton:nil];
}

- (void)arrangeDownButtonsWithButton:(UIDragButton *)button andAdd:(BOOL)_bool
{
    if (_bool) {
        if (![downButtons containsObject:button]) {
            [downButtons addObject:button];
        }
    }else{
        [downButtons removeObject:button];
        [upButtons addObject:button];
    }
    if (downButtons.count <= 0) return;
    [self setDownButtonsFrameWithAnimate:YES withoutShakingButton:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
