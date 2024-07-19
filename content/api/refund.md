# Refund API 

The Refund API allows merchants to process refunds for transactions. Refunds can be either full or partial and apply to both wallet and banking transactions.

## API Endpoints

!!! info "API Endpoints"

    **Sandbox**

    [https://a.khalti.com/api/merchant-transaction/{{transaction_id}}/refund/](https://a.khalti.com/api/merchant-transaction/{{transaction_id}}/refund/)

    **Production**

    [https://khalti.com/api/merchant-transaction/{{transaction_id}}/refund/](https://khalti.com/api/merchant-transaction/{{transaction_id}}/refund/)

!!! Note
    The transaction_id will be obtained from Payment Lookup.


## Request Parameters

### Wallet Refund

#### Full Refund
For a full refund, no additional parameters are required.

#### Partial Refund
For a partial refund, the following parameters are required:

- **Amount**: The amount to be refunded.

!!! Note 
    The amount should be in paisa.

**Example Request (Partial Refund)**

```json
{
    "amount": 50.00
}

```
### Bank Refund
#### Full Refund

For a full refund, the following parameter is required:

- **Mobile**: The mobile number associated with the Khalti account.

**Example Request (Full Refund)**
```json
{
    "mobile": "1234567890"
}
```

#### Partial Refund

For a partial refund, the following parameters are required:

   - **Mobile**: The mobile number associated with the Khalti account.
- **Amount**: The amount to be refunded.

**Example Request (Partial Refund)**

```json
{
    "mobile": "1234567890",
    "amount": 75.00
}
```

!!! success "Success Response"

    
        {
            "detail": "Transaction refund successful."
        }   
   

This documentation provides a comprehensive guide for using the Refund API to process both full and partial refunds for wallet and banking transactions.