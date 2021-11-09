# Khalti Flutter SDK (without Payment Interface)
Khalti Payment Gateway SDK for Flutter without payment interface, a custom user interface is required.

---

<p align="center">
<img src="https://raw.githubusercontent.com/khalti/khalti-flutter-sdk/master/assets/khalti_logo.png" height="150" alt="Khalti Payment Gateway" />
</p>

<p align="center">
<strong>Khalti Payment Gateway</strong>
</p>

<p align="center">
<a href="https://pub.dartlang.org/packages/khalti"><img src="https://img.shields.io/pub/v/khalti" alt="Pub"></a>
<a href="https://docs.khalti.com/"><img src="https://img.shields.io/badge/Khalti-Docs-blueviolet" alt="Khalti Docs"></a>
<a href="https://github.com/khalti/khalti-flutter-sdk/blob/master/LICENSE"><img src="https://img.shields.io/badge/License-BSD--3-informational" alt="BSD-3 License"></a>
<a href="https://github.com/khalti/khalti-flutter-sdk/issues"><img src="https://img.shields.io/github/issues/khalti/khalti-flutter-sdk" alt="GitHub issues"></a>
<a href="https://khalti.com"><img src="https://img.shields.io/website?url=https%3A%2F%2Fdocs.khalti.com" alt="Website"></a>
<a href="https://www.facebook.com/khalti.official"><img src="https://img.shields.io/badge/follow--000?style=social&logo=facebook" alt="Follow Khalti in Facebook"></a>
<a href="https://www.instagram.com/khaltiofficial"><img src="https://img.shields.io/badge/follow--000?style=social&logo=instagram" alt="Follow Khalti in Instagram"></a>
<a href="https://twitter.com/intent/follow?screen_name=khaltiofficial"><img src="https://img.shields.io/twitter/follow/khaltiofficial?style=social" alt="Follow Khalti in Twitter"></a>
<a href="https://www.youtube.com/channel/UCrXM4HqK9th3E2a04Z9Lh-Q"><img src="https://img.shields.io/youtube/channel/subscribers/UCrXM4HqK9th3E2a04Z9Lh-Q?label=Subscribe&style=social" alt="Subscribe Youtube Channel"></a>
</p>

---

## Want easier integration?
This package only provides set of methods for client integration of Khalti Payment Gateway.

If custom UI is not required then prefer using [khalti_flutter](https://pub.dev/packages/khalti_flutter) instead.

## Setup

### Set up public key
The first step is to grab public key from merchant dashboard. Read the [getting started](https://docs.khalti.com/getting-started/)
to learn about the integration process and grabbing public key.

```dart
  KhaltiService.publicKey = <your-public-key-here>;
```

Note: _During integration, use test keys instead of live one._

### Initiating payment using Wallet

```dart
final service = KhaltiService(client: KhaltiHttpClient());

final initiationModel = await service.initiatePayment(
    request: PaymentInitiationRequestModel(
      amount: 1000, // in paisa
      mobile: <khalti-mobile-number>,
      productIdentity: 'mac-mini',
      productName: 'Apple Mac Mini',
      transactionPin: <khalti-mpin>,
      productUrl: 'https://khalti.com/bazaar/mac-mini-16-512-m1',
      additionalData: {
        'vendor': 'Oliz Store',
        'manufacturer': 'Apple Inc.',
      },
    ),
  );
```

After successful call to the method, an OTP is sent to the mobile number provided.


### Confirming Transaction

```dart
final confirmationModel = await service.confirmPayment(
  request: PaymentConfirmationRequestModel(
    confirmationCode: <otp-code>, // the OTP code received through previous step
    token: initiationModel.token,
    transactionPin: <khalti-mpin>,
  ),
);
```

### Building URL for bank payment

```dart
final bankPaymentUrl = service.buildBankUrl(
    bankId: '1234567890',
    amount: 1000,
    mobile: mobile,
    productIdentity: 'macbook-pro-21',
    productName: 'Macbook Pro 2021',
    paymentType: BankPaymentType.eBanking,
  );
```

The URL obtained can be launched using [url_launcher](https://pub.dev/packages/url_launcher)
and the Khalti server will redirect your client to bank portal where user can access e-banking,
finally redirecting back to original/parent page with the response.

### Fetching available banks for receiving payment

```dart
final banks = await service.getBanks(paymentType: BankPaymentType.eBanking);
```

## Khalti Docs
Visit [https://docs.khalti.com/](https://docs.khalti.com/).

## License
```
Copyright (c) 2021 The Khalti Authors. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Sparrow Pay Pvt. Ltd. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
