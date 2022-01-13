# Khalti Flutter SDK (with Payment Interface)
Khalti Payment Gateway SDK for Flutter with default payment interface, works out of the box without having to add any additional user interface.

---

<p align="center">
<img src="https://raw.githubusercontent.com/khalti/khalti-flutter-sdk/master/assets/khalti_logo.png" height="100" alt="Khalti Payment Gateway" />
</p>

<p align="center">
<strong>Khalti Payment Gateway for Flutter</strong>
</p>

<p align="center">
<a href="https://pub.dartlang.org/packages/khalti_flutter"><img src="https://img.shields.io/pub/v/khalti_flutter.svg" alt="Pub"></a>
<a href="https://docs.khalti.com/"><img src="https://img.shields.io/badge/Khalti-Docs-blueviolet" alt="Khalti Docs"></a>
<a href="https://github.com/khalti/khalti-flutter-sdk/blob/master/LICENSE"><img src="https://img.shields.io/badge/License-BSD--3-informational" alt="BSD-3 License"></a>
<a href="https://github.com/khalti/khalti-flutter-sdk/issues"><img src="https://img.shields.io/github/issues/khalti/khalti-flutter-sdk" alt="GitHub issues"></a>
<a href="https://khalti.com"><img src="https://img.shields.io/website?url=https%3A%2F%2Fdocs.khalti.com" alt="Website"></a>
<a href="https://www.facebook.com/khalti.official"><img src="https://img.shields.io/badge/follow--000?style=social&logo=facebook" alt="Follow Khalti in Facebook"></a>
<a href="https://www.instagram.com/khaltiofficial"><img src="https://img.shields.io/badge/follow--000?style=social&logo=instagram" alt="Follow Khalti in Instagram"></a>
<a href="https://twitter.com/intent/follow?screen_name=khaltiofficial"><img src="https://img.shields.io/twitter/follow/khaltiofficial?style=social" alt="Follow Khalti in Twitter"></a>
<a href="https://www.youtube.com/channel/UCrXM4HqK9th3E2a04Z9Lh-Q"><img src="https://img.shields.io/youtube/channel/subscribers/UCrXM4HqK9th3E2a04Z9Lh-Q?label=Subscribe&style=social" alt="Subscribe Youtube Channel"></a>
</p>

---

