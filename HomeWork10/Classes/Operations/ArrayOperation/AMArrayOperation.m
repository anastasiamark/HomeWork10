//
//  AMArrayOperation.m
//  HomeWork10
//
//  Created by Mark on 24.09.15.
//  Copyright © 2015 ThinkMobiles. All rights reserved.
//

#import "AMArrayOperation.h"

@interface AMArrayOperation ()

@property (getter=isExecuting) BOOL executing;
@property (getter=isFinished) BOOL finished;

@end

@implementation AMArrayOperation

@synthesize finished = _finished, executing = _executing;

#pragma mark - Accessors

- (NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"%@", self.array];
    return desc;
}

- (void)setFinished:(BOOL)finished
{
    _finished = finished;
}

- (BOOL)isFinished
{
    return _finished ;
}

- (void)setExecuting:(BOOL)executing
{
    _executing = executing;
}

- (BOOL)isExecuting
{
    return _executing;
}

- (BOOL)isAsynchronous
{
    return YES;
}

#pragma mark - Lifecycle

- (instancetype)initWithDimension:(NSInteger)dimension
{
    self = [super init];
    if (self) {
        _executing = NO;
        _finished = NO;
        _dimension = dimension;
        [self createArrayWithDimension:_dimension];
    }
    return self;
}

#pragma mark - Private methods

- (void)createArrayWithDimension:(NSInteger)demension
{
    _array = [NSMutableArray arrayWithCapacity:demension];
    for (NSInteger i = 0; i < demension; i++) {
        [_array setObject:@(arc4random()%100) atIndexedSubscript:i];
    }
}

- (void)completeOperation
{
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    self.executing = NO;
    self.finished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (void)cancelOperation
{
    [self willChangeValueForKey:@"isFinished"];
    self.finished = YES;
    [self didChangeValueForKey:@"isFinished"];
    NSLog(@"Cancel operation on thread %@", [NSThread currentThread]);
}

- (double)findSum
{
    double sum = 0.f;
    for (NSInteger i = 0; i < self.dimension; i++) {
        sum += [self.array[i] doubleValue];
    }
    return sum;
}

- (double)findArithmeticMean
{
    return [self findSum]/self.dimension;
}

#pragma mark - Override methods

- (void)start
{
    if (self.isCancelled) {
        [self cancelOperation];
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    self.executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    NSLog(@"%@", [NSThread currentThread]);
}

- (void)main
{
    @autoreleasepool {
        if (self.isCancelled) {
            [self cancelOperation];
            return;
        }
        NSLog(@"Array elements: %@.", self);
        
        if (self.isCancelled) {
            [self cancelOperation];
            return;
        }
        
        double sum = [self findSum];
        NSLog(@"Sum of array elements is %f.", sum);
        
        if (self.isCancelled) {
            [self cancelOperation];
            return;
        }
        
        double arithmeticMean = [self findArithmeticMean];
        NSLog(@"Arithmetic mean of array elements is %f.", arithmeticMean);
        
        if (self.isCancelled) {
            [self cancelOperation];
            return;
        }
        
        [self completeOperation];
    }
}

@end
