//
//  Task.h
//  ZApp
//
//  Created by Anton Shastun on 7/17/13.
//  Copyright (c) 2013 Anton Shastun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSString  *desc;
@property (nonatomic) BOOL isComplete;

@end
