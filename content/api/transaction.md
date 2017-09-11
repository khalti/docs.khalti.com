Khalti provides API for retrieving list of payments made to a merchant.
A merchant should use secret test and live keys for retrieving test and live payments respectively.

Replace `<secret key>` with test or live secret key as per required.

## List payments

### CURL

```curl
curl https://khalti.com/api/transaction/ -H "Authorization:Key <secret key>
```

### PHP
```php
   
    $url = "https://khalti.com/api/transaction/";

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

url = "https://khalti.com/api/transaction/"
payload = {}
headers = {
  "Authorization": "Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b"
}

response = requests.get(url, payload, headers = headers)
```



## Retrieve a payment

###CURL 

```curl
curl https://khalti.com/api/transaction/<idx>/ -H "Authorization:Key <secret key>
```

### PHP
```php
   
    $url = "https://khalti.com/api/transaction/<idx>/";

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

url = "https://khalti.com/api/transaction/<idx>/"
headers = {
  "Authorization": "Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b"
}

response = requests.get(url, headers = headers)
```
