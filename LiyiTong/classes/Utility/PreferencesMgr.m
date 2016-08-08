//
//  PreferencesMgr.m
//  y
//
//  Created by name on 12-8-29.
//
//

#import "PreferencesMgr.h"
//#import "Constant.h"
#import "AccountMgr.h"


@implementation PreferencesMgr

+ (NSArray *) transformToKeys:(NSString *)key {
    NSArray *keys = [[NSArray alloc] init];
    
    int preIndex = 0;
    int endIndex = 0;
    for (int i = 0; i < key.length; i++) {
        unichar keychar = [key characterAtIndex:i];
        if (keychar == '|') {
            endIndex = i;
            keys = [keys arrayByAddingObject:[key substringWithRange:NSMakeRange(preIndex, endIndex - preIndex)]];
            preIndex = endIndex + 1;
        }
        
        if (i == key.length - 1) {
            endIndex = i;
            keys = [keys arrayByAddingObject:[key substringWithRange:NSMakeRange(preIndex, endIndex - preIndex + 1)]];
        }
    }
    return keys;
}

+ (NSString *) keysFormatToString:(NSArray *)keys {
    NSString *key = [[NSString alloc] init];
    
    for (int i = 0; i < keys.count; i++) {
        if (i < keys.count - 1) {
            key = [key stringByAppendingFormat:@"%@|", [keys objectAtIndex:i]];
        } else {
            key = [key stringByAppendingString:[keys objectAtIndex:i]];
        }
    }
    return key;
}

+ (BOOL)saveObject:(id)object with:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *keys = [PreferencesMgr transformToKeys:key];
    
    if (keys.count > 1) {
        id defaultsObj = [defaults objectForKey:[keys objectAtIndex:0]];
        if (defaultsObj && ![defaultsObj isKindOfClass:[NSDictionary class]]) {
//            KLOGV(@"PreferencesMgr saveObject", @"defaultsObj, instance 0x%08x of %@ with key %@", defaultsObj, NSStringFromClass([defaultsObj class]), key);
            return NO;
        } else if (!defaultsObj) {
            defaultsObj = [[NSDictionary alloc] init];
        }
        
        NSArray *parentsObjs = [[NSArray alloc] init];
        int index = 0;
        id parentObj = defaultsObj;
        while (index < keys.count) {
            if (index == keys.count - 1) {
                if (object) {
                    parentsObjs = [parentsObjs arrayByAddingObject:object];
                } else {
//                    KLOGL(@"PreferencesMgr saveObject", @"object is null.");
                    return NO;
                }
            } else {
                parentsObjs = [parentsObjs arrayByAddingObject:parentObj];
                
                id childObj = [parentObj objectForKey:[keys objectAtIndex:index + 1]];
                if (childObj && ![childObj isKindOfClass:[NSDictionary class]] && (index + 1 != keys.count - 1)) {
//                    KLOGV(@"PreferencesMgr saveObject", @"childObj, instance 0x%08x of %@ with key %@", childObj, NSStringFromClass([childObj class]), key);
                    return NO;
                } else if (!childObj) {
                    childObj = [[NSDictionary alloc] init];
                }
                parentObj = childObj;
            }
            ++index;
        }
        
        if (parentsObjs.count > 1) {
            NSMutableArray *save = [[NSMutableArray alloc] initWithArray:parentsObjs];
            for (int i = parentsObjs.count - 1; i > 0; i--) {
                id saveChildObj = [save objectAtIndex:i];
                NSMutableDictionary *saveParentObj = [NSMutableDictionary dictionaryWithDictionary:[save objectAtIndex:i - 1]];
                [saveParentObj setObject:saveChildObj forKey:[keys objectAtIndex:i]];
                
                [save replaceObjectAtIndex:i - 1 withObject:saveParentObj];
            }
            [defaults setObject:[save objectAtIndex:0] forKey:[keys objectAtIndex:0]];
        } else {
            [defaultsObj setObject:[parentsObjs objectAtIndex:0] forKey:[keys objectAtIndex:1]];
            [defaults setObject:defaultsObj forKey:[keys objectAtIndex:0]];
        }
    } else if (keys.count == 1){
        if (object) {
            [defaults setObject:object forKey:[keys objectAtIndex:0]];
        } else {
//            KLOGL(@"PreferencesMgr saveObject", @"object is null.");
            return NO;
        }
    } else {
//        KLOGL(@"PreferencesMgr saveObject", @"key is nil");
    }

    [defaults synchronize];
    
    return YES;
}

+ (id)getObject:(NSString *)key {
    NSArray *keys = [PreferencesMgr transformToKeys:key];
    if (keys.count > 0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        id defaultsObj = [defaults objectForKey:[keys objectAtIndex:0]];
        
        if (!defaultsObj) {
            return nil;
        }
        NSArray *parentsObjs = [[NSArray alloc] init];
        int index = 1;
        id parentObj = defaultsObj;
        while (index < keys.count) {
            parentsObjs = [parentsObjs arrayByAddingObject:parentObj];
            
            id childObj = [parentObj objectForKey:[keys objectAtIndex:index]];
            if (!childObj) {
                return nil;
            }
            parentObj = childObj;
            ++index;
        }
        return parentObj;
    }

    return nil;
}

+ (void)deleteObject:(NSString *)key {
    int index = 0;
    for (int i = 0; i < key.length; i++) {
        unichar keyChar = [key characterAtIndex:i];
        if (keyChar == '|') {
            index = i;
        }
    }
    
    if (index > 0) {
        NSString *parentKey = [NSString stringWithString:[key substringWithRange:NSMakeRange(0, index)]];
        NSString *childKey = [NSString stringWithString:[key substringFromIndex:(index + 1)]];
        NSMutableDictionary *parentObj = [[NSMutableDictionary alloc] initWithDictionary:[PreferencesMgr getObject:parentKey]];
        
        [parentObj removeObjectForKey:childKey];
        [PreferencesMgr saveObject:parentObj with:parentKey];
    } else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nil forKey:key];
        [defaults synchronize];
    } 
}

