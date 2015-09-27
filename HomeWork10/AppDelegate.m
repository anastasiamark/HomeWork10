//
//  AppDelegate.m
//  HomeWork10
//
//  Created by Mark on 24.09.15.
//  Copyright © 2015 ThinkMobiles. All rights reserved.
//

#import "AppDelegate.h"
#import "AMArrayOperation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    AMArrayOperation *myArrayOperation1 = [[AMArrayOperation alloc] initWithDimension:4];
    AMArrayOperation *myArrayOperation2 = [[AMArrayOperation alloc] initWithDimension:4];
    AMArrayOperation *myArrayOperation3 = [[AMArrayOperation alloc] initWithDimension:14];
    AMArrayOperation *myArrayOperation4 = [[AMArrayOperation alloc] initWithDimension:9];
    AMArrayOperation *myArrayOperation5 = [[AMArrayOperation alloc] initWithDimension:4];
    AMArrayOperation *myArrayOperation6 = [[AMArrayOperation alloc] initWithDimension:7];
    AMArrayOperation *myArrayOperation7 = [[AMArrayOperation alloc] initWithDimension:4];
    AMArrayOperation *myArrayOperation8 = [[AMArrayOperation alloc] initWithDimension:15];
    
    [myArrayOperation1 start];
    
    NSOperationQueue * myQueue = [[NSOperationQueue alloc] init];
    myQueue.name = @"Array Operation Queue";
    [myArrayOperation1 cancel];
    myQueue.maxConcurrentOperationCount = 3;
    [myQueue addOperation:myArrayOperation2];
    [myQueue addOperation:myArrayOperation3];
    
    [myQueue setSuspended:YES];
    
    [myQueue addOperation:myArrayOperation4];
    [myQueue addOperation:myArrayOperation5];
    [myQueue addOperation:myArrayOperation6];
    
    [myQueue setSuspended:NO];
    
    [myQueue addOperation:myArrayOperation7];
    
    [myArrayOperation8 start];

    return YES;
}

@end
