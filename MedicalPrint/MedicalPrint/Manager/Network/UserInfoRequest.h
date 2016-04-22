//
//  RegisterRequest.h
//  MedicalPrint
//
//  Created by zhang fan on 3/20/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"

@class User;
@class ShippingAddress;
@class Order;
@class AboutUsInfo;
@class CaseType;
@class MedicalCase;
@class NewsType;
@class News;
@class CourseTopic;
@class Course;

@interface UserInfoRequest : NSObject

+ (void)registerWithAccount:(NSString *)account password:(NSString *)password phone:(NSString *)phoneNumber code:(NSString *)code withSuccess:(void(^)(User *user, BOOL status))block failure:(NetworkFailureBlock)failure;

+ (void)sendCodeForPhone:(NSString *)phoneNumber WithBlock:(void(^)(NSString *code))block failure:(NetworkFailureBlock)failure;


+ (void)loginWithAccount:(NSString *)account passwork:(NSString *)password withSuccess:(void(^)(User *user, BOOL loginStatus))block failure:(NetworkFailureBlock)failure;

+ (void)changePasswordWithNew:(NSString *)password withCode:(NSString *)code success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure;

+ (void)changeEmail:(NSString *)email code:(NSString *)code success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure;

+ (void)changePhoneNumber:(NSString *)phone code:(NSString *)code success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure;

+ (void)changeUserInfoWithNickname:(NSString *)nickName company:(NSString *)company department:(NSString *)department position:(NSString *)position code:(NSString *)code success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure;


+ (void)fetchAddressList:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *addressArray))block failure:(NetworkFailureBlock)failure;

+ (void)addAddressWithName:(NSString *)name sex:(NSInteger)sex phone:(NSString *)phone address:(NSString *)address success:(void(^)(BOOL status, id responseObject))block failure:(NetworkFailureBlock)failure;

+ (void)updateAddress:(ShippingAddress *)shippingAddress success:(void(^)(BOOL status, ShippingAddress *shippingAddress))block failure:(NetworkFailureBlock)failure;

+ (void)deleteAddress:(ShippingAddress *)shippingAddress success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure;

+ (void)fetchOrderList:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *orderArray))block failure:(NetworkFailureBlock)failure;

+ (void)addNewOrder:(Order *)newOrder success:(void(^)(BOOL status, Order *order))block failure:(NetworkFailureBlock)failure;
+ (void)updateOrder:(Order *)order success:(void(^)(BOOL status, Order *order))block failure:(NetworkFailureBlock)failure;
+ (void)deleteOrder:(Order *)order success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure;

+ (void)fetchListCaseTypeWithSuccess:(void(^)(BOOL status, NSArray *caseTypeArray))block failure:(NetworkFailureBlock)failure;

+ (void)fetchMedicalCaseListForType:(CaseType *)caseType withStart:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *medicalCaseArray))block failure:(NetworkFailureBlock)failure;
+ (void)fetchMyMedicalCaseListStart:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *medicalCaseArray))block failure:(NetworkFailureBlock)failure;
+ (void)addMyMedicalCaseForType:(CaseType *)caseType withTitle:(NSString *)title content:(NSString *)content success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure;
+ (void)deleteMedicalCase:(MedicalCase *)medicalCase success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure;
+ (void)updateMyMedicalCaseFor:(MedicalCase *)medicalCase success:(void(^)(BOOL status, MedicalCase *medicalCase))block failure:(NetworkFailureBlock)failure;
+ (void)fetchMedicalCaseReplyForCase:(MedicalCase *)medicalCase withStart:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *medicalCaseReplyArray))block failure:(NetworkFailureBlock)failure;




+ (void)fetchAboutUsWithSuccess:(void(^)(BOOL status, AboutUsInfo *aboutUsInfo))block failure:(NetworkFailureBlock)failure;

+ (void)sendFeedbackWithConten:(NSString *)content success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure;

+ (void)fetchNewsTypeSuccess:(void(^)(BOOL status, NSArray *newsTypeArray))block failure:(NetworkFailureBlock)failure;
+ (void)fetchMyNewsListStart:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *newsArray))block failure:(NetworkFailureBlock)failure;
+ (void)fetchNewsListForType:(NewsType *)newsType withStart:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *newsArray))block failure:(NetworkFailureBlock)failure;
//+ (void)fetchNewsDetail:(News *)news success:(void(^)(BOOL status, NSString *newsDetail))block failure:(NetworkFailureBlock)failure;

+ (void)searchHomePageNewsWithText:(NSString *)text success:(void(^)(BOOL status, NSArray *newsArray))block failure:(NetworkFailureBlock)failure;

+ (void)updateAPNSStatus:(BOOL)isOpen success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure;

+ (void)fetchCourseTopicSuccess:(void(^)(BOOL status, NSArray *courseTopicArray))block failure:(NetworkFailureBlock)failure;
+ (void)fetchMyCourseListStart:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *courseArray))block failure:(NetworkFailureBlock)failure;
+ (void)fetchCourseListForTopic:(CourseTopic *)courseTopic withStart:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *courseArray))block failure:(NetworkFailureBlock)failure;
+ (void)addMeToMemberOfCourse:(Course *)course success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure;

+ (void)fetchMessageWithStart:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *messagesArray))block failure:(NetworkFailureBlock)failure;


+ (NSArray *)homePageAidImageUrl;

+ (NSString *)userHelpUrl;

@end
