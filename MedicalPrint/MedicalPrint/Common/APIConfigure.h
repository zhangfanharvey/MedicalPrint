//
//  APIConfigure.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/18.
//  Copyright © 2016年 Medical. All rights reserved.
//

#ifndef APIConfigure_h
#define APIConfigure_h

#define MPTestEnviroment    1
#ifdef MPTestEnviroment
#define kMPBaseUrl  @"http://119.29.25.47/orthopedics"
#else
#define kMPBaseUrl  @"http://119.29.25.47/orthopedics"
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
#define kMPFetchMyNewsUrl  @"/app/homepage/listNews.do"
#define kMPFetchMedicalCaseReplyUrl  @"/app/cases/listCaseReply.do"
#define kMPDeleteMedicalCaseUrl  @"/app/cases/deleteCase.do"


#endif /* APIConfigure_h */
