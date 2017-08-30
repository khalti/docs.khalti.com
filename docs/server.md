## Verification
After user confirms payment, it is verified server to server.

url: "https://khalti.com/api/payment/verify/"
method: "POST"
headers:
	Authorization: <Key live/test secret key>
payload:
	- token:
	- amount:
