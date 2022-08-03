package io.cordova.gleap;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import io.gleap.Gleap;
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
        if (action.equals("sendSilentCrashReport")) {
            this.sendSilentCrashReport(args);
            return true;
        }
        if (action.equals("close")) {
            this.close();
            return true;
        }
        if (action.equals("isOpened")) {
            return this.isOpened();
        }
        if (action.equals("startFeedbackFlow")) {
            this.startFeedbackFlow(args);
            return true;
        }
        if (action.equals("logEvent")) {
            this.logEvent(args);
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

    private void clearIdentity() {
        Gleap.getInstance().clearIdentity();
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

    private boolean isOpened() {
        return Gleap.getInstance().isOpened();
    }

    private void startFeedbackFlow(JSONArray args) {
        try {
            String feedbackFlow = args.getString(0);
            Boolean showBackButton = args.getBoolean(0);
            Gleap.getInstance().startFeedbackFlow(feedbackFlow, showBackButton);
        } catch (Exception ex) {
        }
    }

    private void logEvent(JSONArray args) {
        try {
            String name = args.getString(0);
            JSONObject data = args.getJSONObject(1);

            if (data != null) {
                Gleap.getInstance().logEvent(name, data);
            } else {
                Gleap.getInstance().logEvent(name);
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