+ (NSString *) keyFormat:(NSString *)key withUserId:(NSString *)userId {
    NSMutableString *string = [NSMutableString stringWithString:key];
    
    if ([string rangeOfString:@"|"].location != NSNotFound) {
        [string insertString:[userId stringByAppendingString:@"|"] atIndex:[string rangeOfString:@"|"].location + 1];
    } else {
        [string appendFormat:@"|%@", userId];
    }
    
    return string;
}

+ (void)saveObject:(id)object with:(NSString *)key withUserId:(NSString *)userId {
    NSString *formatKey = [PreferencesMgr keyFormat:key withUserId:userId];
    if (object && formatKey.length > 0) {
        [PreferencesMgr saveObject:object with:formatKey];
    }
}

+ (id)getObject:(NSString *)key withUserId:(NSString *)userId {
    NSString *formatKey = [PreferencesMgr keyFormat:key withUserId:userId];
    if (formatKey.length > 0) {
        return [PreferencesMgr getObject:formatKey];
    }
    return nil;
}

+ (void)deleteObject:(NSString *)key withUserId:(NSString *)userId {
    NSString *formatKey = [PreferencesMgr keyFormat:key withUserId:userId];
    if (formatKey.length > 0) {
        [PreferencesMgr deleteObject:formatKey];
    }
}


//refer to account

+ (void)saveAccounts:(NSArray *)accounts {
    [[NSUserDefaults standardUserDefaults] setObject:accounts forKey:KEY_ACCOUNT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveAccountInfo:(NSString *)userId withObject:(id)info with:(NSString *)key {
    NSArray *root = [PreferencesMgr getAccounts];
    NSMutableArray *newRoot = [[NSMutableArray alloc] init];
    if (root) {
        BOOL isNew = YES;
        for (int i = 0; i < root.count; i++) {
            NSMutableDictionary *account = [NSMutableDictionary dictionaryWithDictionary:[newRoot objectAtIndex:i]];
            NSString *accountId = [account objectForKey:KEY_USER_ID];
            if ([userId isEqualToString:accountId]) {
                isNew = NO;
                [account setValue:info forKey:key];
            }
            [newRoot addObject:account];
        }
        
        if (isNew) {
            NSMutableDictionary *account = [[NSMutableDictionary alloc] init];
            [account setObject:userId forKey:KEY_USER_ID];
            if (![key isEqualToString:KEY_USER_ID]) {
                [account setObject:info forKey:key];
            }
            [newRoot addObject:account];
        }
    }
    
    [PreferencesMgr saveAccounts:newRoot];
}

+ (NSArray *)getAccounts {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *root = [defaults objectForKey:KEY_ACCOUNT];
    NSMutableArray *accounts = [[NSMutableArray alloc] init];
    if (root) {
        for (int i = 0; i < root.count; i++) {
            NSDictionary *account = [root objectAtIndex:i];
//            NSString *id = [account objectForKey:KEY_USER_ID];
//            if (![id isEqualToString:DEMO_USERID]) {
                [accounts addObject:account];
//            }
        }
    }
    return accounts;
}

+ (NSArray *)getAccountIds {
    NSArray *accounts = [PreferencesMgr getAccounts];
    NSArray *accountIds = [[NSArray alloc] init];
    for (int i = 0; i < accounts.count; i++) {
        NSDictionary *account = [accounts objectAtIndex:i];
        NSString *accountId = [account objectForKey:KEY_USER_ID];
        accountIds = [accountIds arrayByAddingObject:accountId];
    }
    
    return accountIds;
}

+ (NSDictionary *)getAccount:(NSString *)userId {
    NSArray *accounts = [PreferencesMgr getAccounts];
    
    if (accounts) {
        for (int i = 0; i < accounts.count; i++) {
            NSDictionary *user = [accounts objectAtIndex:i];
            NSString *accountId = [user objectForKey:KEY_USER_ID];
            if ([accountId isEqualToString:userId]) {
                return user;
            }
        }
    }
    
    return nil;
}

+ (id)getAccountInfo:(NSString *)userId with:(NSString *)key {
    NSDictionary *dic = [PreferencesMgr getAccount:userId];
    
    return [dic objectForKey:key];
}

+ (void) deleteAccount:(NSString *)userId  {
    NSArray *accounts = [PreferencesMgr getAccounts];
    if (accounts) {
        NSArray *newAccounts = [[NSArray alloc] init];
        for (int i = 0; i < accounts.count; i++) {
            NSDictionary *user = [accounts objectAtIndex:i];
            NSString *accountId = [user objectForKey:KEY_USER_ID];
            if (![accountId isEqualToString:userId]) {
                newAccounts = [newAccounts arrayByAddingObject:user];
            }
        }
        
        [PreferencesMgr saveAccounts:newAccounts];
    }
}

+ (void) deleteAllAccounts {
    NSArray *newAccounts = [[NSArray alloc] init];
    [PreferencesMgr saveAccounts:newAccounts];
}



////个推deviceToken
//+ (void)saveGeTuiDeviceToken:(NSString*)token{
//    if (!token) {
//        return;
//    }
//    [PreferencesMgr saveObject:token with:KEY_GETUI_DEVICETOKEN];
//}
//
//+ (NSString*)getGeTuiDeviceToken{
//    NSString*token = [PreferencesMgr getObject:KEY_GETUI_DEVICETOKEN];
//    if (!token) {
//        return @"";
//    }
//    return token;
//}
@end
