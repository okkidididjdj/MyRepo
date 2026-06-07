#import "ChatsListViewController.h"
#import "ChatViewController.h"

@implementation ChatsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Чаты";
    self.chats = [[NSMutableArray alloc] init];
    
    // Кнопка выхода из аккаунта слева
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Выйти" style:UIBarButtonItemStyleBordered target:self action:@selector(logout)];
    
    // Поисковая строка в стиле Telegram для поиска по юзернейму
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Поиск по @username...";
    [self.view addSubview:self.searchBar];
    
    // Таблица чатов
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height - 44) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self loadChats];
}

- (void)logout {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"current_user"];
    [self.navigationController popViewController:animated:YES];
}

// Поиск человека по нажатию кнопки "Search" на клавиатуре
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSString *targetUser = [searchBar.text stringByReplacingOccurrencesOfString:@"@" withString:@""];
    
    if (targetUser.length > 0) {
        // Открываем чат с этим пользователем напрямую
        ChatViewController *chatVC = [[ChatViewController alloc] init];
        chatVC.recipient = targetUser;
        [self.navigationController pushViewController:chatVC animated:YES];
    }
}

- (void)loadChats {
    NSString *currentUser = [[NSUserDefaults standardUserDefaults] stringForKey:@"current_user"];
    NSString *urlStr = [NSString stringWithFormat:@"http://YOUR-SERVER-IP.com/get_chats?user=%@", currentUser];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSArray *loadedChats = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [self.chats removeAllObjects];
            [self.chats addObjectsFromArray:loadedChats];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chats.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"ChatCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"@%@", self.chats[indexPath.row]];
    cell.detailTextLabel.text = @"Нажмите, чтобы открыть переписку";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    chatVC.recipient = self.chats[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
}
@end
