//
//  ViewController.m
//  VSKZoomView
//
//  Created by Vladimir Kravchenko on 11/17/15.
//  Copyright © 2015 Vladimir Kravchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 6.0;
    self.scrollView.contentSize = self.view.frame.size;
    self.scrollView.delegate = self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    [self adjustScrollViewInsets];
}

- (void)adjustScrollViewInsets {
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    CGFloat aspect = imageWidth / imageHeight;
    CGSize imageViewSize = self.imageView.frame.size;
    if (imageViewSize.width / aspect <= imageViewSize.height) {
        [self adjustVerticalInsetsWithImageHeight:(imageViewSize.width / aspect)];
    } else {
        [self adjustHorizontalInsetsWithImageWidth:(imageViewSize.height * aspect)];
    }
}

- (void)adjustHorizontalInsetsWithImageWidth:(CGFloat)width {
    CGFloat horizontalInset = (self.scrollView.contentSize.width - width) / 2;
    if (width < self.scrollView.frame.size.width) {
        horizontalInset = horizontalInset - (self.scrollView.frame.size.width - width) / 2;
    }
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, -horizontalInset, 0, -horizontalInset)];
}

- (void)adjustVerticalInsetsWithImageHeight:(CGFloat)height {
    CGFloat verticalInset = (self.scrollView.contentSize.height - height) / 2;
    if (height < self.scrollView.frame.size.height) {
        verticalInset = verticalInset - (self.scrollView.frame.size.height - height) / 2;
    }
    [self.scrollView setContentInset:UIEdgeInsetsMake(-verticalInset, 0, -verticalInset, 0)];
}

@end
