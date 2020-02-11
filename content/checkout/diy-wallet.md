# Introduction

Read this documentation only if you plan to implement
your own SDK instead of using the ones provided by Khalti.

If you are not sure about that, please check our SDK for
Android, iOS and Web platforms.

Before starting out, read the rest of the documentation at
[http://docs.khalti.com](http://docs.khalti.com) to understand
the basic workflow of the merchant API.


# API

## 1. Initiate transaction

As the title says, this API is called to initiates the transaction.

E.g. When the user clicks `Checkout` button, you will need to
prompt for their Khalti registered mobile number, and call this API once
the payer submits.

The request signature for initiation is as follows:

* URL: `https://khalti.com/api/v2/payment/initiate/`
* Method: `POST`
* Data:
  * `public_key`: Required. Either `test` or `live` public key.
  * `mobile`: Required. The Khalti registered mobile number of payer.
  * `transaction_pin`: Required. Third party khalti pin submitted by the user.
  * `amount`: Required. The amount value of payment. Needs to be in paisa.
  * `product_identity`: Required. A string to identify the product.
  * `product_name`: Required. Descriptive name for the product.
  * `product_url`: Optional. Url of the product.

Additional information about the product can be passed along with this
for reporting purposes. The keys for additional data must be prefixed
with `merchant_`.

A sample request adhering to the above signature will look something like this:

```json
{
  "public_key": "live_public_key_546eb6da05544d7d88961db04fdb9721",
  "mobile": "9842XXXXXX",
  "transaction_pin": "1234",
  "amount": 10000,
  "product_identity": "book/id-120",
  "product_name": "A Song of Ice and Fire",
  "product_url": "http://bookexample.com"
}
```

The response will be something like this:

```json
{
  "token": "BVNKCiLZhZipkMGws5hgS8",
}
```

## 2. Confirm transaction

In this step, you will need to prompt the user for the OTP (One Time Password),
and their 3rd party khalti pin. Once those details are submitted, the
request to verify transaction should be made like this:

The value in `token` key from the response in previous step is required
to verify the transaction.

Request signature:

* URL: `https://khalti.com/api/v2/payment/confirm/`
* Method: `POST`
* Data:
  * `public_key`: Required. Should be same as the key used for transaction initiation.
  * `token`: Required. Transaction initiation token.
  * `confirmation_code`: Required. OTP submitted by the user.
  * `transaction_pin`: Required. Third party khalti pin submitted by the user.

A sample request adhering to above signature will look like this:

```json
{
"public_key": "live_public_key_546eb6da05544d7d88961db04fdb9721",
"token": "VGMyaKVDQQyorBiQ3W99WL",
"confirmation_code": "206964",
"transaction_pin": "1234"
}

```

A successful request will yield a response that looks something like this:

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

1. Initiate and verify api requests should be made from the front-end.
2. If the transaction initiation API response has `pin_created = true`,
   you must display the content of `pin_created_message` key in that response
   to the user.