## Introduction
Read the introduction [here](https://docs.khalti.com/).

## Getting Started
Integrating Khalti Payment Gateway requires merchant account.
You can always [create one easily from here](https://khalti.com/join/merchant/#/).

Read the steps to integrate Khalti Payment Gateway in details [here](https://docs.khalti.com/getting-started/).

## Supported Platforms
Payment Method | Android | iOS | Web | Desktop (macOS, Linux, Windows)
-------------- | :-----: | :-: | :-: | :-----------------------------:
Khalti Wallet  |    ✔️    |  ✔️  |  ✔️  |                ✔️
E-Banking      |    ✔️    |  ✔️  |  ✔️  |                ❌
Mobile Banking |    ✔️    |  ✔️  |  ✔️  |                ❌
Connect IPS    |    ✔️    |  ✔️  |  ✔️  |                ❌
SCT            |    ✔️    |  ✔️  |  ✔️  |                ❌

## Migrating to 2.0
Version 1.0 had an issue where multiple app with the package integrated, could interfere with each other's deeplink.
Please follow the [new setup](#setup) after upgrading to 2.0 in order to fix the issue.

## Setup
Detailed setup for each platform.

### Android
In your app's `AndroidManifest.xml`, add these lines inside `<activity>...</activity>` tag:

```xml
<meta-data android:name="flutter_deeplinking_enabled" android:value="true" />
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="kpg" android:host="{your package name}" />
</intent-filter>
```

### iOS
In your app's `Info.plist`, add these properties:

```xml
<key>FlutterDeepLinkingEnabled</key>
<true/>
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>kpg</string>
        </array>
        <key>CFBundleURLName</key>
        <string>{your package name}</string>
    </dict>
</array>
```

### Web
No configuration is required for web.

### Desktop
No configuration is required for desktop.

## Initialization
Wrap the topmost widget of your app with **`KhaltiScope`** widget.
And add supported locales and `KhaltiLocalizations.delegate` as shown below.

### Navigator Approach
When using `MaterialApp` or siblings.

```dart
KhaltiScope(
  publicKey: <public-key>,
  builder: (context, navigatorKey) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ne', 'NP'),
      ],
      localizationsDelegates: const [
        KhaltiLocalizations.delegate,
        ...
      ],
      ...
    );  
  } 
);
```

### Router Approach
When using `MaterialApp.router` or siblings.

```dart
final routerDelegate = YourRouterDelegate();
KhaltiScope(
  publicKey: <public-key>,
  navigatorKey: routerDelegate.navigatorKey, 
  builder: (context, _) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ne', 'NP'),
      ],
      localizationsDelegates: const [
        KhaltiLocalizations.delegate,
        ...
      ],
      ...
    );  
  } 
);
```

## Launching Payment Interface
Khalti Payment interface can be launched in two ways:

### Using KhaltiButton
The plugin includes easy to use button to launch the payment interface. It can be used as shown below:

```dart
final config = PaymentConfig(
  amount: 10000, // Amount should be in paisa
  productIdentity: 'dell-g5-g5510-2021',
  productName: 'Dell G5 G5510 2021',
  productUrl: 'https://www.khalti.com/#/bazaar',
  additionalData: { // Not mandatory; can be used for reporting purpose
    'vendor': 'Khalti Bazaar',
  },
)
KhaltiButton(
  config: config,
  preferences: [ // Not providing this will enable all the payment methods.
    PaymentPreference.khalti,
    PaymentPreference.eBanking,
  ],
  onSuccess: (successModel) {
    // Perform Server Verification 
  },
  onFailure: (failureModel) {
    // What to do on failure?
  },
  onCancel: () {
    // User manually cancelled the transaction
  },
),
```

If you want to use only specific payment method then the following dedicated buttons can be used instead:
- **`KhaltiButton.wallet(...)`**
- **`KhaltiButton.eBanking(...)`**
- **`KhaltiButton.mBanking(...)`**
- **`KhaltiButton.connectIPS(...)`**
- **`KhaltiButton.sct(...)`**

### Manual Method
Another method to launch the payment interface is using `KhaltiScope.pay()` method:

```dart
Inkwell(
  onTap: () {
    KhaltiScope.of(context).pay(
      config: config,
      preferences: [
        PaymentPreference.connectIPS,
        PaymentPreference.eBanking,
        PaymentPreference.sct,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  },
  child: Text('Launch Payment Interface'),
);
```

## Customizing Return URL
Their might be a need to use custom `returnUrl`, specially in Web platform.

Passing a custom return url will result in data url, in following format after successful payment.
```
<returnUrl>/?<data>
```

e.g. Let's say you set a `returnUrl = 'https://example.com/test';`.
Then the data url will be `https://example.com/test/?key=value`.

A custom return url can be set in `PaymentConfig`:

```dart
final config = PaymentConfig(
  returnUrl: 'https://example.com/test',
  ...
);
```

## Customizing UI
This package doesn't support high level of customization as this is more of a plug & play package.

If a custom interface is required then [khalti](https://pub.dev/packages/khalti) package can be used.

## Example
Find more [detailed example here](https://github.com/khalti/khalti-flutter-sdk/tree/master/packages/khalti_flutter/example).

## Server Verification
After success from the client side payment, the next step is to perform server verification.

A server verification is required since the client side makes the payment directly to Khalti without going through your server first,
you need to be sure that the customer actually paid the money they were supposed to before completing their order.
This type of verification can only be done securely from the server.

Know [how to perform server verification here](https://docs.khalti.com/api/verification/).


## Contributing
Contributions are always welcome. Also, if you have any confusion, please feel free to create an issue.

### Internationalization
Steps to add support for new language
1. Create a new file for the language `khalti_localizations_<language-code>.dart` inside `localization` directory.
	 Let's say you want to add support for Nepali language, then the file should be `khalti_localizations_ne.dart`.

2. Copy contents of `khalti_localizations_en.dart` to the newly created file and rename the class accordingly.

3. Replace all the strings with the localized strings inside the file.

4. Add entry to `_localizations` map inside `khalti_localizations.dart`.
	 	```dart
		 const Map<String, KhaltiLocalizations> _localizations = {
			 'en': _KhaltiLocalizationsEn(),
			 'ne': _KhaltiLocalizationsNe(), // Newly added entry
		 };
		 ```

4. Submit a Pull Request with the changes. But ensure that the code changes are well formatted.
	 Format the generated code if needed: `flutter format .`

## Support
**For Queries, feel free to call us at:**

_**Contact Our Merchant Team**_
* Mobile (Viber / Whatsapp): 9801165567, 9801165538
* Email: merchant@khalti.com

(To integrate Khalti to your business and other online platforms.)

_**Contact Our Merchant Support**_
* Mobile (Viber / Whatsapp): 9801165565, 9801856383, 9801856451
* Email: merchantcare@khalti.com

_**Contact Our Technical Team**_
* Mobile (Viber / Whatsapp): 9843007232
* Email / Skype: sashant@khalti.com

(For payment gateway integration support.)

## License
```
Copyright (c) 2021 The Khalti Authors. All rights reserved.
Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Sparrow Pay Pvt. Ltd. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
