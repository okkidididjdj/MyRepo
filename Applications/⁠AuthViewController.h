#import <UIKit/UIKit.h>

@interface AuthViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) UITextField *usernameField;
@property (strong, nonatomic) UITextField *passwordField;
@end
