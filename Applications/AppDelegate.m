#import "AppDelegate.h"
#import "AuthViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Создаем твой экран авторизации
    AuthViewController *authVC = [[AuthViewController alloc] init];
    
    // Оборачиваем его в Navigation Controller, чтобы были красивые переходы
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:authVC];
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
