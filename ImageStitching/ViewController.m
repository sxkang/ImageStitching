//
//  ViewController.m
//  ImageStitching
//
//  Created by 孙晓康 on 2017/8/19.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ViewController.h"

#import "BLUIBaseImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    BLUIBaseImage *baseImage = [[BLUIBaseImage alloc] init];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[baseImage createBaseImageWithImageArr:@[[UIImage imageNamed:@"smallteam_delete_member"],[UIImage imageNamed:@"smallteam_delete_member"],[UIImage imageNamed:@"smallteam_delete_member"],[UIImage imageNamed:@"smallteam_delete_member"],[UIImage imageNamed:@"smallteam_delete_member"]]]];
    
    [baseImage BuildWithImages:@[[UIImage imageNamed:@"smallteam_delete_member"],[UIImage imageNamed:@"smallteam_delete_member"],[UIImage imageNamed:@"smallteam_delete_member"],[UIImage imageNamed:@"smallteam_delete_member"],[UIImage imageNamed:@"smallteam_delete_member"],[UIImage imageNamed:@"smallteam_delete_member"]]];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSString *error;
    [baseImage SaveIntoPath:[NSString stringWithFormat:@"%@/image.png",docDir] OutError:&error];
    
    
    imageV.backgroundColor = [UIColor orangeColor];
    
    imageV.frame = CGRectMake(100, 100, 100, 100);
    
    [self.view addSubview:imageV];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
