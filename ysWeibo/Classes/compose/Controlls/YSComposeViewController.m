//
//  YSComposeViewController.m
//  ysWeibo
//
//  Created by ys on 15/12/8.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSComposeViewController.h"
#import "YSComposeTextView.h"
#import "YSHttpTool.h"
#import "YSaccount.h"
#import "YSaccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "YSComposeToolBarView.h"
#import "YSComposePhotosView.h"

@interface YSComposeViewController()<UITextViewDelegate,YSComposeToolBarViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,weak)YSComposeTextView *composeTextView;
@property(nonatomic,weak)YSComposeToolBarView *toolBarView;
@property(nonatomic,weak)YSComposePhotosView *photosView;
@end
@implementation YSComposeViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationItem];
    [self setupComposeTextView];
    [self setupToolBarView];
    [self setupImageView];
    
}

-(void)setupImageView
{
    YSComposePhotosView *photosView = [[YSComposePhotosView alloc]init];
    [self.composeTextView addSubview:photosView];
    CGFloat photosViewX = 0;
    CGFloat photosViewY = 100;
    CGFloat photosViewW = self.view.frame.size.width;
    CGFloat photosViewH = self.view.frame.size.height;
    photosView.frame = CGRectMake(photosViewX, photosViewY, photosViewW, photosViewH);
    self.photosView = photosView;
}

-(void)setupToolBarView
{
    YSComposeToolBarView *toolBarView = [[YSComposeToolBarView alloc]init];
    toolBarView.delegate = self;
    CGFloat toolBarX = 0;
    CGFloat toolBarH = 44;
    CGFloat toolBarW = self.view.frame.size.width;
    CGFloat toolBarY = self.view.frame.size.height - toolBarH;
    toolBarView.frame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    self.toolBarView = toolBarView;
    [self.view addSubview:toolBarView];
}

-(void)setupComposeTextView
{
    YSComposeTextView *composeTextView = [[YSComposeTextView alloc]init];
    composeTextView.backgroundColor = [UIColor whiteColor];
    composeTextView.frame = self.view.bounds;
    composeTextView.alwaysBounceVertical = YES;
    composeTextView.delegate = self;
    composeTextView.placeholder = @"这里输入微博内容..这里输入微博内容这里输入微博内容这里输入微博内容这里输入微博内容.";
    [self.view addSubview:composeTextView];
    self.composeTextView = composeTextView;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(composeTextViewDidChange) name:UITextViewTextDidChangeNotification object:composeTextView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)composeToolBarView:(YSComposeToolBarView *)toolBarView DidClickedWithType:(ComposeToolBarButtonType)type
{
    switch (type) {
        case ComposeToolBarButtonTypeCamera:
            [self clickCamera];
            break;
        case ComposeToolBarButtonTypePicture:
            [self clickPhoto];
            break;
        case ComposeToolBarButtonTypeMention:
            
            break;
        case ComposeToolBarButtonTypeTrend:
            
            break;
        case ComposeToolBarButtonTypeEmotion:
            
            break;

        default:
            break;
    }
}


-(void)clickPhoto
{
    UIImagePickerController *pic = [[UIImagePickerController alloc]init];
    pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pic.delegate = self;
    [self presentViewController:pic animated:YES completion:nil];
}



-(void)clickCamera
{
    UIImagePickerController *pic = [[UIImagePickerController alloc]init];
    pic.sourceType = UIImagePickerControllerSourceTypeCamera;
    pic.delegate = self;
    [self presentViewController:pic animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
//    NSLog(@"%@",info);
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    [self.photosView addPhoto:image];
}


-(void)keyboardWillHidden:(NSNotification *)noti
{
    CGFloat time = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
     CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:time animations:^{
        self.toolBarView.transform = CGAffineTransformMakeTranslation(0, keyboardFrame.size.height);
    }];
}

-(void)keyboardWillShow:(NSNotification *)noti
{
    CGFloat time = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:time animations:^{
        self.toolBarView.transform = CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height);
    }];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
//    [self.composeTextView resignFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.composeTextView becomeFirstResponder];

}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)composeTextViewDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.composeTextView.text.length;
}
-(void)setupNavigationItem
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(clickCancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(clickSend)];
    [self.navigationItem setTitle:@"发微博"];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
-(void)clickCancel
{
//    self.composeTextView.placeholder = @"LLL";
//    self.composeTextView.font = [UIFont systemFontOfSize:20];
//    self.composeTextView.placeholderColor = [UIColor redColor];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickSend
{
    if (self.photosView.subviews.count) {
        [self sendTextWithImage];
        
    }else{
        [self sendTextWithoutImage];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)sendTextWithoutImage
{
//    // 1.创建请求管理对象
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//    // 2.封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"status"] = self.composeTextView.text;
//    params[@"access_token"] = [YSaccountTool account].access_token;
//    
//    // 3.发送请求
//    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params
//      success:^(AFHTTPRequestOperation *operation, id responseObject) {
//          [MBProgressHUD showSuccess:@"发送成功"];
//      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//          [MBProgressHUD showError:@"发送失败"];
//      }];
        // 2.封装请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"status"] = self.composeTextView.text;
        params[@"access_token"] = [YSaccountTool account].access_token;
    [YSHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id json) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];


}

-(void)sendTextWithImage
{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    YSaccount *account = [YSaccountTool account];
//    parameters[@"access_token"] = account.access_token;
//    parameters[@"status"] = self.composeTextView.text;
// 
//    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        NSArray *photos = self.photosView.photos;
//        int i = 0;
//        for (UIImage *image in photos) {
//            i++;
//            NSData *imageData = UIImageJPEGRepresentation(image, 0.4);
//            NSString *imageName = [NSString stringWithFormat:@"image%d.jpg",i];
//            [formData appendPartWithFileData:imageData name:@"pic" fileName:imageName mimeType:@"image/jpeg"];
//        }
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD showSuccess:@"发送成功"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"发送失败"];
//    }];
//
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    YSaccount *account = [YSaccountTool account];
    parameters[@"access_token"] = account.access_token;
    parameters[@"status"] = self.composeTextView.text;
    
    
    NSArray *photos = self.photosView.photos;
    int i = 0;
    NSMutableArray *formDataArray = [NSMutableArray array];
    for (UIImage *image in photos) {
        i++;
        NSData *imageData = UIImageJPEGRepresentation(image, 0.4);
        NSString *imageName = [NSString stringWithFormat:@"image%d.jpg",i];
        YSFormData *formData = [[YSFormData alloc]init];
        formData.data = imageData;
        formData.name = @"pic";
        formData.fileName = imageName;
        formData.mimeType = @"image/jpeg";
        [formDataArray addObject:formData];
    }
    
    [YSHttpTool postWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" params:parameters formDataArray:formDataArray success:^(id json) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

@end
