# Khalti Flutter SDK
Khalti Payment Gateway SDK for Flutter with default payment interface, works out of the box without having to add any additional user interface.

---

<p align="center">
<img width="302.6" height="115" src="https://raw.githubusercontent.com/khalti/checkout-sdk-flutter/main/assets/khalti_logo.png" height="100" alt="Khalti Payment Gateway" />
</p>

<p align="center">
<strong>Khalti Payment Gateway for Flutter</strong>
</p>

<p align="center">
<a href="https://pub.dartlang.org/packages/khalti_checkout_flutter"><img src="https://img.shields.io/pub/v/khalti_checkout_flutter.svg" alt="Pub"></a>
<a href="https://docs.khalti.com/"><img src="https://img.shields.io/badge/Khalti-Docs-blueviolet" alt="Khalti Docs"></a>
<a href="https://github.com/khalti/checkout-sdk-flutter/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-BSD--3-informational" alt="BSD-3 License"></a>
<a href="https://github.com/khalti/checkout-sdk-flutter/issues"><img src="https://img.shields.io/github/issues/khalti/checkout-sdk-flutter" alt="GitHub issues"></a>
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
!!! tip

    A merchant account is required for integration.

!!! info "Access Information"

    > **For Sandbox Access**

    Signup from 
    [here](https://test-admin.khalti.com/#/join/merchant) as a merchant.

    Please use 987654 as login OTP for sandbox env.
    
    > **For Production Access**

    Please visit [here](https://admin.khalti.com)
    
!!! info "Test Credentials for sandbox environment"

    > **Test Khalti ID for**
    9800000000
    9800000001
    9800000002
    9800000003
    9800000004
    9800000005
    
    > **Test MPIN**
    1111
    
    > **Test OTP**
    987654

Read the steps to integrate Khalti Payment Gateway in details [here](https://docs.khalti.com/getting-started/).

## Supported Platforms
Android | iOS | Web | Desktop (macOS, Linux, Windows)
:-----: | :-: | :-: | :-----------------------------:
  ✔️    |  ✔️ |  ❌ |                ❌

## Setup
Detailed setup for each platform.

- ### Android
No configuration is required for android.

- ### iOS
No configuration is required for iOS.

## Launching Payment Interface

### Generating the pidx
A unique product identifier `pidx` must be generated via a server side POST request before being able to proceed. Read [here](https://docs.khalti.com/khalti-epayment/#initiating-a-payment-request) for information on how one can generate pidx along with other extra parameters.

### Khalti Initialization
Before being able to launch Khalti payment gateway, it is necessary to initialize `Khalti` object. The initialization can be done by a static `init()` method.

It is suggested that the initialization be done inside the `initState` method of a `StatefulWidget`.

```dart
class KhaltiSDKDemo extends StatefulWidget {
  const KhaltiSDKDemo({super.key});

  @override
  State<KhaltiSDKDemo> createState() => _KhaltiSDKDemoState();
}

class _KhaltiSDKDemoState extends State<KhaltiSDKDemo> {
  late final Future<Khalti> khalti;

  @override
  void initState() {
    super.initState();
    final payConfig = KhaltiPayConfig(
      publicKey: '__live_public_key__', // Merchant's public key
      pidx: pidx, // This should be generated via a server side POST request.
      returnUrl: Uri.parse('https://your_return_url'),
      environment: Environment.prod,
    );

    khalti = Khalti.init(
      enableDebugging: true,
      payConfig: payConfig,
      onPaymentResult: (paymentResult, khalti) {
        log(paymentResult.toString());
      },
      onMessage: (
        khalti, {
        description,
        statusCode,
        event,
        needsPaymentConfirmation,
      }) async {
        log(
          'Description: $description, Status Code: $statusCode, Event: $event, NeedsPaymentConfirmation: $needsPaymentConfirmation',
        );
      },
      onReturn: () => log('Successfully redirected to return_url.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Rest of the code
  }
}
```

The static `init()` method takes in a few arguments:

- **enableDebugging**: A boolean argument that is when set to true can be used to view network logs in the debug console. It is set to `false` by default.
- **payConfig**: An instance of `KhaltiPayConfig()`. It is used to set few config data. The instance of `KhaltiPayConfig` takes in few arguments:

    ```dart
    final payConfig = KhaltiPayConfig(
      publicKey: '__live_public_key__', // Merchant's public key
      pidx: pidx, // This should be generated via a server side POST request.
      returnUrl: Uri.parse('https://your_return_url'),
      environment: Environment.prod,
    );
    ```
  
    - **publicKey**: Merchant's live or test public key provided by Khalti.
    - **pidx**: Unique product identifier received after initiating the payment via a server-side POST request.
    - **returnUrl**: Merchant's URL where the user must be redirected after the payment is successfully or unsuccessfully made. This value should correspond to the `return_url` specified during the initiation of the payment through a server-side POST request.
    - **environment**: An enum that determines whether test API or production API should be invoked. Can be either `Environment.prod` or `Environment.test`. Set to `Environment.prod` by default.

- **onPaymentResult**: A callback function that is triggered if the payment is successfully made and redirected to merchant's return URL. The callback takes in two arguments.
    - **paymentResult**: An instance of `PaymentResult` class. It provides some informations about the payment after it is successfully made. Following data is provided by this instance.
        - **status**: A string representing the status of the payment.
        - **payload**: An instance of `PaymentPayload`. It contains general informations such as `pidx`, `amount` and `transactionId` regarding the payment made. 
    - **khalti**: An instance of `Khalti`. Can be used to invoke any methods provided by this instance.

    ```dart
    onPaymentResult(paymentResult, khalti) {
      print(paymentResult.status);
      print(paymentResult.payload.pidx);
      print(paymentResult.payload.amount);
      print(paymentResult.payload.transactionId);
    }
    ```
  
- **onReturn**: A callback function that gets triggered when the return_url is successfully loaded.

- **onMessage**: A callback function that is triggered to convey any message. It gets triggered when any issue is encountered or when any general message is to be conveyed. In case of error, this callback provides error informations such as error description and status code. It also provides information about why the error occured via `KhaltiEvent` enum. This enum consists of:
  
    ```dart
    enum KhaltiEvent {
      /// Event for when khalti payment page is disposed.
      kpgDisposed,

      /// Event for when return url fails to load.
      returnUrlLoadFailure,

      /// Event for when there's an exception when making a network call.
      networkFailure,

      /// Event for when there's a HTTP failure when making a network call.
      paymentLookupfailure,

      /// An unknown event.
      unknown
    }
    ```
  Additionally, it also provides a bool `needsPaymentConfirmation` which needs to be checked. If it is true, developers should invoke payment confirmation API that is provided by the SDK to confirm the status of their payment. The callback also provides the instance of `Khalti`.

    ```dart
    onMessage: (
      khalti, {
      description,
      statusCode,
      event,
      needsPaymentConfirmation,
    }) {
      log('Description: $description, Status Code: $statusCode, Event: $event, NeedsPaymentConfirmation: $needsPaymentConfirmation');
    }
    ```

### Loading payment interface
The SDK internally uses [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview) to load the khalti payment gateway. SDK users should invoke `open()` method provided by the SDK to push a new page in their route.

```dart
khalti.open(context); // Assuming that khalti is a variable that holds the instance of `Khalti`.
```

## Payment verification API
A payment verification API that confirms the status of the payment made, is already called by the SDK internally. However, if the users receive `needsPaymentConfirmation` as true in `onMessage` callback, they are supposed to called the payment verification API manually to be sure about the payment status. It can be done with a method provided by the `Khalti` instance.

```dart
await khalti.verify(); // Assuming that khalti is a variable that holds the instance of `Khalti`.
```

The instance of `Khalti` is provided in the `onPaymentResult` and `onMessage` callback which can be used to invoke any public functions provide by `Khalti` class.

## Closing the Khalti payment gateway page
After payment is successfully made, developers can opt to pop the page that was pushed in their route. The SDK provides a `close()` method.

```dart
khalti.close(context);
```

## Example
For a more detailed example, check the [examples](https://github.com/khalti/checkout-sdk-flutter/tree/main/packages/khalti_checkout_flutter/example) directory inside `khalti_flutter` package.


#### <a href="https://github.com/khalti/checkout-sdk-flutter/blob/main/packages/khalti_checkout_flutter/CHANGELOG.md" target="_blank">Changelog</a>
