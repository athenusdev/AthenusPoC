# athenus
autoexecuting code on iOS 4.0 to latest, on all processors supported by said versions, with a full kernel exploit implementation and jailbreak (hopefully) on the way

works with a combination of VoIP backgrounding and standard backgrounding thanks to the iOS multitasking implementation.

uses `dispatch_async` and `beginBackgroundTaskWithExpirationHandler` to get ~45s of code execution on an iPhone8,1 running 14.3.

make jailbreaking great again 

with love from w212

please no spyware


# Testing

As far as testing goes, it seems to work on the following:

|Device|Version|Length of Code Execution|       
|-|-|-|
|iPhone 11 Pro|iOS 14.1|~38s|
|iPhone 8|iOS 14.2|~42s|
|iPhone 6s|iOS 14.3|~38s| 
|iPhone 6|iOS 12.4.8|>2 min|
|iPhone 5|iOS 8.2|N/A|

# Credits

- spv: finding autoexecution vulnerability + wrote the base of the autoexecution code

- mario_bros_tech: testing, support, etc

###### NOTE: fuck 4 assholes in particular, they know who they are
