
# Ebanking and Mobile Banking

This documentation details the process of implementing the latest e-Payment eBanking Checkout and Mobile Banking platform released by Khalti.



## 1. Get Bank List

This API provides the bank list. The request signature for initiation is as follows:

- ebanking URL : `https://khalti.com/api/v5/bank/?payment_type=ebanking`
- Mbanking URL :` https://khalti.com/api/v5/bank/?payment_type=mobilecheckout`
- Method: `GET`
- Authorization : Not Required

The response contains list of banks with the details as shown below.

```json
{
  "total_pages": 1,
  "total_records": 14,
  "next": null,
  "previous": null,
  "record_range": [1, 14],
  "current_page": 1,
  "records": [
    {
      "idx": "UZmPqTDkdhKmukdZe2gVWZ",
      "name": "Agricultural Development Bank Limited",
      "short_name": "ADBL",
      "logo": "https://khalti-static.s3.ap-south-1.amazonaws.com/media/bank-logo/adbl.png",
      "swift_code": "ADBLNPKA",
      "has_cardpayment": false,
      "address": "Singhadurbar, Kathmandu",
      "ebanking_url": "",
      "has_ebanking": true,
      "has_mobile_checkout": true,
      "has_direct_withdraw": true,
      "has_nchl": false,
      "has_mobile_banking": false,
      "play_store": "",
      "app_store": "",
      "branches": []
    }
  ]
}
```

## 2. Initiate transaction

Every payment request should be first initiated from the merchant as a server side POST request. Upon success, a unique request identifier is provided called pidx that should be used for any future references.

- URL : `https://khalti.com/api/v2/epayment/initiate/`
- Method : `POST`
- Authorization : Required

