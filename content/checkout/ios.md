# iOS SDK


<p align="center">
<img src="https://raw.githubusercontent.com/khalti/khalti-flutter-sdk/master/assets/khalti_logo.png" height="100" alt="Khalti Payment Gateway" />
</p>

<p align="center">
<strong>Khalti Payment Gateway</strong><br>
<small>iOS SDK</small>
</p>

<p align="center">
<a href="https://docs.khalti.com/"><img src="https://img.shields.io/badge/Khalti-Docs-blueviolet" alt="Khalti Docs"></a>
<a href="https://github.com/khalti/checkout-sdk-ios/blob/master/LICENSE"><img src="https://img.shields.io/badge/License-BSD--3-informational" alt="BSD-3 License"></a>
<a href="https://github.com/khalti/checkout-sdk-ios/issues"><img src="https://img.shields.io/github/issues/khalti/checkout-sdk-ios" alt="GitHub issues"></a>
<a href="https://khalti.com"><img src="https://img.shields.io/website?url=https%3A%2F%2Fdocs.khalti.com" alt="Website"></a>
<a href="https://github.com/khalti/checkout-sdk-ios/releases"><img alt="GitHub Release Date" src="https://img.shields.io/github/release-date/khalti/checkout-sdk-ios"></a>
<a href="https://www.facebook.com/khalti.official"><img src="https://img.shields.io/badge/follow--000?style=social&logo=facebook" alt="Follow Khalti in Facebook"></a>
<a href="https://www.instagram.com/khaltiofficial"><img src="https://img.shields.io/badge/follow--000?style=social&logo=instagram" alt="Follow Khalti in Instagram"></a>
<a href="https://twitter.com/intent/follow?screen_name=khaltiofficial"><img src="https://img.shields.io/twitter/follow/khaltiofficial?style=social" alt="Follow Khalti in Twitter"></a>
<a href="https://www.youtube.com/channel/UCrXM4HqK9th3E2a04Z9Lh-Q"><img src="https://img.shields.io/youtube/channel/subscribers/UCrXM4HqK9th3E2a04Z9Lh-Q?label=Subscribe&style=social" alt="Subscribe Youtube Channel"></a>
</p>

---
This documentation details the process to integrate Khalti payment gateway
in your iOS app.


## Example

**Swift** : Clone project and use 'Example' directory. Do 'pod install'.

**Objective-C** :  Clone project and use 'KhaltiCheckoutObjectiveC ' directory. Do 'pod install'.


