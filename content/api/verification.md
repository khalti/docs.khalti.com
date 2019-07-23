## Introduction
Whenever your customer pays using the Khalti widget, the client side
makes a request to the Khalti server to initiate and confirm the
payment.

Once they've confirmed the payment, the client will receive a response
containing unique token and amount for that particular transaction.
Upon receiving the transaction token, the client will make a request
to your server with the token and the payment amount.

On the next step, you will need to ask the Khalti server to verify the
information relayed by the user before completing their purchase
order.


## Why is server-to-server verification necessary?
Since the client side makes the payment directly to Khalti without
going through your server first, you need to be sure that the customer
actually paid the money they were supposed to before completing their
order. This type of verification can only be done securely from the
server.


## Verification request
Your application server must do a `POST` request to Khalti server for
the final step of the payment process. The structure of the request as
expected by Khalti server is as follows.

- `url`: `https://khalti.com/api/v2/payment/verify/`
- `method`: `POST`
- `headers`:
	- `Authorization`: test or live secret key in the form `Key <secret key>`
- `payload`:
	- `token`: Token given by Khalti after payment confirmation.
	- `amount`: Amount (in paisa) with which payment was initiated. (Important !!
	Cross check the amount from client side to amount from server.)


## Verification response
Once you've made a request as specified above, Khalti server will
return you a response in the following format.

`Success`: Success response consists of the transaction record.

```python
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
}
```

`Error`: Error response consists of the detail of errors.

```python
{'token': ['Invalid token.']}
```

## Examples
Assuming the token that we received is `QUao9cqFzxPgvWJNi9aKac`.

### CURL

```curl
curl https://khalti.com/api/v2/payment/verify/ \
   -H "Authorization:Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b" \
   -d amount=1000 \
   -d token=QUao9cqFzxPgvWJNi9aKac
```

### PHP
```php
$args = http_build_query(array(
    'token' => 'QUao9cqFzxPgvWJNi9aKac',
    'amount'  => 1000
));

$url = "https://khalti.com/api/v2/payment/verify/";

# Make the call using API.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS,$args);
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

url = "https://khalti.com/api/v2/payment/verify/"
payload = {
  "token": "QUao9cqFzxPgvWJNi9aKac",
  "amount": 1000
}
headers = {
  "Authorization": "Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b"
}

response = requests.post(url, payload, headers = headers)
```

### Ruby

```ruby
require 'uri'
require 'net/http'

headers = {
  Authorization: 'Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b'
}
uri = URI.parse('https://khalti.com/api/v2/payment/verify/')
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true
request = Net::HTTP::Post.new(uri.request_uri, headers)
request.set_form_data('token' => 'QUao9cqFzxPgvWJNi9aKac', 'amount' => 1000)
response = https.request(request)

puts response.body
```

### Node

Install `axios` by running `yarn install axios`.

```nodejs
const axios = require('axios');

let data = {
    "token": "QUao9cqFzxPgvWJNi9aKac",
    "amount": 1000
};

let config = {
    headers: {'Authorization': 'Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b'}
};

axios.post("https://khalti.com/api/v2/payment/verify/", data, config)
    .then(response => {
        console.log(response.data);
    })
    .catch(error => {
        console.log(error);
    });
```
