There are four steps for integrating Khalti payment to a merchant system.



- [1. Signup as merchant](#1-signup-as-merchant)
- [2. Understand how khalti payment works](#2-understand-khalti-payment-process)
- [3. Test integration](#3-test-integration)
	- [3.1. Client side integration](##3.1-client-side-integration)
	- [3.2. Server side integration](##3.2-server-side-integration)
- [4. Deploy integration](#4-deploy-integration)

## 1. Signup as merchant
First of all you will need a merchant and a consumer accounts.
**Merchant** is an online business service like e-commerce websites, ISP online payment, Movie online purchase etc.
**Consumer** is an end user who uses Khalti to purchase products or services from merchants.

Please follow links below to create a merchant and a consumer accounts if you have not already.

- [Create a merchant account](https://khalti.com/join/merchant/)
- [Create a consumer account](https://khalti.com/join/)

## 2. Understand Khalti payment process

![Khalti payment overview](./img/khalti-payment-new-overview.png)

### 2.1. Transaction States
#### 1. Initiated

It is the first state of a transaction. Transactions are initiated after mobile number and khalti pin along with other transaction details are provided.

#### 2. Confirmed

A transaction is confirmed after transaction details (transaction token, confirmation_code and  3rd party transaction_pin) are provided by the consumer.
[Check how to set and update khalti pin here.](https://www.youtube.com/watch?v=KeX7j_hp_sk)

#### 3. Completed

Merchant server then requests khalti server to verify the transaction. After the transaction is in completed state consumer is informed the transaction was successfully completed.

#### 4. Disabled

A transaction could be disabled due to the possibility of 'confirmation_code' exploitation.

#### 5. Refunded

A merchant can refund the successful payments within a limited period of time.

#### 6. Partially refunded

A completed transaction also can be partially refunded.

#### 7. Failed

Normally, a successful transaction has at least three changes of states initiate, confirm and complete. A client first initiates and then confirms payment while the server finally verifies it and the payment process is completed.

## 3. Test integration
Now that you know how Khalti payment works. Its time to integrate it into your system.
A merchant must complete test integration using **test keys**. Test keys start with `test_`.

In test mode, transactions are sandboxed, which means fund is not moved from a consumer to the merchant.
Khalti must to be integrated at client and server.


**Payment via E-Banking and Debit/Credit card is not supported in the test environment.** After you successfully integrate wallet, you need not to concern about E-Banking and Card payment integration.

### 3.1. Client side integration
For now there is only one way to integrate Khalti at client side, through SDKs.
We have developed SDKs for every major plaforms and we call it `Checkout`.

Checkouts provide all the necessary UIs and perform necessary processes to initiate and confirm payment.

- [Web kit](./checkout/web.md)
- [Android kit](./checkout/android.md)
- [iOS kit](./checkout/ios.md)

### 3.2. Server side integration
After user confirms payment, it has to be verified by Khalti.
**Fund from user account is moved to merchant only if verification succeeds.**
Verification must be done by the merchant server using a secret key.

- [Verification API](./api/verification.md)
- [Transaction API](./api/transaction.md)


## 4. Go live
After successful integration test, live keys will be generated in the merchant dashboard. The merchant must **replace test keys with live ones**.
Live keys start with `live_X`. Replace `test_public_X` and `test_secret_X` keys with `live_public_X` and `live_secret_X` keys respectively.

### 4.1. Further processes
Even successful integration itself doesn't let you receive payments above NRs. 1000 per transaction. Please fill KYC form and contact us at 9801165568 to remove the limits and accept payments without restrictions.
