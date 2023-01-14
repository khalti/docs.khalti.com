# FAQ's

## 1. How can I sign up as a merchant?

Please go this link for a merchant sign up: https://khalti.com/join/merchant/

## 2. How to integrate KPG?

Based on your requirement please visit following links for Khalti integration:

- [Web integration](https://docs.khalti.com/checkout/web/)
- [Android integration](https://docs.khalti.com/checkout/android/)
- [iOS integration](https://docs.khalti.com/checkout/ios/)
- Flutter integration
    - [With Payment interface](https://docs.khalti.com/checkout/flutter/khalti-flutter/)
	- [Without payment interface](https://docs.khalti.com/checkout/flutter/khalti/)
<!-- - Khalti integration for custom payment interface
For Khalti wallet: [https://docs.khalti.com/checkout/diy-wallet/](https://docs.khalti.com/checkout/diy-wallet/)
For Ebanking wallet: [https://docs.khalti.com/checkout/diy-banking/ ](https://docs.khalti.com/checkout/diy-banking/ ) -->
- Khalti integration via plugins
	- [For WooCommerce](https://docs.khalti.com/plugins/woocommerce/)
	- [For Opencart](https://docs.khalti.com/plugins/opencart/)
	- [For Magneto](https://docs.khalti.com/plugins/magneto/)
	- [For Prestashop](https://docs.khalti.com/plugins/prestashop/)
	- [For WHMCS](https://docs.khalti.com/plugins/whmcs/)

## 3. What to do after a successful test transaction ?
After a successful test transaction, you will able to accept payments live. However, before going live, [please contact our team for the necessary coordination](https://docs.khalti.com/contact-us/)

## 4. Does Khalti have SDK for hybrid Apps?

We do have SDK for [Flutter](https://flutter.dev/). But for hybrid apps based on other frameworks, we don't have a specific SDK. 
Find options in `Client Integration`, which support Khalti checkout integration with your app.

## 5. Can I share merchant keys?

*Secret key* must not be shared with anyone. Ensure it does not get leaked by any means. If you key got compromised you can regenerate new one from your merchant dashboard.

## 6. Can I integrate Khalti in my static/HTML website?

Complete Khalti integration in Static/HTML site is not possible. If the currently available options failed to meet your requirement leave us your [feedback](/#support).

## 7. What can I resolve an issue while installing the plugin ?

First, check if cURL is enabled. You should check if you miss out any dependency or extension. There might be common SSL issues. You can also tweak the code (of the plugin you got from GitHub) on your own.

For debugging paste this in your code to get the configuration and predefined variables.
```
<?php phpinfo();?>
```
Also, see your server log.

## 8. What is Khalti mPIN?

Khalti mPIN is the four digit pin, used by the user while making payment of third party transactions.

It can created or changed at the Transaction Pin section under Account in khalti web and Settings in khalti app.

## 9. I need to refund payment to the user. How can I refund a transaction?

You can refund the payment to the user from your dashboard.

-- -- -- 

## Gotchas

### CORS issues

If you are getting CORS issues, read the docs again very thoroughly. You need to call verification API from your server to verify, so it is necessary to pass the data to your server first.

### Server errors

If you get error response "Fee not found." while testing, check your fee and set fee between Rs. 10 to Rs. 200. If you are using live keys contact merchant support to find your transaction limits.

### Payment errors

If you get error response "Amount must be less than 200." while testing, check you have complete all the contract process. If you are using live keys contact merchant support for further details.


### Frame Options and Clickjacking protection

> Refused to display 'https://khalti.com/payment/widget/' in a frame because it set 'X-Frame-Options' to 'deny'.

You are using HTTP response header 'X-Frame-Options' that avoids `<iframe>` rendering when you set it to 'deny'. But Khalti gateway uses iframe payment form, to accept payment from Khalti you need to allow iframe at least for khalti.com. You have a configuration option 'allow-from' with x-frame-options to allow from a specific domain. You can simply do this in your server configuration:

```
X-Frame-Options "allow-from https://khalti.com"
```

But using x-frame-options is not an internet standard. It is almost obsolete; modern browsers like chrome and safari don't support it.  The recommended way is to use 'frame-ancestors'  CSP rule. (legacy browsers like IE do not support it ).
So also for this error:

> Refused to display 'https://khalti.com/payment/widget/' in a frame because an ancestor violates the following Content Security Policy directive: "frame-ancestors 'none'".

You need to configure the server as:

```
Content-Security-Policy frame-ancestors 'self' khalti.com *.khalti.com
```

One can use both the options for full browser compatibility. So, please change your server configuration accordingly.
