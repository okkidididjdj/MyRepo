#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UITextField *messageField;
@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) NSString *recipient;
@end
