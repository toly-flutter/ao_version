#import "AoVersionPlugin.h"
#import <ao_version/ao_version-Swift.h>

@implementation AoVersionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAoVersionPlugin registerWithRegistrar:registrar];
}
@end
