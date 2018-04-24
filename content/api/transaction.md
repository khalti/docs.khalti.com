Khalti provides API for retrieving list of payments made to a merchant.
A merchant should use secret test and live keys for retrieving test and live payments respectively.

**List of transactions can also be viewed after logging on [Khalti website](https://khalti.com) with merchant account.**

Replace `<secret key>` with test or live secret key as per required.

**Response** is paginated and in the following format:

```
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
      "idx": "vXaHQXJd6Ke79By9dTHsVe",
      "type": "Wallet payment",
      "state": "Confirmed",
      "amount": 1000,
      "fee_amount": 30,
      "created_on": "2017-11-19T11:17:53.763052+05:45",
      "source": "98XXXXX969"
    },
    {
      "idx": "ymYXHiG2dYSGkxw7s2SghM",
      "type": "Wallet payment",
      "state": "Completed",
      "amount": 1000,
      "fee_amount": 30,
      "created_on": "2017-11-19T11:21:39.646256+05:45",
      "source": "98XXXXX969"
    }
  ]
}
```


## List payments

### CURL

```curl
curl https://khalti.com/api/merchant-transaction/ -H "Authorization:Key <secret key>
```

### PHP
```php
$url = "https://khalti.com/api/merchant-transaction/";

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

url = "https://khalti.com/api/merchant-transaction/"
payload = {}
headers = {
  "Authorization": "Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b"
}

response = requests.get(url, payload, headers = headers)
```



## Retrieve a payment

###CURL 

```curl
curl https://khalti.com/api/merchant-transaction/<idx>/ -H "Authorization:Key <secret key>
```

### PHP
```php
   
$url = "https://khalti.com/api/merchant-transaction/<idx>/";

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

url = "https://khalti.com/api/merchant-transaction/<idx>/"
headers = {
  "Authorization": "Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b"
}

response = requests.get(url, headers = headers)
```

