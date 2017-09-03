There are two ways to integrate Khalti checkout in web.
With or without build tools like [Webpack](https://github.com/webpack/webpack) and [Rollup](https://github.com/rollup/rollup).

## 1. Without build tools

```html
<body>
	<script src="https://khalti.com/static/khalti-checkout.js"></script>
	// ...
	<button id="payment-button">Pay with Khalti</button>
	// ...
	<script>
		var config = {
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
```

### 2. With build tools
If you are developing SPA(Single Page App) using build tools like Webpack, Rollup, etc
please follow following steps.

#### 1. Install `khalti-checkout`
##### Using yarn
`yarn add khalti-checkout`

##### Using npm
`npm install khalti-checkout --save`

#### 2. Import and use it in your desired component
```javascript
import KhaltiCheckout from "khalti-checkout";

let config = {
	"publicKey": "test_public_key_dc74e0fd57cb46cd93832aee0a507256",
	"productIdentity": "1234567890",
	"productName": "",
	"productUrl": "http://gameofthrones.wikia.com/wiki/Dragons",
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


## Descriptions of attributes

- `publicKey`: Test or live public key which identifies the merchant.

- `amount`: Amount to pay. It must be in paisa.

- `productIdentity`: Unique product identifier at merchant.

- `productName`: Name of product

- `productUrl`: Url of the product.

- `eventHandler`:
	
	It is an object with two methods:

	1. `onSuccess`
		This method is called once a transaction is confirmed by a user.
		One should implement this method to initiate payment verification at merchant.

	2. `onError (optional)`
		This method is optional. If implemented, it will receive errors that occured during payment initiation and confirmation.
	
