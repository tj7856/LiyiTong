//
//  Created by name on 12-3-6.
//
//


#import "AccountMgr.h"
#import "PreferencesMgr.h"

@implementation AccountMgr

@synthesize id = _id;
@synthesize no = _no;
@synthesize psw = _psw;
@synthesize token = _token;
@synthesize accState = _accState;
@synthesize user = _user;

+ (AccountMgr *)instance {
    static AccountMgr *_instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    });
    return _instance;

}

+ (NSInteger) getAccountCount {
    return [self getAccounts].count;
}

+ (NSArray *) getAccounts {
    return [PreferencesMgr getAccounts];
}

+ (NSArray *) getAccountIds {
    return [PreferencesMgr getAccountIds];
}

- (void) setGuestAccountInfo {
    _id = nil;//DEMO_USERID;
    _token = nil;//DEMO_TOKEN;
    _accState = ACCOUNT_GUEST;
}

- (void) updateAccountWithUser:(User*)user {
    if (user) {
        [self saveAccount];
    }
}

- (void) deleteAccount:(NSString *)userId {
    [PreferencesMgr deleteAccount:userId];
    
    NSInteger count = [AccountMgr getAccountCount];
    if ([userId isEqualToString:_id] || count < 1) {
        [self setGuestAccountInfo];
    }
    [self save];
}

- (void) deleteAllAccounts {
    [PreferencesMgr deleteAllAccounts];
    [self setGuestAccountInfo];
    [self save];
}

- (NSDictionary *) getActiveAccount {
    NSArray *accounts = [AccountMgr getAccounts];
    if (accounts && accounts.count > 0) {
        for (int i = 0; i < accounts.count; i++) {
            NSDictionary *account = [accounts objectAtIndex:i];
            NSNumber *accState = [account objectForKey:KEY_USER_ACC_STATE];
            if (accState && [accState intValue] == ACCOUNT_ACTIVE) {
                return  account;
            }
        }
        //没有找到活跃的账号，就找最后登录的那个
        return [accounts objectAtIndex:0];
    }
    
    return nil;
}

- (void) accountMgrInitialize {
    NSDictionary *account = [self getActiveAccount];
    if (account) {
        NSNumber *accState = [account objectForKey:KEY_USER_ACC_STATE];
        if (accState) {
            _accState = [accState intValue];
         
            _user = [User fromDictionary:account];
            _id = [account objectForKey:KEY_USER_ID];
            _token = [account objectForKey:KEY_USER_TOKEN];
            _no = [account objectForKey:KEY_USER_NO];
            _psw = [account objectForKey:KEY_USER_PASSWORD];
        }
    }
        
    if (!_id || !_token)
    {
        [self setGuestAccountInfo];
        return;
    }
    [self save];
}

- (id)init {
    self = [super init];
    if (self) {

    }

    return self;
}

- (User *)user {
    if (!_user) {
        _user = [User fromDictionary:[PreferencesMgr getAccount:_id]];
    }
    //要解析成user
    return _user;
}

- (void)saveAccount {
    NSArray *accountsRoot = [PreferencesMgr getAccounts];
    NSMutableArray *accounts = [[NSMutableArray alloc] init];
    if (accountsRoot) {
        [accounts addObjectsFromArray:accountsRoot];
    }
    
    NSMutableDictionary *newAccount = [NSMutableDictionary dictionaryWithDictionary:[User fromData:self.user]];
    [newAccount setObject:_token forKey:KEY_USER_TOKEN];
    [newAccount setObject:_no forKey:KEY_USER_NO];
    [newAccount setObject:_psw forKey:KEY_USER_PASSWORD];
    [newAccount setObject:[NSNumber numberWithInt:_accState] forKey:KEY_USER_ACC_STATE];
    
//    BOOL isNew = YES;
    for (int i = 0; i < accounts.count; i++) {
        NSDictionary *user = [accounts objectAtIndex:i];
        NSString *userId = [user objectForKey:KEY_USER_ID];
        if ([userId isEqualToString:_id]) {
//            isNew = NO;
            [accounts removeObjectAtIndex:i];
            break;
            // replaceObjectAtIndex:i withObject:newAccount];
        }
    }
    
//    if (isNew) {
        [accounts insertObject:newAccount atIndex:0];
//    }
    [PreferencesMgr saveAccounts:accounts];
}

- (void)save {
    [self saveAccount];
}

- (void)setCurrentActiveAccountToLogined {
    NSDictionary *account = [self getActiveAccount];
    
    if (account) {
        _accState = ACCOUNT_LOGINED;
        _id = [account objectForKey:KEY_USER_ID];
        _token = [account objectForKey:KEY_USER_TOKEN];
        _no = [account objectForKey:KEY_USER_NO];
        _psw = [account objectForKey:KEY_USER_PASSWORD];
        [self save];
    }
}

- (void)signinWith:(NSString *)loginName password:(NSString*)psw user:(User*)user token:(NSString*)token{
    
    _user = user;
    NSString* id = _user.id;
//    NSString* token = [userDic objectForKey:KEY_USER_TOKEN];
//    NSAssert(id, @"signinWith nil id!!!");
 
    NSArray *accoutIds = [AccountMgr getAccountIds];
    for (int i = 0; i < accoutIds.count; i++) {
        NSString *userId = [accoutIds objectAtIndex:i];
        if ([userId isEqualToString:id] && ([self accountIsLogined:userId] || [self accountIsActive:userId])) {
//            _signedIn = YES;
            break;
        }
        
        if (![userId isEqualToString:id] && [self accountIsActive:userId]) {
            [self setCurrentActiveAccountToLogined];
        }
    }
    
    //Check whether the previous account need cancel push relation.
    NSString *preId = _id;
    _id = id;
    _token = token;
    _no = loginName;
    _psw = psw;
    _accState = ACCOUNT_ACTIVE;
    [self save];
    
    if (preId && ![preId isEqualToString:_id]) {
        //发设备号
//        [CommandUtils switchPushRelationWithUser:preId];
    }
}

- (void)signout {
    _accState = ACCOUNT_LOGINOUT;
    [self save];
}


- (NSInteger) handleAccountPush:(NSString *)userId {
    NSDictionary *account = [PreferencesMgr getAccount:userId];
    return [[account objectForKey:KEY_USER_ACC_STATE] integerValue];
}

- (BOOL) accountIsActive:(NSString *)userId {
    NSInteger state = [self handleAccountPush:userId];
    if (state == ACCOUNT_ACTIVE) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL) accountIsLogined:(NSString *)userId {
    NSInteger state = [self handleAccountPush:userId];
    if (state == ACCOUNT_LOGINED) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL) accountIsLoginOut:(NSString *)userId {
    NSInteger state = [self handleAccountPush:userId];
    if (state == ACCOUNT_LOGINOUT) {
        return YES;
    } else {
        return NO;
    }
}

- (void)updateUserInfo:(User*)user{
    if (!user) {
        _user = nil;
        return;
    }
    _user = user;
    [self save];
}

@end
