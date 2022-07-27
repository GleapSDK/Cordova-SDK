package cordova-plugin-gleap;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import io.gleap.Gleap;

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
        return false;
    }

    private void initialize(String token, CallbackContext callbackContext) {
        if (token != null && token.length() > 0) {
            Gleap.initialize(token, this);

            callbackContext.success(token);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }
}
