/********* GleapPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <Gleap/Gleap.h>

@interface GleapPlugin : CDVPlugin {
  // Member variables go here.
}

- (void)initialize:(CDVInvokedUrlCommand*)command;
@end

@implementation GleapPlugin

- (void)initialize:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    if (command.arguments.count == 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    } else {
        NSString* token = [command.arguments objectAtIndex:0];
        [Gleap initializeWithToken: token];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }

    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

@end
