//
//  Created by name on 12-3-6.
//
//


#import <Foundation/Foundation.h>
#import "User.h"

#define KEY_ACCOUNT                          @"kmx.account"

#define KEY_USER_NO                          @"kmx.account.no"
#define KEY_USER_ID                          @"userId"
#define KEY_USER_TOKEN                       @"token"
#define KEY_USER_PASSWORD                    @"kmx.account.password"
#define KEY_USER_ACC_STATE                   @"kmx.account.state"


typedef enum _accountState {
    ACCOUNT_GUEST   = 0, //游客账号，等同于注册过程
    ACCOUNT_LOGINED = 1, //账号登入成功,但不是活跃账号
    ACCOUNT_ACTIVE = 2,  //当前活跃账号
    ACCOUNT_LOGINOUT = 3,//账号注销，转为ACCOUNT_LOGINED的状态
    ACCOUNT_DELETE = 4,  //账号删除
    ACCOUNT_STATE_END
} AccountState;

@class User;

@interface AccountMgr : NSObject

+ (AccountMgr *)instance;

@property(nonatomic, readonly, strong) NSString *id;
@property(nonatomic, readonly, strong) NSString *no;
@property(nonatomic, readonly, strong) NSString *psw;
@property(nonatomic, readonly, strong) NSString *token;
@property(nonatomic, readonly, assign) AccountState accState;
@property(nonatomic, readonly, strong) User *user;

- (void) accountMgrInitialize;

//1、当前登录用户
//2、当前用户的token
//3、存、改用户信息
//4、根据ID找User


+ (NSInteger) getAccountCount;
+ (NSArray *) getAccounts;
+ (NSArray *) getAccountIds;


- (void) deleteAccount:(NSString *)userId;
- (void) deleteAllAccounts;

- (BOOL) accountIsActive:(NSString *)userId;
- (BOOL) accountIsLogined:(NSString *)userId;
- (BOOL) accountIsLoginOut:(NSString *)userId;

- (void)signinWith:(NSString *)loginName password:(NSString*)psw user:(User*)user token:(NSString*)token;
- (void)signout;

- (void)updateUserInfo:(User*)user;

@end