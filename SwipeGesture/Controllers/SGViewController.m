//
//  ViewController.m
//  SwipeGesture
//
//  Created by Rafael Ferreira on 1/19/16.
//  Copyright © 2016 Data Empire. All rights reserved.
//

#import "SGViewController.h"

@interface SGViewController ()

@end

@implementation SGViewController

- (void)createSquareView {
    CGSize size = self.view.frame.size;
    
    CGFloat frameSize = size.width / 4;
    CGFloat x = (size.width - frameSize) / 2;
    CGFloat y = (size.height - frameSize) / 2;
    
    CGRect frame = CGRectMake(x, y, frameSize, frameSize);
    
    squareView = [[UIView alloc] initWithFrame:frame];
    
    squareView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:squareView];
}

- (void)registerGestures {
    [self addSwipeGesture:UISwipeGestureRecognizerDirectionLeft];
    [self addSwipeGesture:UISwipeGestureRecognizerDirectionRight];
    [self addSwipeGesture:UISwipeGestureRecognizerDirectionUp];
    [self addSwipeGesture:UISwipeGestureRecognizerDirectionDown];
}

- (void)swipeSquareView:(UISwipeGestureRecognizer *)swipeGesture {
    CGPoint squarePoint = [swipeGesture locationInView:squareView];
    
    if ([squareView pointInside:squarePoint withEvent:nil]) {
        CGSize size = self.view.frame.size;
        CGSize squareSize = squareView.frame.size;
        
        CGRect frame = squareView.frame;
        
        switch (swipeGesture.direction) {
            case UISwipeGestureRecognizerDirectionLeft:
            case UISwipeGestureRecognizerDirectionRight:
                frame.origin.x = (swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft) ? 0 : (size.width - squareSize.width);
                break;
                
            case UISwipeGestureRecognizerDirectionUp:
            case UISwipeGestureRecognizerDirectionDown:
                frame.origin.y = (swipeGesture.direction == UISwipeGestureRecognizerDirectionUp) ? 0 : (size.height - squareSize.height);
        }
        
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            squareView.frame = frame;
        } completion:nil];
    }
}

- (void)addSwipeGesture:(UISwipeGestureRecognizerDirection)direction {
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeSquareView:)];
    swipeGesture.direction = direction;
    
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSquareView];
    
    [self registerGestures];
}

@end