## Example on how to change swift and objective c targets
![Targets](https://raw.githubusercontent.com/khalti/checkout-sdk-ios/master/Example/ScreenShots/targets.png)

Select Objectivec

Read the steps to integrate Khalti Payment Gateway in details [here](https://docs.khalti.com/getting-started/).


#### Tested on

- Xcode 15
- swift 5

## Installation guide

Khalti is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```swift
pod 'Khalti'
```

#### Fetching `pidx`

Please go through the <a target="_blank" href="https://docs.khalti.com/khalti-epayment/#initiating-a-payment-request">Initiating a Payment request</a> to learn how to request the `pidx`
#### Setup

> Note : `environment` has 2 options; `Environment.prod` & `Environment.Test`

##### Building Khalti

Create an instance of `Khalti`, using `init` function, with the above `config` as parameter along with the callbacks `onPaymentResult`, `onMessage` and `onReturn`. Here, `onReturn` is optional and can be skipped.

```swift
Khalti.init(config: KhaltiPayConfig(publicKey:"4aa1b684f4de4860968552558fc8487d", pIdx:"8mBsbuzGYDWveAZkMn4Q2F",environment:Environment.TEST), 
onPaymentResult: {[weak self] (paymentResult,khalti) in
        

}, onMessage: {[weak self](onMessageResult,khalti) in


}, onReturn: {(khalti) in
 // called when payment is success
})
```

##### Callbacks

| Callback                                                 | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| :------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `onPaymentResult(result: PaymentResult, khalti: Khalti)` | Invoked on completion of payment. Inside this callback you'll have access to `PaymentResult` object and `Khalti` object<br><br>After completion of payment process, `khalti` will internally trigger the verification API. It's result is then propagated through the `onPaymentResult` callback. You'll receive an object of `PaymentResult`.<br>                                                                                                                                                                                                                                                                                   |
| `onMessage(payload: OnMessagePayload, khalti: Khalti)`   | Invoked on failures, exceptions or to convey message at any point of time. Inside this callback you'll have access to `OnMessagePayload` and `Khalti` object<br><br>`OnMessagePayload` contains `onMessageEvent` that dictates what type of event triggered the callback. It also contains a flag `needsPaymentConfirmation` which if `true` indicates that you must verify the status of the payment. It can be done through the `Khalti` object passed to this callback. Use `khalti.verify()`.<br><br>`onMessage` should not be considered as an error by itself. Always consult the `OnMessageEvent` for further clarification. |
| `onReturn(khalti: Khalti)`                               | This is an optional callback that is invoked when `return_url`'s page is successfully loaded. Inside this callback you'll have access to `Khalti` object                                                                                                                                                                                                                                                                                                                                                                                                                                                                             


#### Public functions in `Khalti`

| Function                                                               | Description                                                                                                                                                                                                                                                                                                                                                                    |
| :--------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `init(Context, KhaltiPayConfig, OnPaymentResult, OnMessage, OnReturn)` | Creates an instance of `Khalti`. Use this function to create an object of `Khalti`<br><br>`val khalti = Khalti.init()`                                                                                                                                                                                                                                                         |
| `open()`                                                               | Opens the payment page. After creating an object of `Khalti`. Use the said object to open the payment page.<br><br>`khalti.open()`                                                                                                                                                                                                                                             |
| `verify()`                                                             | Looks up of the payment status. `Khalti` sdk internally verifies the status of the payment, but if required the status lookup can be triggered again. The result is propagated through the callbacks passed during `init()`.  Use this function to confirm the payment status if and when `needsPaymentConfirmation` is `true` in `OnMessagePayload`.<br><br>`khalti.verify()` |
| `close()`                                                              | Closes the payment page. `Khalti` does not close the payment page and it's sole responsibility lies on the merchant. Use this function to close the payment page when required.<br><br>`khalti.close()`                                                                                                                                                                        |

#### Sample Implementations

##### Method 1: With `onReturn`

Initialize the `Khalti` Object

```swift
 khalti = Khalti.init(config: KhaltiPayConfig(publicKey:"4aa1b684f4de4860968552558fc8487d", pIdx:"8mBsbuzGYDWveAZkMn4Q2F",environment:Environment.TEST), onPaymentResult: {[weak self] (paymentResult,khalti) in
        print("Demo | onPaymentResult", paymentResult)

}, onMessage: {[weak self](onMessageResult,khalti) in

        //Handle onMessage callback here
        //if needsPaymentConfiramtion true then verify payment status

 let shouldVerify = onMessageResult.needsPaymentConfirmation

         if shouldVerify {
          khalti?.verify()
         }else{
          khalti?.close()
         }


}, onReturn: {(khalti) in
 // called when payment is success
})
```

##### Method 2: Without `onReturn`

Initialize the `Khalti` Object

```swift
 khalti = Khalti.init(config: KhaltiPayConfig(publicKey:"4aa1b684f4de4860968552558fc8487d", pIdx:"8mBsbuzGYDWveAZkMn4Q2F",environment:Environment.TEST), onPaymentResult: {[weak self] (paymentResult,khalti) in
        print("Demo | onPaymentResult", paymentResult)

}, onMessage: {[weak self](onMessageResult,khalti) in

        //Handle onMessage callback here
        //if needsPaymentConfiramtion true then verify payment status

        let shouldVerify = onMessageResult.needsPaymentConfirmation

        if shouldVerify {
         khalti?.verify()
        }else{
         khalti?.close()
        }


})
```

Use `khalti.open()`, `khalti.verify()`, `khalti.close()` wherever appropriate.

Check out the source for <a target="_blank" href="https://github.com/khalti/checkout-sdk-ios">Khalti checkout on Github</a>.
#### <a href="https://github.com/khalti/checkout-sdk-ios/blob/master/CHANGELOG.md" target="_blank">Changelog</a>

For Queries, feel free to mail us at: [merchant@khalti.com](mailto:merchant@khalti.com?cc=ios@khalti.com,rajendrakarki@khalti.com,bikashgiri@khalti.com,developers@khalti.com,support@khalti.com)

<!-- Check out the source for Khalti checkout on [github ](https://github.com/khalti/khalti-sdk-ios/). -->
Check out the [API Documentation](http://docs.khalti.com/checkout/ios/).
