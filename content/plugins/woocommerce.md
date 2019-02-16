# WooCommerce

This is Khalti Payment Gateway extension for WooCommerce.
Check out the source for [Khalti plugin](https://github.com/khalti/khalti-woocommerce) on Github.


## Installation ##

The basic steps to follow:

- Go to the plugin section in your WordPress admin dashboard
- Click on Add New and upload the zip file of Khalti WooCommerce plugin ([link](https://github.com/khalti/khalti-woocommerce)) and upload it

![Upload Plugin](../img/woocommerce/upload_khalti.png)

- After installation is complete, go to `WooCommerce > Settings`
- Go to `Payments` option where you can find Khalti among other payment gateways
- Click on Khalti option and enter your test secret key and test public key in respective fields. You can get keys from `Keys` section in your merchant dashboard

![Set up Khalit](../img/woocommerce/khalti_setup.png)

- Click on save changes

## Testing ##

- Should enable khalti and Test Mode as shown in above example.
- Currency should be Nepalese Rupee. ([How](https://docs.woocommerce.com/document/shop-currency/))
- Go to your shop and complete a transaction from Wallet payment type.

## Deploy ##

- If you pass the test, Go to keys section in your merchant account, you can get your Live keys their
- Uncheck the Test Mode and enter your public and secret keys in respective fields
- Finally save the changes.
