package io.cordova.gleap;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import io.gleap.Gleap;
import io.gleap.GleapUser;
import io.gleap.GleapUserProperties;
import io.gleap.APPLICATIONTYPE;
import io.gleap.PrefillHelper;
import io.gleap.GleapLogLevel;

/**
 * This class echoes a string called from JavaScript.
 */
public class GleapPlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("initialize")) {
            String message = args.getString(0);
            this.initialize(message, callbackContext);
            return true;
        }
        if (action.equals("identify")) {
            this.identify(args);
            return true;
        }
        if (action.equals("setLanguage")) {
            String language = args.getString(0);
            this.setLanguage(language);
            return true;
        }
        if (action.equals("open")) {
            this.open();
            return true;
        }
        if (action.equals("showFeedbackButton")) {
            this.showFeedbackButton(args);
            return true;
        }
        if (action.equals("openNews")) {
            this.openNews(args);
            return true;
        }
        if (action.equals("openFeatureRequests")) {
            this.openFeatureRequests(args);
            return true;
        }
        if (action.equals("openNewsArticle")) {
            this.openNewsArticle(args);
            return true;
        }
        if (action.equals("openHelpCenter")) {
            this.openHelpCenter(args);
            return true;
        }
        if (action.equals("openHelpCenterArticle")) {
            this.openHelpCenterArticle(args);
            return true;
        }
        if (action.equals("openHelpCenterCollection")) {
            this.openHelpCenterCollection(args);
            return true;
        }
        if (action.equals("searchHelpCenter")) {
            this.searchHelpCenter(args);
            return true;
        }
        if (action.equals("sendSilentCrashReport")) {
            this.sendSilentCrashReport(args);
            return true;
        }
        if (action.equals("close")) {
            this.close();
            return true;
        }
        if (action.equals("isOpened")) {
            return this.isOpened(callbackContext);
        }
        if (action.equals("startFeedbackFlow")) {
            this.startFeedbackFlow(args);
            return true;
        }
        if (action.equals("trackEvent")) {
            this.trackEvent(args);
            return true;
        }
        if (action.equals("attachCustomData")) {
            this.attachCustomData(args);
            return true;
        }
        if (action.equals("setCustomData")) {
            this.setCustomData(args);
            return true;
        }
        if (action.equals("clearIdentity")) {
            this.clearIdentity();
            return true;
        }
        if (action.equals("removeCustomData")) {
            this.removeCustomData(args);
            return true;
        }
        if (action.equals("log")) {
            this.log(args);
            return true;
        }
        if (action.equals("preFillForm")) {
            this.preFillForm(args);
            return true;
        }
        if (action.equals("clearCustomData")) {
            this.clearCustomData();
            return true;
        }
        if (action.equals("enableDebugConsoleLog")) {
            this.enableDebugConsoleLog();
            return true;
        }
        if (action.equals("getIdentity")) {
            this.getIdentity(callbackContext);
            return true;
        }
        if (action.equals("isUserIdentified")) {
            this.isUserIdentified(callbackContext);
            return true;
        }
        return false;
    }

    private void initialize(String token, CallbackContext callbackContext) {
        if (token != null && token.length() > 0) {
            Gleap.initialize(token, this.cordova.getActivity().getApplication());
            Gleap.getInstance().setApplicationType(APPLICATIONTYPE.CORDOVA);
            callbackContext.success(token);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }

    private void preFillForm(JSONArray args) {
        try {
            JSONObject prefillData = args.getJSONObject(0);

            PrefillHelper.getInstancen().setPrefillData(prefillData);
        } catch (Exception ex) {
        }
    }

    private void identify(JSONArray args) {
        try {
            String userId = args.getString(0);
            JSONObject userData = args.getJSONObject(1);
            String userHash = args.getString(2);

            GleapUserProperties gleapUserProperties = new GleapUserProperties(userId);

            if (userData != null) {
                if (userData.has("email")) {
                    gleapUserProperties.setEmail(userData.getString("email"));
                }
                if (userData.has("phone")) {
                    gleapUserProperties.setPhoneNumber(userData.getString("phone"));
                }
                if (userData.has("value")) {
                    gleapUserProperties.setValue(Double.parseDouble(userData.getString("value")));
                }
                if (userData.has("name")) {
                    gleapUserProperties.setName(userData.getString("name"));
                }
                if (userData.has("customData")) {
                    gleapUserProperties.setCustomData(userData.getJSONObject("customData"));
                }
            }

            Gleap.getInstance().identifyUser("13", gleapUserProperties);
        } catch (Exception ex) {
        }
    }

    private void log(JSONArray args) {
        try {
            String message = args.getString(0);
            GleapLogLevel logLevelObj = GleapLogLevel.INFO;

            try {
                String logLevel = args.getString(1);
                if (logLevel != null && logLevel.equals("ERROR")) {
                    logLevelObj = GleapLogLevel.ERROR;
                }
                if (logLevel != null && logLevel.equals("WARNING")) {
                    logLevelObj = GleapLogLevel.WARNING;
                }
            } catch (Exception ex) {
            }

            Gleap.getInstance().log(message, logLevelObj);
        } catch (Exception ex) {
        }
    }

    private void setLanguage(String language) {
        Gleap.getInstance().setLanguage(language);
    }

    private void open() {
        Gleap.getInstance().open();
    }

    private void openFeatureRequests(JSONArray args) {
        try {
            Boolean showBackButton = args.getBoolean(0);

            Gleap.getInstance().openFeatureRequests(showBackButton);
        } catch (Exception ex) {
        }
    }

    private void openNews(JSONArray args) {
        try {
            Boolean showBackButton = args.getBoolean(0);

            Gleap.getInstance().openNews(showBackButton);
        } catch (Exception ex) {
        }
    }

    private void openNewsArticle(JSONArray args) {
        try {
            String articleId = args.getString(0);
            Boolean showBackButton = args.getBoolean(1);

            Gleap.getInstance().openNewsArticle(articleId, showBackButton);
        } catch (Exception ex) {
        }
    }

    private void openHelpCenter(JSONArray args) {
        try {
            Boolean showBackButton = args.getBoolean(0);

            Gleap.getInstance().openHelpCenter(showBackButton);
        } catch (Exception ex) {
        }
    }

    private void openHelpCenterArticle(JSONArray args) {
        try {
            String articleId = args.getString(0);
            Boolean showBackButton = args.getBoolean(1);

            Gleap.getInstance().openHelpCenterArticle(articleId, showBackButton);
        } catch (Exception ex) {
        }
    }

    private void openHelpCenterCollection(JSONArray args) {
        try {
            String collectionId = args.getString(0);
            Boolean showBackButton = args.getBoolean(1);

            Gleap.getInstance().openHelpCenterCollection(collectionId, showBackButton);
        } catch (Exception ex) {
        }
    }

    private void searchHelpCenter(JSONArray args) {
        try {
            String term = args.getString(0);
            Boolean showBackButton = args.getBoolean(1);

            Gleap.getInstance().searchHelpCenter(term, showBackButton);
        } catch (Exception ex) {
        }
    }

    private void clearIdentity() {
        Gleap.getInstance().clearIdentity();
    }

    private void getIdentity(CallbackContext callbackContext) {
        JSONObject identityObj = new JSONObject();

        try {
            GleapUser gleapUser = Gleap.getInstance().getIdentity();
            if (gleapUser != null) {
                GleapUserProperties userProps = gleapUser.getGleapUserProperties();

                if (userProps != null) {
                    identityObj.put("userId", gleapUser.getUserId());
                    identityObj.put("phone", userProps.getPhoneNumber());
                    identityObj.put("email", userProps.getEmail());
                    identityObj.put("name", userProps.getName());
                    identityObj.put("value", userProps.getValue());
                }
            }
        } catch (Exception ex) {}

        callbackContext.success(identityObj);
    }

    private void isUserIdentified(CallbackContext callbackContext) {
        callbackContext.success(Gleap.getInstance().isUserIdentified() ? 1 : 0);
    }

    private void sendSilentCrashReport(JSONArray args) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {

                try {
                    String description = args.getString(0);
                    Gleap.SEVERITY severity = Gleap.SEVERITY.MEDIUM;
                    if (args.getString(1) == "LOW") {
                        severity = Gleap.SEVERITY.LOW;
                    }
                    if (args.getString(1) == "HIGH") {
                        severity = Gleap.SEVERITY.HIGH;
                    }

                    JSONObject exclude = args.getJSONObject(2);
                    if (exclude == null) {
                        exclude = new JSONObject();
                    }

                    Gleap.getInstance().sendSilentCrashReport(description, severity,
                            exclude);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        });
    }

    private void close() {
        Gleap.getInstance().close();
    }

    private boolean isOpened(CallbackContext callbackContext) {
        callbackContext.success(Gleap.getInstance().isOpened() ? 1 : 0);
        return true;
    }

    private void showFeedbackButton(JSONArray args) {
        try {
            Boolean show = args.getBoolean(0);
            Gleap.getInstance().showFeedbackButton(show);
        } catch (Exception ex) {
        }
    }

    private void startFeedbackFlow(JSONArray args) {
        try {
            String feedbackFlow = args.getString(0);
            Boolean showBackButton = args.getBoolean(1);
            Gleap.getInstance().startFeedbackFlow(feedbackFlow, showBackButton);
        } catch (Exception ex) {
        }
    }

    private void trackEvent(JSONArray args) {
        try {
            String name = args.getString(0);
            JSONObject data = args.getJSONObject(1);

            if (data != null) {
                Gleap.getInstance().trackEvent(name, data);
            } else {
                Gleap.getInstance().trackEvent(name);
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    private void attachCustomData(JSONArray args) {
        try {
            JSONObject data = args.getJSONObject(0);
            Gleap.getInstance().attachCustomData(data);
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    private void setCustomData(JSONArray args) {
        try {
            String key = args.getString(0);
            String value = args.getString(1);
            Gleap.getInstance().setCustomData(key, value);
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    private void removeCustomData(JSONArray args) {
        try {
            String key = args.getString(0);
            Gleap.getInstance().removeCustomDataForKey(key);
        } catch (Exception ex) {
        }
    }

    private void clearCustomData() {
        Gleap.getInstance().clearCustomData();
    }

    private void enableDebugConsoleLog() {
    }
}
