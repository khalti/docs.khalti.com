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
```

### Python

```python
```
