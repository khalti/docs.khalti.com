# Introduction

This document explains the various requests to implement ebanking
payment system using Khalti.

First and foremost, please read the docs at
[http://docs.khalti.com](http://docs.khalti.com) to understand
the basic workflow of the merchant API.


# API

## 1. Get Bank List
This API provides the bank list. The request signature for initiation is as follows:

* URL: `https://khalti.com/api/bank/?has_ebanking=true`
* Method: `GET`

The response contains list of banks with the details as shown below.

```json
{ ...
  "records": [
    {
        "idx":	"Yy6jFwuwssihs77PHGjwAZ",
        "name":	"<Bank Name>",
        "short_name":	"<Truncated Name>",
        "logo": 	"<logo source>",
        "has_cardpayment":	false,
        "address":	"<Bank address>",
        "has_ebanking":	true,
        "has_direct_withdraw":	false,
        "has_nchl":	false,
        "has_mobile_banking":	false,
        "play_store":	"",
        "app_store": ""
      }
  ]
}
```


## 2. Initiate transaction

As the title says, this API is called to initiates the transaction.

E.g. When the user clicks `Checkout` button, you will need to
prompt for their Khalti registered mobile number, and call this API once
the payer submits.

The request signature for initiation is as follows:

* URL: `https://khalti.com/api/ebanking/initiate/`
* Method: `POST`
* Data:
  * `public_key`: Required. Either `test` or `live` public key.
  * `mobile`: Required. The Khalti registered mobile number of payer.
  * `amount`: Required. The amount value of payment. Needs to be in paisa.
  * `product_identity`: Required. A string to identify the product.
  * `product_name`: Required. Descriptive name for the product.false
  * `bank`:Required.A bank idx,
  * `source`:Required. web, android, ios, or custom,
  * `return_url`:Optional. It is required if `source` key is `custom` or `ios`.

`return_url` for ios platform creates a url scheme for browser to open current app and if for custom redirects window to this url with data,

Additional information about the product can be passed along with this
for reporting purposes. The keys for additional data must be prefixed
with `merchant_`.

A sample request adhering to the above signature will look something like this:

```json
{
  "public_key": "live_public_key_546eb6da05544d7d88961db04fdb9721",
  "mobile": "9842XXXXXX",
  "amount": 10000,
  "product_identity": "book/id-120",
  "product_name": "A Song of Ice and Fire",
  "bank": "Yy6jFwuwssihs77PHGjwAZ",
  "source": "web"
}
```

With this request khalti server will redirect your client to bank portal where user can access e-banking, finally redirecting back to original/parent page with the response.

#
#### Data Retrival
If transaction is initated, then user interacts with ebanking system. Now after transaction is completed getting success or failure response is tricky. There are different ways based on different `source`.

**Android**

For `android` it returns data with the intent
```
intent://ebanking/#Intent;scheme=khalti;package=<return_url>;S.data=<data>;S.browser_fallback_url=https://khalti.com/;end
```
**IOS**

For `ios` you need to provide return_url and response data is binded with it. Finally, custom url for the action is
```
<return_url>://?<data>
```
**Custom**

If you have provided return url and source as custom as following:

```json
{
  ...
  "return_url": "http://example.bookshop.com/",
  "source": "custom"
}
```
You will then get redirection to return_url with data as below.

```
{return_url}/?{data}
```
**Web**
And with `web` response data is stored in local storage with `localstorage.setItem("confirmation-data", {{data}})`
The `storage` event is fired when a storage area (localStorage or sessionStorage) has been modified. So, while implementing it needs to listen the `storage` event and read localstorage  value as data with the key `confirmation-data`. The example is like this:
```
window.addEventListener("storage", function (event) {
  if (event.key == "confirmation-data") {
    data = JSON.parse(event.newValue);
    // this is the final response with looks json shown below
    window.localStorage.removeItem("confirmation-data");
  }
});
```

```json
{
  "token": "VGMyaKVDQQyorBiQ3W99WL",
  "amount": 10000,
  "mobile": "98XXXXX099",
  "product_identity": "book/id-120",
  "product_name": "A Song of Ice and Fire"
}
```

## 3. Verify transaction

The API requests mentioned in previous steps are to be made from the
client side i.e. from the front-end. Once those steps are complete, you
need to make a verification request using your secret key from the server.

See [http://docs.khalti.com/api/verification/](http://docs.khalti.com/api/verification/)
for more information on how to verify the transaction.


# Notes

1. While testing you might need to interact with actual system of banks. There is no sandbox or testing environment for using ebanking system.
2. Prevent parent page (that initiates redirection) for closing until payment process is not completed. You will not get final response unless bank portal provides success/response message.
