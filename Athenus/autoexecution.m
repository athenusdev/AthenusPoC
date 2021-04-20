//
//  autoexecution.m
//  Athenus
//
//  any code placed in fun(...) will be autoexecuted.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include "config.h"

int fun(int argc, char* argv[]) {
    NSLog(@"hello from autoexecution!");
    if (RUN_NOTIF_TEST) {
        while (1) {
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            notification.fireDate = [[NSDate date] dateByAddingTimeInterval:0];
            notification.alertBody = @"1s passed";
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            sleep(1);
        }
    }
    return 0;
}
