#import <UIKit/UIKit.h>
#import "AuthViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    AuthViewController *authVC = [[AuthViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:authVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

@end

