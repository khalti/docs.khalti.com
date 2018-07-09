Khalti provides API for retrieving list of payments made to a merchant.
A merchant should use secret test and live keys for retrieving test and live payments respectively.

**List of transactions can also be viewed after logging on [Khalti website](https://khalti.com) with merchant account.**

Replace `<secret key>` with test or live secret key as per required.

**Response** is paginated and in the following format:

```python
{
  "total_pages": 1,
  "total_records": 2,
  "next": null,
  "previous": null,
  "record_range": [
    1,
    2
  ],
  "current_page": 1,
  "records": [
    {
      "idx": "8xmeJnNXfoVjCvGcZiiGe7",
      "type": {
        "idx": "e476BL6jt9kgagEmsakyTL",
        "name": "Wallet payment"
      },
      "state": {
        "idx": "DhvMj9hdRufLqkP8ZY4d8g",
        "name": "Completed",
        "template": "is complete"
      },
      "amount": 1000,
      "fee_amount": 30,
      "refunded": false,
      "created_on": "2018-06-20T14:48:08.867125+05:45",
      "ebanker": null,
      "user": {
        "idx": "cCaPkRPQGn5D8StkiqqMJg",
        "name": "Test User",
        "mobile": "98XXXXXXX9"
      },
      "merchant": {
        "idx": "UM75Gm2gWmZvA4TPwkwZye",
        "name": "Test Merchant",
        "mobile": "testmerchant@khalti.com"
      }
    },
    {
      "idx": "eWAyLgv9N6FjGnwYqhLpXC",
      "type": {
        "idx": "e476BL6jt9kgagEmsakyTL",
        "name": "Wallet payment"
      },
      "state": {
        "idx": "Dhvaj9hdRufLqkP8ZY4d8g",
        "name": "Confirmed",
        "template": "is confirm"
      },
      "amount": 10000,
      "fee_amount": 0,
      "refunded": false,
      "created_on": "2018-07-06T16:54:33.361956+05:45",
      "ebanker": null,
      "user": {
        "idx": "cCaPkRPQGn5D8StkiqqMJg",
        "name": "Test User",
        "mobile": "98XXXXXXX9"
      },
      "merchant": {
        "idx": "UM75Gm2gWmZvA4TPwkwZye",
        "name": "Test Merchant",
        "mobile": "testmerchant@khalti.com"
      }
    }
  ]
}
```


## List payments

### CURL

```curl
curl https://khalti.com/api/v2/merchant-transaction/ -H "Authorization:Key <secret key>
```

### PHP
```php
$url = "https://khalti.com/api/v2/merchant-transaction/";

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

url = "https://khalti.com/api/v2/merchant-transaction/"
payload = {}
headers = {
  "Authorization": "Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b"
}

response = requests.get(url, payload, headers = headers)
```


### Ruby

```ruby
require 'uri'
require 'net/http'

headers = {
  Authorization: "Key live_secret_key_fc1207298be544b99fa3ad41c7d7b324"
}
uri = URI.parse("https://khalti.com/api/v2/merchant-transaction/")
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true
request = Net::HTTP::Get.new(uri.request_uri, headers)
response = https.request(request)

puts response.body
```


## Retrieve payment

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
