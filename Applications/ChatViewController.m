#import "ChatViewController.h"

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"@%@", self.recipient];
    self.messages = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    // Панель ввода
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50)];
    inputView.backgroundColor = [UIColor lightGrayColor];
    
    self.messageField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width - 90, 30)];
    self.messageField.borderStyle = UITextBorderStyleRoundedRect;
    [inputView addSubview:self.messageField];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendBtn.frame = CGRectMake(self.view.bounds.size.width - 75, 10, 65, 30);
    [sendBtn setTitle:@"Отпр." forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:sendBtn];
    
    [self.view addSubview:inputView];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(loadMessages) userInfo:nil repeats:YES];
    [self loadMessages];
}

- (void)sendMessage {
    if (self.messageField.text.length == 0) return;
    
    NSString *sender = [[NSUserDefaults standardUserDefaults] stringForKey:@"current_user"];
    NSString *urlStr = @"http://YOUR-SERVER-IP.com/send_message";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"POST"];
    
    NSDictionary *bodyDict = @{@"sender": sender, @"recipient": self.recipient, @"text": self.messageField.text};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyDict options:0 error:nil];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            self.messageField.text = @"";
            [self loadMessages];
        }
    }];
}

- (void)loadMessages {
    NSString *sender = [[NSUserDefaults standardUserDefaults] stringForKey:@"current_user"];
    NSString *urlStr = [NSString stringWithFormat:@"http://YOUR-SERVER-IP.com/get_messages?user1=%@&user2=%@", sender, self.recipient];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSArray *loaded = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [self.messages removeAllObjects];
            for (NSDictionary *msg in loaded) {
                [self.messages addObject:[NSString stringWithFormat:@"%@: %@", msg[@"sender"], msg[@"text"]]];
            }
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return self.messages.count; }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"MsgCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.messages[indexPath.row];
    return cell;
}
@end
