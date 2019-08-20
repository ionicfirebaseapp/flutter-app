//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <file_picker/FilePickerPlugin.h>
#import <flutter_local_notifications/FlutterLocalNotificationsPlugin.h>
#import <flutter_sound/FlutterSoundPlugin.h>
#import <image_picker/ImagePickerPlugin.h>
#import <location/LocationPlugin.h>
#import <path_provider/PathProviderPlugin.h>
#import <scheduled_notifications/ScheduledNotificationsPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FilePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FilePickerPlugin"]];
  [FlutterLocalNotificationsPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterLocalNotificationsPlugin"]];
  [FlutterSoundPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterSoundPlugin"]];
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
  [LocationPlugin registerWithRegistrar:[registry registrarForPlugin:@"LocationPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [ScheduledNotificationsPlugin registerWithRegistrar:[registry registrarForPlugin:@"ScheduledNotificationsPlugin"]];
}

@end
