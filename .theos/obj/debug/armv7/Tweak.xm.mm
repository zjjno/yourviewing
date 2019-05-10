#line 1 "Tweak.xm"
#import <UIKit/UIKit.h>
static NSString *k_YourViewing_Plist_Path = @"/var/mobile/Library/Preferences/com.in8.yourviewing.plist";
static NSString *kALSettingsKey = @"YourViewing";

@interface Main : NSObject
+(void)_main;
@end

static __attribute__((constructor)) void _logosLocalCtor_344ae32b(int __unused argc, char __unused **argv, char __unused **envp) {
    @autoreleasepool {
        NSDictionary *switchDict = [NSDictionary dictionaryWithContentsOfFile:k_YourViewing_Plist_Path];
        NSString *switchOnApp = [switchDict objectForKey:kALSettingsKey];
        NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
        NSString *appPath = [[NSBundle mainBundle] executablePath];
        
        if ([appPath hasPrefix:@"/var/containers/Bundle/Application/"] || [appPath hasPrefix:@"/Applications/"]) {
            if (switchOnApp.length && bundleIdentifier.length && [switchOnApp isEqualToString:bundleIdentifier]) {
                [Main _main];
            }
        }
    }
};



