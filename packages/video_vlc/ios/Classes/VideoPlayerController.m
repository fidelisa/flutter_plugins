//
//  VideoPlayerController.m
//  Pods-Runner
//
//  Created by Yann-Cyril PELUD on 19/09/2018.
//

#import "VideoPlayerController.h"
#import <MobileVLCKit/VLCMediaPlayer.h>
#import <MobileVLCKit/MobileVLCKit.h>


@interface VideoPlayerController ()
{
    UIImageView *_imageView;
    UIActivityIndicatorView *_activityIndicatorView;
    VLCMediaPlayer *_player;
    
    UIButton *_doneButton;
    
    
    UIView *_navigationBarView;
}
@property (retain, nonatomic) UIView *movieView;
@end

@implementation VideoPlayerController


- (void)viewDidLoad {
    [super viewDidLoad];
    _player = [[VLCMediaPlayer alloc] init];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _movieView = [[UIView alloc] initWithFrame:self.view.bounds];
    _movieView.contentMode = UIViewContentModeScaleAspectFit;
    _movieView.clipsToBounds = YES;
    _movieView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UITapGestureRecognizer *gestureRecognizer0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureEmpty:)];
    [_movieView addGestureRecognizer:gestureRecognizer0];
    _movieView.userInteractionEnabled = YES;
    
    [self.view addSubview:_movieView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self setupNavigationbar];
}


- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_doneButton setAccessibilityIdentifier:@"Done"];
        [_doneButton addTarget:self action:@selector(closePlayback:) forControlEvents:UIControlEventTouchUpInside];
        [_doneButton setTitle:@"OK" forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _doneButton;
}

- (UIView *)navigationBarStackView
{
    if (!_navigationBarView) {
        _navigationBarView = [[UIView alloc] init];
        _navigationBarView.translatesAutoresizingMaskIntoConstraints = NO;
        [_navigationBarView addSubview:self.doneButton];
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [NSLayoutConstraint constraintWithItem:self.doneButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_navigationBarView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
                                                  ]];
    }
    return _navigationBarView;
}

- (void)setupNavigationbar
{
    
    if (self.navigationBarStackView.superview == nil) {
        [self.navigationController.navigationBar addSubview:self.navigationBarStackView];
        
        
        NSObject *guide = self.navigationController.navigationBar;
        if (@available(iOS 11.0, *)) {
            guide = self.navigationController.navigationBar.safeAreaLayoutGuide;
        }
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [NSLayoutConstraint constraintWithItem:self.navigationBarStackView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.navigationController.navigationBar attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
                                                  [NSLayoutConstraint constraintWithItem:self.navigationBarStackView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:guide attribute:NSLayoutAttributeLeft multiplier:1 constant:8],
                                                  [NSLayoutConstraint constraintWithItem:self.navigationBarStackView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:guide attribute:NSLayoutAttributeRight multiplier:1 constant:-8],
                                                  [NSLayoutConstraint constraintWithItem:self.navigationBarStackView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.navigationController.navigationBar attribute:NSLayoutAttributeTop multiplier:1 constant:0],
                                                  [NSLayoutConstraint constraintWithItem:self.navigationBarStackView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.navigationController.navigationBar attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
                                                  ]];
    }
}

- (IBAction)closePlayback:(id)sender
{
    if (_player.media) {
        [_player stop];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) tapGesture: (UITapGestureRecognizer *)recognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) tapGestureEmpty: (UITapGestureRecognizer *)recognizer
{
    if (_player.isPlaying) {
        [_player pause];
    } else {
        [_player play];
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return touch.view == gestureRecognizer.view;
}

- (void)viewDidAppear:(BOOL)animated
{
    _player.drawable = self.movieView;
    _player.media = [VLCMedia mediaWithURL:[NSURL URLWithString:self.urlString]];
    [_player play];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (_player.media) {
        [_player stop];
    }
}

@end
