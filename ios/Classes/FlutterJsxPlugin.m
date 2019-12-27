#import "FlutterJsxPlugin.h"
#if __has_include(<flutter_jsx/flutter_jsx-Swift.h>)
#import <flutter_jsx/flutter_jsx-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_jsx-Swift.h"
#endif

@implementation FlutterJsxPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterJsxPlugin registerWithRegistrar:registrar];
}
@end
