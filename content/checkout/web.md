Khalti checkout can be integrated with or without build tools like 
[Webpack](https://github.com/webpack/webpack) and [Rollup](https://github.com/rollup/rollup).

To get the feel of how Khalti checkout looks click the button below.

<button id="payment-button" style="background-color: #773292; color: #fff; border: none; padding: 5px 10px; border-radius: 2px">Pay with Khalti</button>

## Without build tools

```html
<html>
<head>
	<script src="https://khalti.com/static/khalti-checkout.js"></script>
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
			checkout.show({amount: 1000});
		}
	</script>
	<!-- Paste this code anywhere in you body tag -->
	...
</body>
</html>
```

[Click here](#configuration) for details on config parameters.

## With build tools
Khalti checkout can be bundled with build tools like Webpack, Rollup, etc.

### 1. Install `khalti-web`
#### Using yarn
`yarn add khalti-web`

#### Using npm
`npm install khalti-web --save`

### 2. Import and use it in your desired component
```javascript
import KhaltiCheckout from "khalti-web";

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
	}
};

let checkout = new KhaltiCheckout(config);
let btn = document.getElementById("payment-button");
btn.onclick = function () {
	checkout.show({amount: 1000});
}
```

## API

- `KhaltiCheckout(configuration?)`

	> Instantiate `KhaltiCheckout` class and pass a [configuration](#configuration).

- `show(configuration?)`

	> Displays the Khalti checkout widget.

- `hide()`

	> Hide the widget.

## Configuration
Configuration is a Javascript object with following attributes.

- `publicKey`: Test or live public key which identifies the merchant.

- `amount`: Amount to pay. It must be in paisa.

- `productIdentity`: Unique product identifier at merchant.

- `productName`: Name of product

- `productUrl(optional)`: Url of the product.

- `eventHandler`: It is an object with three methods:

>  1) `onSuccess`
	This method is called once a transaction is confirmed by a user.
	The success response is in the following format:

	{
		"amount": 1000,
		"mobile": "98XXXXX969",
		"product_identity": "1234567890",
		"product_name": "Dragon",
		"product_url": "http://gameofthrones.wikia.com/wiki/Dragons",
		"token": "QUao9cqFzxPgvWJNi9aKac"
	}

It receives transaction `token` and `amount` among other payloads.
One should implement this method to initiate payment verification 
at merchant which in turn will make verification request at Khalti.
For documentation on verification follow this [link](./../api/verification.md).


>  2) `onError (optional)`
	This method is optional. If implemented, it will receive errors that occured during payment initiation and confirmation. Example error format for `Invalid Transaction PIN or Confirmation Code`:

	{
	  "action": "WALLET_PAYMENT_CONFIRM",
	  "message": undefined,
	  "payload": {
	    "detail": "Confirmation code or transaction pin does not match."
	  },
	  "status_code": 400
	}


>  3) `onClose (optional)`
		This method is also optional. If implemented, this method is called when `close icon(X)` of the widget is called.


**Additionally** Configuration also accepts attribute starting with `merchant_` that can be used to pass additional (meta) data. 

- `merchant_name`: This is merchant name

- `merchant_extra`: This is extra data

The additional data starting with `merchant_` is returned in success response payload.

Check out the source for [Khalti checkout on Github](https://github.com/khalti/khalti-sdk-web).
	
<script src="https://khalti.com/static/khalti-checkout.js"></script>
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
            }
        };

        var checkout = new KhaltiCheckout(config);
        var btn = document.getElementById("payment-button");
        btn.onclick = function () {
            checkout.show({amount: 1000});
        }
</script>

