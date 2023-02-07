var exec = require('cordova/exec');

exports.initialize = function (token, success, error) {
    exec(success, error, 'GleapPlugin', 'initialize', [token]);
};

exports.log = function (message, logLevel, success, error) {
    exec(success, error, 'GleapPlugin', 'log', [message, logLevel]);
};

exports.identify = function (userId, userData, userHash, success, error) {
    exec(success, error, 'GleapPlugin', 'identify', [userId, userData, userHash]);
};

exports.clearIdentity = function (success, error) {
    exec(success, error, 'GleapPlugin', 'clearIdentity', []);
};

exports.showFeedbackButton = function (show, success, error) {
    exec(success, error, 'GleapPlugin', 'showFeedbackButton', [show]);
};

exports.setLanguage = function (language, success, error) {
    exec(success, error, 'GleapPlugin', 'setLanguage', [language]);
};

exports.open = function (success, error) {
    exec(success, error, 'GleapPlugin', 'open', []);
};

exports.setTags = function (tags, success, error) {
    exec(success, error, 'GleapPlugin', 'setTags', [tags]);
};

exports.openNews = function (showBackButton, success, error) {
    exec(success, error, 'GleapPlugin', 'openNews', [showBackButton]);
};

exports.setDisableInAppNotifications = function (disableInAppNotifications, success, error) {
    exec(success, error, 'GleapPlugin', 'setDisableInAppNotifications', [disableInAppNotifications]);
};

exports.showSurvey = function (surveyId, format, success, error) {
    exec(success, error, 'GleapPlugin', 'showSurvey', [surveyId, format]);
};

exports.openNewsArticle = function (articleId, showBackButton, success, error) {
    exec(success, error, 'GleapPlugin', 'openNewsArticle', [articleId, showBackButton]);
};

exports.openFeatureRequests = function (showBackButton, success, error) {
    exec(success, error, 'GleapPlugin', 'openFeatureRequests', [showBackButton]);
};

exports.openHelpCenter = function (showBackButton, success, error) {
    exec(success, error, 'GleapPlugin', 'openHelpCenter', [showBackButton]);
};

exports.openHelpCenterArticle = function (articleId, showBackButton, success, error) {
    exec(success, error, 'GleapPlugin', 'openHelpCenterArticle', [articleId, showBackButton]);
};

exports.openHelpCenterCollection = function (collectionId, showBackButton, success, error) {
    exec(success, error, 'GleapPlugin', 'openHelpCenterCollection', [collectionId, showBackButton]);
};

exports.searchHelpCenter = function (term, showBackButton, success, error) {
    exec(success, error, 'GleapPlugin', 'searchHelpCenter', [term, showBackButton]);
};

exports.sendSilentCrashReport = function (description, severity, excludeData, success, error) {
    exec(success, error, 'GleapPlugin', 'sendSilentCrashReport', [description, severity, excludeData]);
};

exports.close = function (success, error) {
    exec(success, error, 'GleapPlugin', 'close', []);
};

exports.isOpened = function (success, error) {
    exec(success, error, 'GleapPlugin', 'isOpened', []);
};

exports.startFeedbackFlow = function (feedbackFlow, showBackButton, success, error) {
    exec(success, error, 'GleapPlugin', 'startFeedbackFlow', [feedbackFlow, showBackButton]);
};

exports.trackPage = function (pageName, success, error) {
    exec(success, error, 'GleapPlugin', 'trackEvent', ["pageView", {
        page: pageName,
    }]);
};

exports.trackEvent = function (name, data, success, error) {
    exec(success, error, 'GleapPlugin', 'trackEvent', [name, data]);
};

exports.attachCustomData = function (data, success, error) {
    exec(success, error, 'GleapPlugin', 'attachCustomData', [data]);
};

exports.setCustomData = function (key, value, success, error) {
    exec(success, error, 'GleapPlugin', 'setCustomData', [key, value]);
};

exports.removeCustomData = function (key, success, error) {
    exec(success, error, 'GleapPlugin', 'removeCustomData', [key]);
};

exports.clearCustomData = function (success, error) {
    exec(success, error, 'GleapPlugin', 'clearCustomData', []);
};

exports.enableDebugConsoleLog = function (success, error) {
    exec(success, error, 'GleapPlugin', 'enableDebugConsoleLog', []);
};

exports.preFillForm = function (data, success, error) {
    exec(success, error, 'GleapPlugin', 'preFillForm', [data]);
};

exports.getIdentity = function (success, error) {
    exec(success, error, 'GleapPlugin', 'getIdentity', []);
};

exports.isUserIdentified = function (success, error) {
    exec(success, error, 'GleapPlugin', 'isUserIdentified', []);
};
