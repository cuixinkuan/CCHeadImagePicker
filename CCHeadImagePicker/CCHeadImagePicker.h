//
//  CCHeadImagePicker.h
//  CCHeadImagePicker
//
//  Created by admin on 16/1/29.
//  Copyright © 2016年 CXK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CCHeadImagePickerFinishAction)(UIImage * image);

@interface CCHeadImagePicker : NSObject
/**
 *  修改头像的类方法
 *
 *  @param viewController for present UIImagePickerController 对象
 *  @param allowsEditing  是否允许编辑头像
 *  @param finishAction   结束回调
 */
+ (void)showHeadImagePickerFromViewController:(UIViewController * )viewController
                                allowsEditing:(BOOL)allowsEditing
                                 finishAction:(CCHeadImagePickerFinishAction)finishAction;

@end
