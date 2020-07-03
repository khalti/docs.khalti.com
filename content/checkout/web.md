# Web SDK

[![npm](https://img.shields.io/badge/npm-v2.0.5-blue.svg)](https://www.npmjs.com/package/khalti-checkout-web)

This documentation details the process of Khalti Web/JavaScript SDK
integration in your website/app. We also have SDKs for Android and iOS.

## Demo

To get the feel of how Khalti checkout looks click the button below.

<button id="payment-button" style="background-color: #773292; cursor: pointer; color: #fff; border: none; padding: 5px 10px; border-radius: 2px">Pay with Khalti</button>


## Installation

Khalti checkout can be integrated with or without build tools like
[Webpack](https://github.com/webpack/webpack) and
[Rollup](https://github.com/rollup/rollup).


### Install Without build tools

```html
<html>
<head>
	<script src="https://unpkg.com/khalti-checkout-web@latest/dist/khalti-checkout.iffe.js"></script>
</head>
<body>
	...
	<!-- Place this where you need payment button -->
	<button id="payment-button">Pay with Khalti</button>
	<!-- Place this where you need payment button -->
	<!-- Paste this code anywhere in you body tag -->
	<script>
		var config = {
			// replace the publicKey with yours
			"publicKey": "test_public_key_dc74e0fd57cb46cd93832aee0a390234",
			"productIdentity": "1234567890",
			"productName": "Dragon",
			"productUrl": "http://gameofthrones.wikia.com/wiki/Dragons",
			"paymentPreference": [
				"MOBILE_BANKING",
				"KHALTI",
				"EBANKING",
				"CONNECT_IPS",
				"SCT",
				],
			"eventHandler": {
				onSuccess (payload) {
					// hit merchant api for initiating verfication
					console.log(payload);
				},
				onError (error) {
					console.log(error);
				},
				onClose () {
					console.log('widget is closing');
				}
			}
		};

		var checkout = new KhaltiCheckout(config);
		var btn = document.getElementById("payment-button");
		btn.onclick = function () {
			// minimum transaction amount must be 10, i.e 1000 in paisa.
			checkout.show({amount: 1000});
		}
	</script>
	<!-- Paste this code anywhere in you body tag -->
	...
</body>
</html>
```

[Click here](#configuration) for details on config parameters.

### Install with build tools

Khalti checkout can be bundled with build tools like Webpack, Rollup, etc.

#### 1. Install `khalti-checkout-web`

##### Using yarn
`yarn add khalti-checkout-web`

##### Using npm
`npm install khalti-checkout-web --save`

#### 2. Import and use it in your desired component
```javascript
import KhaltiCheckout from "khalti-checkout-web";

let config = {
	// replace this key with yours
	"publicKey": "test_public_key_dc74e0fd57cb46cd93832aee0a390234",
	"productIdentity": "1234567890",
	"productName": "Drogon",
	"productUrl": "http://gameofthrones.com/buy/Dragons",
	"eventHandler": {
		onSuccess (payload) {
			// hit merchant api for initiating verfication
			console.log(payload);
		},
		// onError handler is optional
		onError (error) {
			// handle errors
			console.log(error);
		},
		onClose () {
			console.log('widget is closing');
		}
	},
	"paymentPreference": ["KHALTI", "EBANKING","MOBILE_BANKING", "CONNECT_IPS", "SCT"],
};

let checkout = new KhaltiCheckout(config);
let btn = document.getElementById("payment-button");
btn.onclick = function () {
	// minimum transaction amount must be 10, i.e 1000 in paisa.
	checkout.show({amount: 1000});
}
```

## API

- `KhaltiCheckout(configuration?)`

	This creates an instance of the `KhaltiCheckOut` class. The
	`configuration` argument is a JavaScript object. See
	[configuration](#configuration) for details on available
	configuration parameters.

- `show(configuration?)`

	- Displays the Khalti checkout widget.
	- Receives configuration as argument.
	- Provide amount and mobile to prefill the checkout widget field
	 > ```checkout.show({amount: 1000, mobile: 98XXXXXXXX})```
	- `mobile` is an optional field and expects Khalti Registered Number for wallet payment.

- `hide()`

	> Hide the widget.

## Configuration
Configuration is a Javascript object with following attributes.

|Key|Required|Type|Value|
|--|--|--|--|
|publickKey|true|string|Test or live public key which identifies the merchant.|
|amount|true|integer|Amount to pay ***in paisa***. Minimum transaction amount is 1000 paisa ie Rs 10|
|productIdentity|true|string|Unique product identifier at merchant.|
|productName|true|string|Name of product.|
|productUrl|false|string|Url of product.|
|eventHandler|true|object|It is a javascript object with three methods|
|mobile|false|integer|Mobile number of consumer.
|paymentPreference|false|array|If not provided all the payment options will be rendered. It is javascript array with these options ```"KHALTI", "EBANKING", "MOBILE_BANKING" "CONNECT_IPS", "SCT"```

>  1. `onSuccess`
	This method is called once a transaction is confirmed by a user.
	The success response is in the following format:

	{
		"idx": "8xmeJnNXfoVjCvGcZiiGe7",
		"amount": 1000,
		"mobile": "98XXXXX969",
		"product_identity": "1234567890",
		"product_name": "Dragon",
		"product_url": "http://gameofthrones.wikia.com/wiki/Dragons",
		"token": "QUao9cqFzxPgvWJNi9aKac"
	}

It receives transaction `idx` of transaction, `token`, `amount` and other (key/)values with payloads.
One should implement this method to initiate payment verification
at merchant which in turn will make verification request at Khalti.

Now you should **send these values to your server and call khalti server to verify the transaction**.
For documentation on verification follow this [link](./../api/verification.md).


>  2. `onError (optional)`
	This method is optional. If implemented, it will receive errors that occured during payment initiation and confirmation. Example error format for `Invalid Khalti PIN or Confirmation Code`:

The error response during initiation will be something like this:

```json
{
	"detail":"Mobile or pin invalid.",
	"tries_remaining":"2",
	"error_key":"validation_error"
}
```

The error response during confirmation will be somethig like this:

```json
{
	"action": "WALLET_PAYMENT_CONFIRM",
	"message": undefined,
	"payload": {
		"detail": "Confirmation code or transaction pin does not match."
	},
	"status_code": 400
}
```

>  3. `onClose (optional)`
		This method is also optional. If implemented, this method is called when `close icon(X)` of the widget is called.


**Additionally** Configuration also accepts attribute starting with `merchant_` that can be used to pass additional (meta) data.

- `merchant_name`: This is merchant name

- `merchant_extra`: This is extra data

The additional data starting with `merchant_` is returned in success response payload.

Check out the source for [Khalti checkout on Github](https://github.com/khalti/khalti-sdk-web).

Now, for server side integration check [Verification](/api/verification) and [Transaction](/api/transaction) api.



<script src="https://unpkg.com/khalti-checkout-web@latest/dist/khalti-checkout.iffe.js"></script>
<script>
        var config = {
            // replace the publicKey with yours
            "publicKey": "test_public_key_dc74e0fd57cb46cd93832aee0a507256",
            "productIdentity": "1234567890",
            "productName": "Dragon",
            "productUrl": "http://gameofthrones.wikia.com/wiki/Dragons",
            "eventHandler": {
                onSuccess (payload) {
                    // hit merchant api for initiating verfication
                    console.log(payload);
                },
                onError (error) {
                    console.log(error);
                },
                onClose () {
                	console.log('widget is closing');
                }
            },
						paymentPreference: ["KHALTI", "EBANKING","MOBILE_BANKING", "CONNECT_IPS", "SCT"],
        };

        var checkout = new KhaltiCheckout(config);
        var btn = document.getElementById("payment-button");
        btn.onclick = function () {
            checkout.show({amount: 1000});
        }
</script>
