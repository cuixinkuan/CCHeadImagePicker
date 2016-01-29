//
//  CCHeadImagePicker.m
//  CCHeadImagePicker
//
//  Created by admin on 16/1/29.
//  Copyright © 2016年 CXK. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CCHeadImagePicker.h"
static CCHeadImagePicker * CCHeadImagePickerInstance = nil;

@interface CCHeadImagePicker ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString * _string1;
    NSString * _string2;
    
}
@property (nonatomic,weak)UIViewController * viewController;
@property (nonatomic,copy)CCHeadImagePickerFinishAction finishAction;
@property (nonatomic,assign)BOOL allowsEditing;
@property (nonatomic,copy)NSString * string1;
@property (nonatomic,copy)NSString * string2;

@end

@implementation CCHeadImagePicker

+ (void)showHeadImagePickerFromViewController:(UIViewController *)viewController allowsEditing:(BOOL)allowsEditing finishAction:(CCHeadImagePickerFinishAction)finishAction {
    if (CCHeadImagePickerInstance == nil ) {
        CCHeadImagePickerInstance = [[CCHeadImagePicker alloc] init];
    }
    [CCHeadImagePickerInstance showImagePickerFromViewController:viewController allowsEditing:allowsEditing finishAction:finishAction];
}

#pragma mark - privote methods
- (void)showImagePickerFromViewController:(UIViewController *)viewController allowsEditing:(BOOL)allowsEditiong finishAction:(CCHeadImagePickerFinishAction)finishAction {
    _viewController = viewController;
    _finishAction = finishAction;
    _allowsEditing = allowsEditiong;
    
    self.string1 = @"拍照";
    self.string2 = @"从相册中选择";
    
    UIActionSheet * sheet = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.string1,self.string2, nil];
    }else {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.string2, nil];
    }
    UIView * window = [UIApplication sharedApplication].keyWindow;
    [sheet showInView:window];
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString * title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:self.string1]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = _allowsEditing;
        [_viewController presentViewController:picker animated:YES completion:nil];
    }else if ([title isEqualToString:self.string2]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        [_viewController presentViewController:picker animated:YES completion:nil];
    }else {
        CCHeadImagePickerInstance = nil;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage * image = info[UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    if (_finishAction) {
        _finishAction(image);
    }
    [picker dismissViewControllerAnimated:YES completion:^{
    //  还可以带上其他操作
    }];
    CCHeadImagePickerInstance = nil;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (_finishAction) {
        _finishAction(nil);
    }
    [picker dismissViewControllerAnimated:YES completion:^{
       //
    }];
    CCHeadImagePickerInstance = nil;
}

@end
