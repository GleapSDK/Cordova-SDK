/********* GleapPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <Gleap/Gleap.h>

@interface GleapPlugin : CDVPlugin {
  // Member variables go here.
}

- (void)initialize:(CDVInvokedUrlCommand*)command;
- (void)identify:(CDVInvokedUrlCommand*)command;
- (void)setLanguage:(CDVInvokedUrlCommand*)command;
- (void)open:(CDVInvokedUrlCommand*)command;
- (void)close:(CDVInvokedUrlCommand*)command;
- (void)isOpened:(CDVInvokedUrlCommand*)command;
- (void)startFeedbackFlow:(CDVInvokedUrlCommand*)command;
- (void)logEvent:(CDVInvokedUrlCommand*)command;
- (void)attachCustomData:(CDVInvokedUrlCommand*)command;
- (void)setCustomData:(CDVInvokedUrlCommand*)command;
- (void)removeCustomData:(CDVInvokedUrlCommand*)command;
- (void)clearCustomData:(CDVInvokedUrlCommand*)command;
- (void)enableDebugConsoleLog:(CDVInvokedUrlCommand*)command;
@end

@implementation GleapPlugin

- (void)initialize:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    if (command.arguments.count == 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    } else {
        NSString* token = [command.arguments objectAtIndex: 0];
        [Gleap initializeWithToken: token];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }

    [self.commandDelegate sendPluginResult: pluginResult callbackId:command.callbackId];
}

- (void)identify:(CDVInvokedUrlCommand *)command {
    NSString* userId = [command.arguments objectAtIndex: 0];
    NSDictionary* userData = [command.arguments objectAtIndex: 1];
    NSString* userHash = [command.arguments objectAtIndex: 2];
    
    GleapUserProperty *gleapUserData = [[GleapUserProperty alloc] init];
    if (userData != nil) {
        if ([userData objectForKey: @"email"]) {
            gleapUserData.email = [userData objectForKey: @"email"];
        }
        if ([userData objectForKey: @"phone"]) {
            gleapUserData.phone = [userData objectForKey: @"phone"];
        }
        if ([userData objectForKey: @"value"]) {
            gleapUserData.value = [userData objectForKey: @"value"];
        }
        if ([userData objectForKey: @"name"]) {
            gleapUserData.name = [userData objectForKey: @"name"];
        }
    }
    
    if (userHash == nil) {
        [Gleap identifyUserWith: userId andData: gleapUserData];
    } else {
        [Gleap identifyUserWith: userId andData: gleapUserData andUserHash: userHash];
    }

    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)setLanguage:(CDVInvokedUrlCommand *)command {
    NSString* language = [command.arguments objectAtIndex: 0];
    if (language != nil) {
        [Gleap setLanguage: language];
    }

    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)open:(CDVInvokedUrlCommand *)command {
    [Gleap open];
    
    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)close:(CDVInvokedUrlCommand *)command {
    [Gleap close];
    
    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)isOpened:(CDVInvokedUrlCommand *)command {
    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsBool: [Gleap isOpened]] callbackId:command.callbackId];
}

- (void)logEvent:(CDVInvokedUrlCommand *)command {
    NSString* name = [command.arguments objectAtIndex: 0];
    NSDictionary* data = [command.arguments objectAtIndex: 1];
    if (name != nil) {
        if (data != nil) {
            [Gleap logEvent: name withData: data];
        } else {
            [Gleap logEvent: name];
        }
    }

    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)startFeedbackFlow:(CDVInvokedUrlCommand *)command {
    NSString* feedbackFlow = [command.arguments objectAtIndex: 0];
    bool showBackButton = [command.arguments objectAtIndex: 1];
    if (feedbackFlow != nil) {
        [Gleap startFeedbackFlow: feedbackFlow showBackButton: showBackButton];
    }

    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)attachCustomData:(CDVInvokedUrlCommand *)command {
    NSDictionary* customData = [command.arguments objectAtIndex: 0];
    if (customData != nil) {
        [Gleap attachCustomData: customData];
    }

    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)setCustomData:(CDVInvokedUrlCommand *)command {
    NSString* key = [command.arguments objectAtIndex: 0];
    NSString* value = [command.arguments objectAtIndex: 1];
    if (key != nil && value != nil) {
        [Gleap setCustomData: value forKey: key];
    }

    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)removeCustomData:(CDVInvokedUrlCommand *)command {
    NSString* key = [command.arguments objectAtIndex: 0];
    if (key != nil) {
        [Gleap removeCustomDataForKey: key];
    }

    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)clearCustomData:(CDVInvokedUrlCommand *)command {
    [Gleap clearCustomData];

    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)enableDebugConsoleLog:(CDVInvokedUrlCommand *)command {
    [Gleap enableDebugConsoleLog];

    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

@end