For more information [click here](https://docs.khalti.com/khalti-epayment/#initiating-a-payment-request).

### Sample Request Payload

```json
{
    "return_url": "https://testing.com/",
    "website_url": "https://testing.com/",
    "amount": "10000",
    "ttl": 1000,
    "bank": "ayCEFuEpkmkjBj3WVWRh32",
    "modes": [
        "MOBILE_BANKING"
    ],
        "purchase_order_id": "wakanada_01",
        "purchase_order_name": "wakanda 02",
    "customer_info": {
        "name": "test shrestha",
        "email": "example@gmail.com",
        "phone": "9801856451"
    },
    "amount_breakdown": [
        {
            "label": "Mark Price",
            "amount": "10000"
        },
        {
            "label": "VAT",
            "amount": 0
        }
    ],
    "product_details": [
        {
            "identity": "shark_1",
            "name": "shark_2",
            "total_price": 10000,
            "quantity": 1,
            "unit_price": 10000
        }
    ]
}
```

!!! success "Success Response"

    ``` json
    	{
            "pidx": "bZQLD9wRVWo4CdESSfuSsB",
            "payment_url": "https://test-pay.khalti.com/?pidx=bZQLD9wRVWo4CdESSfuSsB",
            "expires_at": "2023-05-25T16:26:16.471649+05:45",
            "expires_in": 1800
        }
    ```

After getting the success response, the user should be redirected to the `payment_url` obtained in the success response.

### Error Responses

!!! failure "return_url is blank"

    ``` json
    {
        "return_url": [
            "This field may not be blank."
        ],
        "error_key": "validation_error"
    }
    ```

!!! failure "return_url is invalid"

    ``` json
    {
        "return_url": [
            "Enter a valid URL."
        ],
        "error_key": "validation_error"
    }
    ```

!!! failure "website_url is blank"

    ``` json
    {
        "website_url": [
            "This field may not be blank."
        ],
        "error_key": "validation_error"
    }
    ```

!!! failure "website_url is invalid"

    ``` json
    {
        "website_url": [
            "Enter a valid URL."
        ],
        "error_key": "validation_error"
    }
    ```

!!! failure "Amount is less than 10"

    ``` json
    {
        "amount": [
            "Amount should be greater than Rs. 100, that is 1000 paisa."
        ],
        "error_key": "validation_error"
    }
    ```

!!! failure "Amount is invalid"

    ``` json
    {
        "amount": [
            "A valid integer is required."
        ],
        "error_key": "validation_error"
    }
    ```

!!! failure "purchase_order_id is blank"

    ``` json
    {
        "purchase_order_id": [
            "This field may not be blank."
        ],
        "error_key": "validation_error"
    }
    ```

!!! failure "purchase_order_name is blank"

    ``` json
    {
        "purchase_order_name": [
            "This field may not be blank."
        ],
        "error_key": "validation_error"
    }
    ```

!!! failure "Amount breakdown doesn't total to the amount passed"

    ``` json
    {
        "amount": [
            "Amount Breakdown mismatch."
        ],
        "error_key": "validation_error"
    }
    ```

## Payment Success Callback

After the user completes the payment, the success response is obtained in the return URL specified during payment initiate.
Sample of success response return URL.

- The callback url `return_url` should support `GET` method
- User shall be redirected to the `return_url` with following parameters for confirmation
  - pidx - _The initial payment identifier_
  - status - _Status of the transaction_
    - Completed - Transaction is success
    - Pending - Transaction is in pending state, request for lookup API.
    - User canceled - Transaction has been canceled by user.
  - transaction*id - \_The transaction identifier at Khalti*
  - tidx - _Same value as transaction id_
  - amount - _Amount paid in paisa_
  - mobile - _Payer KHALTI ID_
  - purchase*order_id - \_The initial purchase_order_id provided during payment initiate*
  - purchase*order_name - \_The initial purchase_order_name provided during payment initiate*
  - total*amount - \_Same value as amount*
- There is no further step required to complete the payment, however merchant can process with their own validation and confirmation steps if required
- It's recommended that during implementation, payment lookup API is checked for confirmation after the redirect callback is received

### Sample Callback Request

- Success transaction callback

```
http://example.com/?pidx=bZQLD9wRVWo4CdESSfuSsB
&txnId=4H7AhoXDJWg5WjrcPT9ixW
&amount=10000
&total_amount=10000
&status=Completed
&mobile=98XXXXX904
&tidx=4H7AhoXDJWg5WjrcPT9ixW
&purchase_order_id=test12
&purchase_order_name=test
&transaction_id=4H7AhoXDJWg5WjrcPT9ixW
```

- Canceled transaction callback

```
http://example.com/?pidx=bZQLD9wRVWo4CdESSfuSsB
&transaction_id=
&tidx=
&amount=10000
&total_amount=10000
&mobile=
&status=User canceled
&purchase_order_id=test12
&purchase_order_name=test
```

!!! Important + Please use the lookup API for the final validation of the transaction. + Khalti payment link expires in 60 minutes in production (default).

<!-- ##
- The callback url `return_url` should support `GET` method
- User shall be redirected to the `return_url` with following parameters for confirmation
    + message - _Failure message_ -->

## Payment Verification (Lookup)

After a callback is received, You can use the `pidx` provided earlier, to lookup and reassure the payment status.

| URL               | Method | Authorization | Format           |
| ----------------- | ------ | ------------- | ---------------- |
| /epayment/lookup/ | POST   | Required      | application/json |

#### Request Data

```json
{
  "pidx": "HT6o6PEZRWFJ5ygavzHWd5"
}
```

#### Success Response

```json
{
  "pidx": "HT6o6PEZRWFJ5ygavzHWd5",
  "total_amount": 10000,
  "status": "Completed",
  "transaction_id": "GFq9PFS7b2iYvL8Lir9oXe",
  "fee": 0,
  "refunded": false
}
```

#### Pending Response

```json
{
  "pidx": "HT6o6PEZRWFJ5ygavzHWd5",
  "total_amount": 10000,
  "status": "Pending",
  "transaction_id": null,
  "fee": 0,
  "refunded": false
}
```

#### Initiated Response

```json
{
  "pidx": "HT6o6PEZRWFJ5ygavzHWd5",
  "total_amount": 10000,
  "status": "Initiated",
  "transaction_id": null,
  "fee": 0,
  "refunded": false
}
```

#### Refunded Response

```json
{
  "pidx": "HT6o6PEZRWFJ5ygavzHWd5",
  "total_amount": 10000,
  "status": "Refunded",
  "transaction_id": "GFq9PFS7b2iYvL8Lir9oXe",
  "fee": 0,
  "refunded": true
}
```

#### Expired Response

```json
{
  "pidx": "H889Er9gq4j92oCrePrDwf",
  "total_amount": 10000,
  "status": "Expired",
  "transaction_id": null,
  "fee": 0,
  "refunded": false
}
```

#### Canceled Response

```json
{
  "pidx": "vNTeXkSEaEXK2J4i7cQU6e",
  "total_amount": 10000,
  "status": "User canceled",
  "transaction_id": null,
  "fee": 0,
  "refunded": false
}
```

### Payment Status Code

| Status             | Status Code |     |
| ------------------ | ----------- | --- |
| Completed          | 200         |
| Pending            | 200         |
| Expired            | 400         |
| Initiated          | 200         |
| Refunded           | 200         |
| User canceled      | 400         |
| Partially Refunded | 200         |

### Lookup Payload Details

| Status         | Description                                                                                                                                                                                                                                                                                                                                            |     |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --- |
| pidx           | This is the payment id of the transaction.                                                                                                                                                                                                                                                                                                             |
| total_amount   | This is the total amount of the transaction                                                                                                                                                                                                                                                                                                            |
| status         | `Completed` - Transaction is success <br />`Pending` - Transaction is failed or is in pending state <br />`Refunded` - Transaction has been refunded<br />`Expired` - This payment link has expired <br />`User canceled` - Transaction has been canceled by the user <br />`Partially refunded` - Transaction has been partially refunded by the user |
| transaction_id | This is the transaction id for the transaction. <br />This is the unique identifier.                                                                                                                                                                                                                                                                   |
| fee            | The fee that has been set for the merchant.                                                                                                                                                                                                                                                                                                            |
| refunded       | `True` - The transaction has been refunded. <br />`False` - The transaction has not been refunded.                                                                                                                                                                                                                                                     |

### Lookup status

| Field         | Description                                                    |     |
| ------------- | -------------------------------------------------------------- | --- |
| Completed     | Provide service to user.                                       |
| Pending       | Hold, do not provide service. And contact Khalti team.         |
| Refunded      | Transaction has been refunded to user. Do not provide service. |
| Expired       | User have not made the payment, Do not provide the service.    |
| User canceled | User have canceled the payment, Do not provide the service.    |

!!! Important note  
 + Only the status with **Completed** must be treated as success. + Status **Canceled** , **Expired** , **Failed** must be treated as failed. + If any negative consequences occur due to incomplete API integration or providing service without checking lookup status, Khalti won’t be accountable for any such losses.  
 + For status other than these, hold the transaction and contact **KHALTI** team. + Payment link expires in 60 minutes in production.

## Generic Errors

#### When an incorrect Authorization key is passed.

```json
{
  "detail": "Invalid token.",
  "status_code": 401
}
```

#### If incorrect pidx is passed.

```json
{
  "detail": "Not found.",
  "error_key": "validation_error"
}
```

#### If key is not passed as prefix in Authorization key

```json
{
  "detail": "Authentication credentials were not provided.",
  "status_code": 401
}
```

&nbsp;
