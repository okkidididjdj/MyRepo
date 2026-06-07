#import "AuthViewController.h"
#import "ChatsListViewController.h"

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Авторизация";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor]; // Легендарный фон в полосочку
    
    // Поле ввода Юзернейма
    self.usernameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, self.view.bounds.size.width - 40, 40)];
    self.usernameField.borderStyle = UITextBorderStyleRoundedRect;
    self.usernameField.placeholder = @"Юзернейм (например, sophie)";
    self.usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.usernameField];
    
    // Поле ввода Пароля
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(20, 135, self.view.bounds.size.width - 40, 40)];
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.placeholder = @"Пароль";
    self.passwordField.secureTextEntry = YES;
    [self.view addSubview:self.passwordField];
    
    // Кнопка Войти / Зарегистрироваться
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake(20, 200, self.view.bounds.size.width - 40, 44);
    [loginBtn setTitle:@"Войти или Создать аккаунт" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(authPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

- (void)authPressed {
    if (self.usernameField.text.length == 0 || self.passwordField.text.length == 0) return;
    
    NSString *urlStr = [NSString stringWithFormat:@"http://YOUR-SERVER-IP.com/auth?user=%@&pass=%@", self.usernameField.text, self.passwordField.text];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError && data) {
            // Сохраняем имя пользователя на устройстве
            [[NSUserDefaults standardUserDefaults] setObject:self.usernameField.text forKey:@"current_user"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            // Переходим к списку чатов
            ChatsListViewController *chatsVC = [[ChatsListViewController alloc] init];
            [self.navigationController pushViewController:chatsVC animated:YES];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Не удалось подключиться" delegate:nil cancelButtonTitle:@"ОК" otherButtonTitles:nil];
            [alert show];
        }
    }];
}
@end
