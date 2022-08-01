# Gleap Cordova SDK

![Gleap Cordova SDK Intro](https://raw.githubusercontent.com/GleapSDK/Gleap-iOS-SDK/main/Resources/GleapHeaderImage.png)

The Gleap SDK for Cordova is the easiest way to integrate Gleap into your apps! Achieve better app quality with comprehensive in-app bug reporting & customer feedback for your web-apps and websites.

## 📖 Docs & Examples

Checkout our [documentation](https://www.gleap.io/docs/cordova) for full reference.

## 🚀 Getting started

The Gleap SDK for Cordova is the easiest way to integrate Gleap into your apps. Communicate with your users directly and build better software by discovering their everyday pain points. Gleap is your all-in-one customer feedback tool for apps and websites.

For the SDK to work, you need an API key, which you can get for free at [app.gleap.io](https://app.gleap.io).

## 🏗 Installation

Install the **Gleap** package via the cordova CLI.

```js
cordova plugin add cordova-plugin-gleap
```

Initialize the Gleap SDK on device ready.

```js
function onDeviceReady() {
    // Cordova is now initialized.
    // Initialize the Gleap SDK & have fun!
    cordova.plugins.GleapPlugin.initialize("YOUR_API_KEY");
}
```

The Gleap Cordova plugin works for both **Android** and **iOS**.

Congrats, you are now all set! Report your first bug by using the feedback button.

## 🤝 Need help?

We are here to help! hello@gleap.io
