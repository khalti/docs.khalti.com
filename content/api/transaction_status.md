# Transaction Status

Khalti provides API for transaction status/lookup to check the state of the user's transaction made to the merchant.
A merchant should use secret test and live keys to check test and live transaction status respectively.

## API

The request signature for transaction lookup is as follows:

* `URL`: `https://khalti.com/api/v2/payment/status/`
* `Method`: `GET`
* Headers: 
    * `Authorization`: test or live secret key in the form `Key <secret key>`
* Params:
    * `token`: Token or idx given by Khalti after payment confirmation.
    * `amount`: Amount (in paisa) with which payment was initiated.

## Response

Once you've made a request as specified above, Khalti server will return you a response of [Transaction States](https://docs.khalti.com/getting-started/#21-transaction-states) in the following format.

#### 1. Initiated State
```
{
    "status": true,
    "detail": "Transaciton initiated.",
    "state": "Initiated"
}
```

#### 2. Confirmed State
```
{
    "status": true,
    "detail": "Transaciton not verified.",
    "state": "Confirmed"
}
```

#### 3. Completed State
```
{
    "status": true,
    "detail": "Transaction complete.",
    "state": "Complete"
}
```

#### 4. Refunded State
```
{
    "status": false,
    "detail": "Transaciton refunded.",
    "state": "Refunded"
}
```

#### 5. Partially Refunded State
```
{
    "status": false,
    "detail": "Transaction partially refunded.",
    "state": "Partially refunded"
}
```

#### 6. Failed State
```
{
    "status": false,
    "detail": "Transaction failed.",
    "state": "Failed"
}
```
A transaction could be failed due to the possibility of 'confirmation_code' exploitation.

## Error Response

An error is occurred, if wrong token/idx or wrong amount is passed in the parameter. It consist of the detail of error.

```
{
    "status": false,
    "state": "Error",
    "detail": "Transaction not found"
}
```

## Examples Requests
Assuming the token/idx that we received is `XPPrDcwtHUg4UQbWEnxRzA`.

### Python

```python
import requests

url = "https://khalti.com/api/v2/payment/status/"
params = {
  "token": "XPPrDcwtHUg4UQbWEnxRzA",
  "amount": 1000
}
headers = {
  "Authorization": "Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b"
}

response = requests.get(url, params, headers = headers)
```

### Node

Install `axios` by running `yarn install axios`.

```nodejs
const axios = require('axios');

let data = {
    "token": "XPPrDcwtHUg4UQbWEnxRzA",
    "amount": 1000
};

let config = {
    headers: {'Authorization': 'Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b'}
};

axios.get("https://khalti.com/api/v2/payment/status/", data, config)
    .then(response => {
        console.log(response.data);
    })
    .catch(error => {
        console.log(error);
    });
```





