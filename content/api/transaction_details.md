Khalti provides API for retrieving payment made to a merchant.
A merchant should use secret test and live keys for retrieving test and live payment respectively.

** Payment details can also be viewed after logging on [Khalti website](https://khalti.com) with merchant account.**

Replace `<secret key>` with test or live secret key as per required.

**Response** is in the following format:

```python
{
  "idx": "xeR2tuRqEvBLmeJcZzMb5U",
  "type": {
    "idx": "2jwzDS9wkxbkDFquJqfAEC",
    "name": "Wallet payment"
  },
  "state": {
    "idx": "DhvMj9hdRufLqkP8ZY4d8g",
    "name": "Completed",
    "template": "is complete"
  },
  "amount": 3000,
  "fee_amount": 90,
  "created_on": "2018-04-16T17:04:05.204629+05:45",
  "can_refund": true,
  "can_complete": false,
  "ebanker": null,
  "user": {
    "idx": "aVPXfJQ8HMYKhAePAU6pg5",
    "name": "Test User",
    "mobile": "98XXXXXXX9"
  },
  "merchant": {
    "idx": "UM75Gm2gWmZvA4TPwkwZye",
    "name": "Test Merchant",
    "mobile": "testmerchant@khalti.com"
  },
  "refunded": false,
  "child_transactions": [
    {
      "idx": "uUx2Ead8qqDuRufYh8vsYj",
      "type": {
        "idx": "YpwbDVqAnH42odGZmT5vZ8",
        "name": "Fee"
      },
      "state": {
        "idx": "DhvMj9hdRufLqkP8ZY4d8g",
        "name": "Completed",
        "template": "is complete"
      },
      "amount": 90,
      "fee_amount": 0,
      "created_on": "2018-07-19T12:31:55.620318+05:45",
      "can_refund": true,
      "can_complete": false,
      "ebanker": null,
      "user": {
        "idx": "UM75Gm2gWmZvA4TPwkwZye",
        "name": "Test Merchant",
        "mobile": "testmerchant@khalti.com"
      },
      "merchant": {
        "idx": "9dUzuqrLetWo9VY3fNwB2E",
        "name": "",
        "mobile": "wallet@khalti.com"
      },
      "refunded": false,
      "child_transactions": [],
      "meta": null
    }
  ],
  "meta": {
    "product_identity": "369121518",
    "product_name": "Test Product",
    "product_url": "http://testproduct.com/wiki/khalti"
  }
}
```

## API Request Examples

###CURL 

```curl
curl https://khalti.com/api/v2/merchant-transaction/<idx>/ -H "Authorization:Key <secret key>
```

### PHP
```php
   
$url = "https://khalti.com/api/v2/merchant-transaction/<idx>/";

# Make the call using API.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

$headers = ['Authorization: Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b'];
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

// Response
$response = curl_exec($ch);
$status_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

```

### Python

```python
import requests

url = "https://khalti.com/api/v2/merchant-transaction/<idx>/"
headers = {
  "Authorization": "Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b"
}

response = requests.get(url, headers = headers)
```


### Ruby

```ruby
require 'uri'
require 'net/http'

headers = {
  Authorization: "Key live_secret_key_fc1207298be544b99fa3ad41c7d7b324"
}
uri = URI.parse("https://khalti.com/api/v2/merchant-transaction/<idx>/")
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true
request = Net::HTTP::Get.new(uri.request_uri, headers)
response = https.request(request)

puts response.body
```
