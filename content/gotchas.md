# FAQ's
**1. Does Khalti have SDK for hybrid Apps?**

For the hybrid app, we don't have a specific SDK. Find options in `Client Integration`, which support Khalti checkout integration with your app.

**2. Can I share merchant keys?**

*Secret key* must not be shared with anyone. Ensure it does not get leaked by any means. If you key got compromised you can regenerate new one from your merchant dashboard.

**3. Can I integrate Khalti in my static/HTML website?**

Complete Khalti integration in Static/HTML site is not possible. If the currently available options failed to meet your requirement leave us your [feedback.](/#support).

**4. While installing the plugin I got an issue. How can I resolve it?**

First, check if cURL is enabled. You should check if you miss out any dependency or extension. There might be common SSL issues. You can also tweak the code (of the plugin you got from GitHub) on your own.

For debugging paste this in your code to get the configuration and predefined variables.
```
<?php phpinfo();?>
```
Also, see your server log.

**5. What is Khalti PIN?**

Khalti pin is the four digit pin, used by the user while making payment of third party transactions.

It can created or changed at the Transaction Pin section under Account in khalti web and Settings in khalti app.


**5. I need to refund payment to the user. How can I refund a transaction?**

You can refund the payment to the user from your dashboard.

# gotchas

- **CORS issues**

If you are getting CORS issues, read the docs again very thoroughly. You need to call verification API from your server to verify, so it is necessary to pass the data to your server first.

- **Server errors**

If you get error response "Fee not found." while testing, check your fee and set fee between Rs. 10 to Rs. 1000. If you are using live keys contact [merchant support](/#support) to find your transaction limits.

- **Frame Options and Clickjacking protection**

> Refused to display 'https://khalti.com/payment/widget/' in a frame because it set 'X-Frame-Options' to 'deny'.

You are using HTTP response header 'X-Frame-Options' that avoids `<iframe>` rendering when you set it to 'deny'. But Khalti gateway uses iframe payment form, to accept payment from Khalti you need to allow iframe at least for khalti.com. You have a configuration option 'allow-from' with x-frame-options to allow from a specific domain. You can simply do this in your server configuration:

```
X-Frame-Options "allow-from https://khalti.com"
```

But using x-frame-options is not an internet standard. It is almost absolute; modern browsers like chrome and safari don't support it.  The recommended way is to use 'frame-ancestors'  CSP rule. (legacy browsers like IE do not support it ).
So also for this error:

> Refused to display 'https://khalti.com/payment/widget/' in a frame because an ancestor violates the following Content Security Policy directive: "frame-ancestors 'none'".

You need to configure the server as:

```
Content-Security-Policy frame-ancestors 'self' khalti.com *.khalti.com
```

One can use both the options for full browser compatibility. So, please change your server configuration accordingly.
