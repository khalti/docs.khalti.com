[<img width="302.6" height="115" src="https://d7vw40z4bofef.cloudfront.net/static/2.69.07-web19/images/khalti-logo.svg"/>](https://khalti.com/)

# Khalti Android SDK

![Maven Central](https://img.shields.io/maven-central/v/com.khalti/khalti-android?color=%235C2D91)

Welcome to Khalti's checkout documentation
### Installation

#### Requirements

- Android 5.0 and above
- AndroidX (as of v2.00.00)
- Android Studio 3 and above
#### Quick Note
- We've dropped support of Android 4 since version `2.01.00`
#### Configuration

Add `khalti-android` to your `build.gradle` dependencies

```
implementation ('com.khalti:khalti-android:$latest_version') {
        transitive = true
    }
```

Also add the following lines inside the `android` block of your `build.gradle` file

```
compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
   }
```

#### Fetching `pidx`

Please go through the <a target="_blank" href="https://docs.khalti.com/khalti-epayment/#initiating-a-payment-request">Initiating a Payment request</a> to learn how to request the `pidx`
#### Setup

##### Building Config

Create an instance of `KhaltiPayConfig` with `publicKey`, `pidx`,  `returnUrl`, `environment` as parameters.

```kotlin
val config = KhaltiPayConfig(  
	publicKey = "<your_public_key>",  
	pidx = "<your_pidx>",  
	returnUrl = Uri.parse("your_return_url"),  
	environment = Environment.TEST  
)
```

> Note : `environment` has 2 options; `Environment.prod` & `Environment.Test`

##### Building Khalti

Create an instance of `Khalti`, using `init` function, with the above `config` as parameter along with the callbacks `onPaymentResult`, `onMessage` and `onReturn`. Here, `onReturn` is optional and can be skipped.

```kotlin
	Khalti.init(  
	    LocalContext.current,  // context
	    config,  
	    onPaymentResult = { paymentResult, khalti ->  
		     // your implementation here     
	    },  
	    onMessage = { payload, khalti ->  
		     // your implementation here     
	    },  
	    onReturn = { khalti ->  
		     // your implementation here     
	    }  
	)
```

> Note : Make sure the context you passed to `Khalti` can be used to open an activity.

##### Callbacks

| Callback                                                 | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| :------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `onPaymentResult(result: PaymentResult, khalti: Khalti)` | Invoked on completion of payment. Inside this callback you'll have access to `PaymentResult` object and `Khalti` object<br><br>After completion of payment process, `khalti` will internally trigger the verification API. It's result is then propagated through the `onPaymentResult` callback. You'll receive an object of `PaymentResult`.<br>                                                                                                                               |
| `onMessage(payload: OnMessagePayload, khalti: Khalti)`   | Invoked on failures and exceptions at any point of time. Inside this callback you'll have access to `OnMessagePayload` and `Khalti` object<br><br>`OnMessagePalyload` contains `onMessageEvent` that dictates what type of event triggered the callback. It also contains a flag `needsPaymentConfirmation` which if `true` indicates that you must verify the status of the payment. It can be done through the `Khalti` object passed to this callback. Use `khalti.verify()`. |
| `onReturn(khalti: Khalti)`                               | This is an optional callback that is invoked when `return_url`'s page is successfully loaded. Inside this callback you'll have access to `Khalti` object                                                                                                                                                                                                                                                                                                                         |
##### Schema

```
PaymentResult {
	status: String,
	payload: PaymentPayload,
}
```

```
PaymentPayload {
	pidx: String,
	totalAmount: Long,
	status: String,
	transactionId: String,
	fee: Long,
	refunded: Boolean
}
```

```
OnMessagePayload {
	event: OnMessageEvent,
	message: String,
	throwable: Throwable,
	code: Number,
	needsPaymentConfirmation: Boolean
}
```

```
OnMessageEvent {
	BackPressed, ReturnUrlLoadFailure, NetworkFailure, PaymentLookUpFailure, Unknown
}
```
#### Public functions in `Khalti`

| Function                                                               | Description                                                                                                                                                                                                                                                                                                                                                                    |
| :--------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `init(Context, KhaltiPayConfig, OnPaymentResult, OnMessage, OnReturn)` | Creates an instance of `Khalti`. Use this function to create an object of `Khalti`<br><br>`val khalti = Khalti.init()`                                                                                                                                                                                                                                                         |
| `open()`                                                               | Opens the payment page. After creating an object of `Khalti`. Use the said object to open the payment page.<br><br>`khalti.open()`                                                                                                                                                                                                                                             |
| `verify()`                                                             | Looks up of the payment status. `Khalti` sdk internally verifies the status of the payment, but if required the status lookup can be triggered again. The result is propagated through the callbacks passed during `init()`.  Use this function to confirm the payment status if and when `needsPaymentConfirmation` is `true` in `OnMessagePayload`.<br><br>`khalti.verify()` |
| `close()`                                                              | Closes the payment page. `Khalti` does not closes the payment page and it's sole responsibility lies on the merchant. Use this function to close the payment page when required.<br><br>`khalti.close()`                                                                                                                                                                       |

#### Sample Implementations

##### Method 1: With `onReturn`

Initialize the `Khalti` Object

```kotlin
val khalti = Khalti.init(  
    LocalContext.current,  
    KhaltiPayConfig(  
        publicKey = "<public_key>",  
        pidx = "<pidx>",  
        returnUrl = Uri.parse("<return_url>"),  
        environment = Environment.TEST // Or Environment.Prod for production  
    ),  
    onPaymentResult = { paymentResult, khalti ->  
        // Your implementation  
    },  
    onMessage = { payload, khalti ->  
        // Your implementation  
    },  
    onReturn = { khalti ->  
        // Your implementation  
    } 
)
```

##### Method 2: Without `onReturn`

Initialize the `Khalti` Object

```kotlin
val khalti = Khalti.init(  
    LocalContext.current,  
    KhaltiPayConfig(  
        publicKey = "<public_key>",  
        pidx = "<pidx>",  
        returnUrl = Uri.parse("<return_url>"),  
        environment = Environment.TEST // Or Environment.Prod for production  
    ),  
    onPaymentResult = { paymentResult, khalti ->  
        // Your implementation  
    },  
    onMessage = { payload, khalti ->  
        // Your implementation  
    } 
)
```

Use `khalti.open()`, `khalti.verify()`, `khalti.close()` wherever appropriate.

Check out the source for <a target="_blank" href="https://github.com/khalti/checkout-sdk-android">Khalti checkout on Github</a>.
#### <a href="https://github.com/khalti/khalti-sdk-android/blob/master/CHANGELOG.md" target="_blank">Changelog</a>