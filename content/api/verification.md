## Verification
After user confirms payment, it is verified server to server.
A verification request must have following signature.

- `url`: "https://khalti.com/api/payment/verify/"
- `method`: "POST"
- `headers`: Pass your test or live secret key at `Authorization` header.
- `payload`:
	- `token`: Token given my Khalti after payment confirmation.
	- `amount`: Amount (in paisa) with which payment was initiated.

## Examples
### CURL

```curl
curl https://khalti.com/api/payment/verify/ \
   -H Authorization=test_secret_key_f59e8b7d18b4499ca40f68195a846e9b \
   -d amount=1000 \
   -d token=<token>
```

### Python

```python
```
