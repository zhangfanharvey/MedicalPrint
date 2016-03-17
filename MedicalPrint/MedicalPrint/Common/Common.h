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


#endif /* Common_h */
