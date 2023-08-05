// See http://iphonedevwiki.net/index.php/Logos

#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <UIKit/UIKit.h>
#include <dlfcn.h>

static NSString *k_YourViewing_Plist_Path = @"/var/mobile/Library/Preferences/com.in8.yourviewing.plist";
static NSString *kALSettingsKey = @"YourViewing";

%ctor {
    @autoreleasepool {
        NSDictionary *switchDict = [NSDictionary dictionaryWithContentsOfFile:k_YourViewing_Plist_Path];
        NSString *switchOnApp = [switchDict objectForKey:kALSettingsKey];
        NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
        NSString *appPath = [[NSBundle mainBundle] executablePath];
        
        if ([appPath containsString:@"/var/containers/Bundle/Application/"] || [appPath containsString:@"/Applications/"]) {
            if (switchOnApp.length && bundleIdentifier.length && [switchOnApp isEqualToString:bundleIdentifier]) {
                NSString *libPath = @"/Library/Application Support/YourView/libyourview.framework/libyourview";
                if (![[NSFileManager defaultManager] fileExistsAtPath:libPath]) {
                    return;
                }
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    dlopen([libPath UTF8String], RTLD_NOW);
                });
            }
        }
    }
};
