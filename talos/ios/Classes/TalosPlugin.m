#import "TalosPlugin.h"
#if __has_include(<talos/talos-Swift.h>)
#import <talos/talos-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "talos-Swift.h"
#endif

@implementation TalosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTalosPlugin registerWithRegistrar:registrar];
}
@end
