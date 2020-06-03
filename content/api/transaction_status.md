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

## Responses

Once you've made a request as specified above, Khalti server will return you a response of [Transaction States](https://docs.khalti.com/getting-started/#21-transaction-states) in the following format.

### Success Response

Success response consists of the `Complete` state.

#### Completed State
```
{
    "status": true,
    "detail": "Transaction complete.",
    "state": "Complete"
}
```

### Error Response

#### 1. Trasaction Not Found
An error occurs, if wrong token/idx or wrong amount is passed in the parameter. It consist of the detail of error.

```
{
    "status": false,
    "state": "Error",
    "detail": "Transaction not found"
}
```

#### 2. Failed State
A transaction could be failed due to the possibility of 'confirmation_code' exploitation.

```
{
    "status": false,
    "detail": "Transaction failed.",
    "state": "Failed"
}
```

### Other Responses

#### 1. Initiated State

Transactions are initiated after mobile number and khalti pin along with other transaction details are provided.

```
{
    "status": true,
    "detail": "Transaciton initiated.",
    "state": "Initiated"
}
```

#### 2. Confirmed State
A transaction is confirmed after transaction details (transaction token, confirmation_code and 3rd party transaction_pin) are provided by the consumer.

```
{
    "status": true,
    "detail": "Transaciton not verified.",
    "state": "Confirmed"
}
```

#### 3. Refunded State
```
{
    "status": false,
    "detail": "Transaciton refunded.",
    "state": "Refunded"
}
```

#### 4. Partially Refunded State
```
{
    "status": false,
    "detail": "Transaction partially refunded.",
    "state": "Partially refunded"
}
```

## Example Requests
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





