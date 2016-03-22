//
//  Common.h
//  MadicalPrint
//
//  Created by zhang fan on 3/14/16.
//  Copyright © 2016 zhangfan. All rights reserved.
//

#ifndef Common_h
#define Common_h

#ifdef DEBUG
#define QYLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define QYLog(...)
#endif

#define IsSafeValue(value) ((value)!= nil && (NSNull *)(value)!= [NSNull null])


///app/memeber/updatePwd.do
///app/memeber/updateEmail.do


#endif /* Common_h */
