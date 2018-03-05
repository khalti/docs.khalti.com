## Verification
After user confirms payment, it is verified server to server.
A verification request must have following signature.

- `url`: "https://khalti.com/api/payment/verify/"
- `method`: "POST"
- `headers`:
	- `Authorization`: test or live secret key in the form `Key <secret key>`
- `payload`:
	- `token`: Token given my Khalti after payment confirmation.
	- `amount`: Amount (in paisa) with which payment was initiated.

**Response** is in the following format:

`Success`: Success response consists of the idx of transaction created.

```
{'idx': 'ymYXHiG2dYSGk1w7s2SghM'}
```

`Error`: Error response consists of the detail of errors.

```
{'token': ['Invalid token.']}
```

## Examples
Assuming the token that we received is `QUao9cqFzxPgvWJNi9aKac`.

### CURL

```curl
curl https://khalti.com/api/payment/verify/ \
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
    
    $url = "https://khalti.com/api/payment/verify/";

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

url = "https://khalti.com/api/payment/verify/"
payload = {
  "token": "QUao9cqFzxPgvWJNi9aKac",
  "amount": 1000
}
headers = {
  "Authorization": "Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b"
}

response = requests.post(url, payload, headers = headers)
```
