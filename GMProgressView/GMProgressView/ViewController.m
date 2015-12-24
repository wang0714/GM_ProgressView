//
//  ViewController.m
//  test2
//
//  Created by 汪高明 on 15/12/23.
//  Copyright © 2015年 汪高明. All rights reserved.
//

#import "ViewController.h"
#import "GMProgressView.h"

@interface ViewController ()

@property (nonatomic,strong) GMProgressView *progressV;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progressV = [[GMProgressView alloc] initWithFrame:CGRectMake(20, 20, 68, 68) lineW:6];
    
    _progressV.ratioNum = 100;
    _progressV.lineWidth = 10;
    [self.view addSubview:_progressV];
    
    [_progressV animationWithDurationTime:3 animation:YES];
    
}
- (IBAction)click:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    _progressV.ratioNum = arc4random()%100+1;
    [_progressV animationWithDurationTime:3 animation:YES];
    sender.userInteractionEnabled = YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
