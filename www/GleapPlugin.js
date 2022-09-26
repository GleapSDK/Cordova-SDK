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
