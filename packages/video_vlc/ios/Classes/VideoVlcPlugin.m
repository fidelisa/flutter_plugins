#import "VideoVlcPlugin.h"
#import "VideoPlayerController.h"

static NSString *const CHANNEL_NAME = @"video_vlc";

// UIWebViewDelegate
@interface VideoVlcPlugin ()<UIScrollViewDelegate> {
  UIView *_movieView;
}
@end

@implementation VideoVlcPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:CHANNEL_NAME
                                  binaryMessenger:[registrar messenger]];

  UIViewController *viewController = (UIViewController *)registrar.messenger;
  VideoVlcPlugin *instance = [[VideoVlcPlugin alloc] initWithViewController:viewController];

  [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithViewController:(UIViewController *)viewController {
  self = [super init];
  if (self) {
    self.viewController = viewController;
  }
  return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  if ([@"play" isEqualToString:call.method]) {
    [self initWebview:call];
    result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)initWebview:(FlutterMethodCall *)call {
  NSString *url = call.arguments[@"url"];

  VideoPlayerController *viewController = [[VideoPlayerController alloc] init];
  viewController.urlString = url;

  UINavigationController *navCon =
      [[UINavigationController alloc] initWithRootViewController:viewController];

  UIWindow *window = [[UIApplication sharedApplication] keyWindow];
  [window.rootViewController presentViewController:navCon animated:YES completion:nil];
}

@end
