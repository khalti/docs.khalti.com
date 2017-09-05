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

## Examples
Assuming the token that we received is `QUao9cqFzxPgvWJNi9aKac`.

### CURL

```curl
curl https://khalti.com/api/payment/verify/ \
   -H "Authorization:Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b" \
   -d amount=1000 \
   -d token=QUao9cqFzxPgvWJNi9aKac
```

### Python

```python
import requests

url = "https://khalti.com/api/payment/verify/"
payload = {
  "token": "QUao9cqFzxPgvWJNi9aKac"
  "amount": 1000
}
headers = {
  "Authorization": "Key test_secret_key_f59e8b7d18b4499ca40f68195a846e9b"
}

requests.post(url, payload, headers = headers)
```
