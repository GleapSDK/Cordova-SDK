/********* GleapPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <Gleap/Gleap.h>

@interface GleapPlugin : CDVPlugin {
  // Member variables go here.
}

- (void)initialize:(CDVInvokedUrlCommand*)command;
- (void)identify:(CDVInvokedUrlCommand*)command;
- (void)startFeedbackFlow:(CDVInvokedUrlCommand*)command;
- (void)startBot:(CDVInvokedUrlCommand*)command;
- (void)sendSilentCrashReport:(CDVInvokedUrlCommand*)command;
- (void)setLanguage:(CDVInvokedUrlCommand*)command;
- (void)open:(CDVInvokedUrlCommand*)command;
- (void)openChecklists:(CDVInvokedUrlCommand*)command;
- (void)openChecklist:(CDVInvokedUrlCommand*)command;
- (void)startChecklist:(CDVInvokedUrlCommand*)command;
- (void)openNews:(CDVInvokedUrlCommand*)command;
- (void)openNewsArticle:(CDVInvokedUrlCommand*)command;
- (void)openHelpCenter:(CDVInvokedUrlCommand*)command;
- (void)openHelpCenterArticle:(CDVInvokedUrlCommand*)command;
- (void)openHelpCenterCollection:(CDVInvokedUrlCommand*)command;
- (void)searchHelpCenter:(CDVInvokedUrlCommand*)command;
- (void)close:(CDVInvokedUrlCommand*)command;
- (void)isOpened:(CDVInvokedUrlCommand*)command;
- (void)trackEvent:(CDVInvokedUrlCommand*)command;
- (void)attachCustomData:(CDVInvokedUrlCommand*)command;
- (void)setCustomData:(CDVInvokedUrlCommand*)command;
- (void)removeCustomData:(CDVInvokedUrlCommand*)command;
- (void)clearCustomData:(CDVInvokedUrlCommand*)command;
- (void)enableDebugConsoleLog:(CDVInvokedUrlCommand*)command;
- (void)clearIdentity:(CDVInvokedUrlCommand*)command;
- (void)showSurvey:(CDVInvokedUrlCommand*)command;
- (void)log:(CDVInvokedUrlCommand*)command;
- (void)preFillForm:(CDVInvokedUrlCommand*)command;
- (void)getIdentity:(CDVInvokedUrlCommand*)command;
- (void)isUserIdentified:(CDVInvokedUrlCommand*)command;
- (void)setDisableInAppNotifications:(CDVInvokedUrlCommand*)command;
@end

@implementation GleapPlugin

- (void)initialize:(CDVInvokedUrlCommand*)command
{
    @try {
        CDVPluginResult* pluginResult = nil;
        
        if (command.arguments.count == 0) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        } else {
            NSString* token = [command.arguments objectAtIndex: 0];
            [Gleap initializeWithToken: token];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
        
        [Gleap setApplicationType: CORDOVA];

        [self.commandDelegate sendPluginResult: pluginResult callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)showSurvey:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* surveyId = [command.arguments objectAtIndex: 0];
        NSString* format = [command.arguments objectAtIndex: 1];

        GleapSurveyFormat surveyFormat = SURVEY;
        if (format != nil && [format isEqualToString: @"survey_full"]) {
            surveyFormat = SURVEY_FULL;
        }
        
        [Gleap showSurvey: surveyId andFormat: surveyFormat];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)clearIdentity:(CDVInvokedUrlCommand *)command {
    @try {
        [Gleap clearIdentity];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)setTags:(CDVInvokedUrlCommand *)command {
    @try {
        NSArray* tags = [command.arguments objectAtIndex: 0];

        [Gleap setTags: tags];

        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)isUserIdentified:(CDVInvokedUrlCommand *)command {
    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: [Gleap isUserIdentified] ? @"true" : @"false"] callbackId:command.callbackId];
}

- (void)getIdentity:(CDVInvokedUrlCommand *)command {
    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary: [Gleap getIdentity]] callbackId:command.callbackId];
}

- (void)log:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* message = [command.arguments objectAtIndex: 0];
        NSString* logLevel = @"";
        
        if (command.arguments.count > 1) {
            logLevel = [command.arguments objectAtIndex: 1];
        }
        
        GleapLogLevel logLevelObj = INFO;
        if ([logLevel isEqualToString: @"ERROR"]) {
            logLevelObj = ERROR;
        }
        if ([logLevel isEqualToString: @"WARNING"]) {
            logLevelObj = WARNING;
        }
        
        [Gleap log: message withLogLevel: logLevelObj];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)preFillForm:(CDVInvokedUrlCommand *)command {
    @try {
        NSDictionary* data = [command.arguments objectAtIndex: 0];
        
        [Gleap preFillForm: data];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)identify:(CDVInvokedUrlCommand *)command {
    @try {
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
            if ([userData objectForKey: @"customData"]) {
                gleapUserData.customData = [userData objectForKey: @"customData"];
            }
        }
        
        if (userHash == nil) {
            [Gleap identifyUserWith: userId andData: gleapUserData];
        } else {
            [Gleap identifyUserWith: userId andData: gleapUserData andUserHash: userHash];
        }

        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)sendSilentCrashReport:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* description = [command.arguments objectAtIndex: 0];
        NSString* severity = [command.arguments objectAtIndex: 1];
        NSDictionary* excludeData = [command.arguments objectAtIndex: 2];
        
        GleapBugSeverity prio = MEDIUM;
        if ([severity isEqualToString: @"LOW"]) {
            prio = LOW;
        }
        if ([severity isEqualToString: @"HIGH"]) {
            prio = HIGH;
        }
        
        if (excludeData == nil || [excludeData isEqual: [NSNull null]]) {
            excludeData = [[NSDictionary alloc] init];
        }
        
        [Gleap sendSilentCrashReportWith: description andSeverity: prio andDataExclusion: excludeData andCompletion:^(bool success) {
            if (success) {
                [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
            } else {
                [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
            }
        }];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)setLanguage:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* language = [command.arguments objectAtIndex: 0];
        if (language != nil) {
            [Gleap setLanguage: language];
        }

        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)open:(CDVInvokedUrlCommand *)command {
    [Gleap open];
    
    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)setDisableInAppNotifications:(CDVInvokedUrlCommand *)command {
    @try {
        bool disableInAppNotifications = [[command.arguments objectAtIndex: 0] boolValue];

        [Gleap setDisableInAppNotifications: disableInAppNotifications];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)openFeatureRequests:(CDVInvokedUrlCommand *)command {
    @try {
        bool showBackButton = [[command.arguments objectAtIndex: 0] boolValue];

        [Gleap openFeatureRequests: showBackButton];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)openChecklists:(CDVInvokedUrlCommand *)command {
    @try {
        bool showBackButton = [[command.arguments objectAtIndex: 0] boolValue];

        [Gleap openChecklists: showBackButton];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)openChecklist:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* checklistId = [command.arguments objectAtIndex: 0];
        bool showBackButton = [[command.arguments objectAtIndex: 1] boolValue];

        [Gleap openChecklist: checklistId andShowBackButton: showBackButton];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)startChecklist:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* outboundId = [command.arguments objectAtIndex: 0];
        bool showBackButton = [[command.arguments objectAtIndex: 1] boolValue];

        [Gleap startChecklist: outboundId andShowBackButton: showBackButton];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)openNews:(CDVInvokedUrlCommand *)command {
    @try {
        bool showBackButton = [[command.arguments objectAtIndex: 0] boolValue];

        [Gleap openNews: showBackButton];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)openNewsArticle:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* articleId = [command.arguments objectAtIndex: 0];
        bool showBackButton = [[command.arguments objectAtIndex: 1] boolValue];

        [Gleap openNewsArticle: articleId andShowBackButton: showBackButton];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)openHelpCenter:(CDVInvokedUrlCommand *)command {
    @try {
        bool showBackButton = [[command.arguments objectAtIndex: 0] boolValue];

        [Gleap openHelpCenter: showBackButton];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)openHelpCenterArticle:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* articleId = [command.arguments objectAtIndex: 0];
        bool showBackButton = [[command.arguments objectAtIndex: 1] boolValue];

        [Gleap openHelpCenterArticle: articleId andShowBackButton: showBackButton];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)openHelpCenterCollection:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* collectionId = [command.arguments objectAtIndex: 0];
        bool showBackButton = [[command.arguments objectAtIndex: 1] boolValue];

        [Gleap openHelpCenterCollection: collectionId andShowBackButton: showBackButton];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)searchHelpCenter:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* term = [command.arguments objectAtIndex: 0];
        bool showBackButton = [[command.arguments objectAtIndex: 1] boolValue];

        [Gleap searchHelpCenter: term andShowBackButton: showBackButton];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)close:(CDVInvokedUrlCommand *)command {
    [Gleap close];
    
    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)isOpened:(CDVInvokedUrlCommand *)command {
    [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString: [Gleap isOpened] ? @"true" : @"false"] callbackId:command.callbackId];
}

- (void)trackEvent:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* name = [command.arguments objectAtIndex: 0];
        NSDictionary* data = [command.arguments objectAtIndex: 1];
        if (name != nil) {
            if (data != nil) {
                [Gleap trackEvent: name withData: data];
            } else {
                [Gleap trackEvent: name];
            }
        }

        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)startBot:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* botId = [command.arguments objectAtIndex: 0];
        bool showBackButton = [[command.arguments objectAtIndex: 1] boolValue];
        if (botId != nil) {
            [Gleap startBot: botId showBackButton: showBackButton];
        }

        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)startFeedbackFlow:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* feedbackFlow = [command.arguments objectAtIndex: 0];
        bool showBackButton = [[command.arguments objectAtIndex: 1] boolValue];
        if (feedbackFlow != nil) {
            [Gleap startFeedbackFlow: feedbackFlow showBackButton: showBackButton];
        }

        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)showFeedbackButton:(CDVInvokedUrlCommand *)command {
    @try {
        bool showBackButton = [[command.arguments objectAtIndex: 0] boolValue];
        
        [Gleap showFeedbackButton: showBackButton];
        
        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)attachCustomData:(CDVInvokedUrlCommand *)command {
    @try {
        NSDictionary* customData = [command.arguments objectAtIndex: 0];
        if (customData != nil) {
            [Gleap attachCustomData: customData];
        }

        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)setCustomData:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* key = [command.arguments objectAtIndex: 0];
        NSString* value = [command.arguments objectAtIndex: 1];
        if (key != nil && value != nil) {
            [Gleap setCustomData: value forKey: key];
        }

        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
}

- (void)removeCustomData:(CDVInvokedUrlCommand *)command {
    @try {
        NSString* key = [command.arguments objectAtIndex: 0];
        if (key != nil) {
            [Gleap removeCustomDataForKey: key];
        }

        [self.commandDelegate sendPluginResult: [CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }
    @catch (NSException *exception) {
        NSLog(@"GleapPlugin: Wrong arguments passed.");
    }
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
