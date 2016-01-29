//
//  ViewController.m
//  CCHeadImagePicker
//
//  Created by admin on 16/1/29.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import "ViewController.h"
#import "CCHeadImagePicker.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *headImageButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headImageButton.layer.masksToBounds = YES;
    self.headImageButton.layer.cornerRadius = self.headImageButton.frame.size.width / 2;
    
}

// 修改头像
- (IBAction)resiveHeadimageButtonClick:(id)sender {
    [CCHeadImagePicker showHeadImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            [sender setBackgroundImage:image forState:UIControlStateNormal];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
