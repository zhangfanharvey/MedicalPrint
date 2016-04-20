//
//  APIConfigure.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/18.
//  Copyright © 2016年 Medical. All rights reserved.
//

#ifndef APIConfigure_h
#define APIConfigure_h

//#define MPTestEnviroment    1
#ifdef MPTestEnviroment
#define kMPBaseHostUrl  @"115.159.75.148"
//#define kMPBaseUrl  @"http://119.29.25.47/orthopedics"
#define kMPBaseUrl  @"http://115.159.75.148:8081/orthopedics"
#else
#define kMPBaseHostUrl  @"115.159.75.148"
//#define kMPBaseUrl  @"http://119.29.25.47/orthopedics"
#define kMPBaseUrl  @"http://139.196.106.246:8081/orthopedics"
//http://139.196.106.246:8081/orthopedics
#endif

//http://119.29.25.47/orthopedics /app/memeber/register.do

#define kMPRegisterUrl  @"/app/memeber/register.do"
#define kMPSendCodeUrl  @"/app/memeber/sendCode.do"
#define kMPLoginUrl  @"/app/memeber/login.do"
#define kMPChangePasswordUrl  @"app/memeber/updatePwd.do"
#define kMPChangeEmailUrl  @"/app/memeber/updateEmail.do"
#define kMPChangePhoneUrl  @"/app/memeber/updatePhone.do"
#define kMPChangeUserInfoUrl  @"/app/memeber/updateEmailAuth.do"
#define kMPFetchAddressListUrl  @"/app/address/list.do"
#define kMPAddAddressUrl  @"/app/address/add.do"
#define kMPUpdateAddressUrl  @"/app/address/save.do"
#define kMPDeleteAddressUrl  @"/app/address/delete.do"
#define kMPFetchOrderListUrl  @"/app/order/list.do"
#define kMPAddOrderUrl  @"/app/order/add.do"
#define kMPUpdateOrderUrl  @"/app/order/update.do"
#define kMPDeleteOrderUrl  @"/app/order/delete.do"
#define kMPFetchListCaseTypeUrl  @"/app/cases/listCaseType.do"
#define kMPFetchAboutUsInfoUrl  @"/app/aboutus/look.do"
#define kMPSendFeedbackUrl  @"/app/feedback/add.do"
#define kMPFetchMedicalCaseUrl  @"/app/cases/listTypeCase.do"
#define kMPFetchMyMedicalCaseUrl  @"/app/feedback/listCase.do"
#define kMPAddMyMedicalCaseUrl  @"/app/cases/addCase.do"
#define kMPUpdateMyMedicalCaseUrl  @"/app/cases/saveCase.do"
#define kMPFetchListNewsTypeUrl  @"/app/homepage/listNewsType.do"
#define kMPFetchNewsForTypeUrl  @"/app/homepage/listTypeNews.do"
///app/homepage/listTypeNews.do
#define kMPFetchMyNewsUrl  @"/app/homepage/listNews.do"
#define kMPFetchMedicalCaseReplyUrl  @"/app/cases/listCaseReply.do"
#define kMPDeleteMedicalCaseUrl  @"/app/cases/deleteCase.do"
#define kMPSearchHomePageNewsUrl  @"/app/homepage/find.do"
#define kMPUpdateAPNSStatusUrl  @"/app/memeber/apnsState.do"
#define kMPFetchCourseTopicUrl  @"/app/course/listTopics.do"
#define kMPFetchCourseForTopicUrl  @"/app/course/listCourse.do"
#define kMPFetchMyCourseUrl  @"/app/course/listMyCourse.do"
#define kMPMeToMemberOfCourseUrl  @"/app/course/addMemberCourse.do"
#define kMPFetchMessageUrl  @"/app/memeber/message.do"


#endif /* APIConfigure_h */
