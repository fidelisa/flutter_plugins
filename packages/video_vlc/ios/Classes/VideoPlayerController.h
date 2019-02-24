//
//  VideoPlayerController.h
//  Pods-Runner
//
//  Created by Yann-Cyril PELUD on 19/09/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerController : UIViewController<UIGestureRecognizerDelegate>
@property(strong, nonatomic) NSString *urlString;

@end

NS_ASSUME_NONNULL_END
