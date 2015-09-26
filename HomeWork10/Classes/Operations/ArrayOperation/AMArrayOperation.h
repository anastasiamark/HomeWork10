//
//  AMArrayOperation.h
//  HomeWork10
//
//  Created by Mark on 24.09.15.
//  Copyright © 2015 ThinkMobiles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMArrayOperation : NSOperation

@property (nonatomic, readonly) NSInteger dimension;
@property (nonatomic) NSMutableArray *array;

- (instancetype)initWithDimension:(NSInteger)dimension;

@end
