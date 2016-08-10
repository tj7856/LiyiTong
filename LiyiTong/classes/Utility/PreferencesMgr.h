//
//  PreferencesMgr.h
//  y
//
//  Created by name on 12-8-29.
//
//

#import <Foundation/Foundation.h>

@interface PreferencesMgr : NSObject

+ (BOOL)saveObject:(id)object with:(NSString *)key;
+ (id)getObject:(NSString *)key;
+ (void)deleteObject:(NSString *)key;

+ (void)saveObject:(id)object with:(NSString *)key withUserId:(NSString *)userId;
+ (id)getObject:(NSString *)key withUserId:(NSString *)userId;
+ (void)deleteObject:(NSString *)key withUserId:(NSString *)userId;

//Account info
+ (void)saveAccounts:(NSArray *)accounts;
+ (void)saveAccountInfo:(NSString *)userId withObject:(id)info with:(NSString *)key;
+ (NSArray *)getAccountIds;
+ (NSArray *)getAccounts;
+ (NSDictionary *)getAccount:(NSString *)userId;
+ (id)getAccountInfo:(NSString *)userId with:(NSString *)key;
+ (void) deleteAccount:(NSString *)userId;
+ (void) deleteAllAccounts;




//个推deviceToken
//+ (void)saveGeTuiDeviceToken:(NSString*)token;
//+ (NSString*)getGeTuiDeviceToken;
@end
