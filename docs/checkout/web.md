There are two ways to integrate Khalti checkout in web.
With or without build tools like [Webpak](https://github.com/webpack/webpack) and [Rollup](https://github.com/rollup/rollup).

## 1. Without build tools

```html
<body>
	<script src="https://khalti.com/static/khalti-checkout.js"></script>
	// ...
	<button id="payment-button">Pay with Khalti</button>
	// ...
	<script>
		let config = {
			"public_key": "",
			"return_url": "",
			"product_identity": "",
			"product_name": "",
			"product_url": "",
			onConfirmation (payload) {
				// hit merchant api for initiating verfication
				console.log(payload);
			}
		};

		let checkout = new KhaltiCheckout(config);
		let btn = document.getElementById("payment-button");
		btn.onclick = function () {
			checkout.show({amount: 1000});
		}
	</script>
</body>
```

### 2. With build tools
Comming soon ...


## Descriptions of attributes

public_key
	- Test or live public key which identifies the merchant.
amount
	- Amount to pay. It must be in paisa.
return_url
	- The url at which Khalti widget will make post request after user confirmation.
button_type
	- Type of button to render. There are 3 choices:
		1. normal - Plain button
		2. mini - Small image button
		3. big - Big image button
product_identity
	- Unique product identifier at merchant.
product_name
	- Name of product
product_url
	- Url of the product.
merchant_x
	- Merchant data are special payloads which Khalti will provide to merchant's `return_url` \
	after confirmation. Usually merchant uses these data for product purchase verification on their side.
