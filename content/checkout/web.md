Khalti checkout can be integrated with or without build tools like 
[Webpack](https://github.com/webpack/webpack) and [Rollup](https://github.com/rollup/rollup).

## Without build tools

```html
<html>
<head>
	<script src="https://khalti.com/static/khalti-checkout.js"></script>
</head>
<body>
	<button id="payment-button">Pay with Khalti</button>
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
				}
			}
		};

		var checkout = new KhaltiCheckout(config);
		var btn = document.getElementById("payment-button");
		btn.onclick = function () {
			checkout.show({amount: 1000});
		}
	</script>
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
import KhaltiCheckout from "khalti-checkout";

let config = {
	// replace this key with yours
	"publicKey": "test_public_key_dc74e0fd57cb46cd93832aee0a507256",
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

Instantiate `KhaltiCheckout` class and pass a [configuration](#descriptions-of-attributes).

- `show(configuration?)`

Displays the Khalti checkout widget.

- `hide()`

Hide the widget.

## Configuration
Configuration is a Javascript object with following attributes.

- `publicKey`: Test or live public key which identifies the merchant.

- `amount`: Amount to pay. It must be in paisa.

- `productIdentity`: Unique product identifier at merchant.

- `productName`: Name of product

- `productUrl(optional)`: Url of the product.

- `eventHandler`:
	
	It is an object with two methods:

	1. `onSuccess`
		This method is called once a transaction is confirmed by a user.
		It receives transaction `token` and `amount` among other payloads.
		One should implement this method to initiate payment verification 
		at merchant which in turn will make verification request at Khalti.
		For documentation on verification follow this [link](./../api/verification.md).

	2. `onError (optional)`
		This method is optional. If implemented, it will receive errors that occured during payment initiation and confirmation.
	
