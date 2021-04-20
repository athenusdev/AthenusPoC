//
//  AppDelegate.m
//  Athenus
//

#import "AppDelegate.h"
#include "autoexecution.h"
#include "config.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

void display_code_exec_notice() {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [[NSDate date] dateByAddingTimeInterval:0];
    notification.alertBody = [NSString stringWithUTF8String:CODE_EXEC_NOTICE];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

void display_done_notice() {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [[NSDate date] dateByAddingTimeInterval:0];
    notification.alertBody = [NSString stringWithUTF8String:DONE_NOTICE];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

void set_last() {
    long curr_time = time(NULL);
    [[NSUserDefaults standardUserDefaults] setInteger:curr_time forKey:@"last"];
}

int no_run_multi() {
    /*
     checks if function has been run in the past 20 seconds, and if so, exits. just in case.
     
     PSEUDO-CODE:
     get last time
     convert to int
     check if time is less than last time + 20
     if so, close
     if not, run
     save new time as last time
     
     if you need to run your autoexecution more than once in 1:30 then fix it yourself
     im a lazy ass and it's 12:22 AM right now and I have school tomorrow
     - spv
     */
    long curr_time;
    curr_time = time(NULL);
    
    long last;
    last = [[NSUserDefaults standardUserDefaults] integerForKey:@"last"];
    
    long last_int;
    last_int = last;
    if (curr_time <= last_int + 20) {
        set_last();
        return 1;
    }
    
    set_last();
    return 0;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        if (no_run_multi())
            exit(0);
        if (DISPLAY_CODE_EXECUTION_NOTICE)
            display_code_exec_notice(); // try to help combat abuse
        
        /*
         get more time
         */
        __block UIBackgroundTaskIdentifier backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            
            [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskIdentifier];
            
            backgroundTaskIdentifier = UIBackgroundTaskInvalid;
        }];
        
        /*
         set up logging of stdout and stderr
         */
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *fileName =[NSString stringWithFormat:@"%@.txt",[NSDate date]];
        NSString *logFilePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stdout);
        freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
        
        /*
         have fun
         */
        int ret;
        ret = fun(0, 0);
        
        if (DISPLAY_DONE_NOTICE)
            display_done_notice();
        
        set_last();
        backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    });
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
