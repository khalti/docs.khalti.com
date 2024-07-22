# iOS SDK

[![IDE](https://img.shields.io/badge/Xcode-8%209%2010Beta-blue.svg)](https://developer.apple.com/xcode/)
[![Language](https://img.shields.io/badge/swift-3,%204-orange.svg)](https://swift.org)
[![Version](https://img.shields.io/cocoapods/v/Khalti.svg?style=flat)](http://cocoapods.org/pods/Khalti)
[![License](https://img.shields.io/cocoapods/l/Khalti.svg?style=flat)](http://cocoapods.org/pods/Khalti)
[![Platform](https://img.shields.io/cocoapods/p/Khalti.svg?style=flat)](http://cocoapods.org/pods/Khalti)


This documentation details the process to integrate Khalti payment gateway
in your iOS app.


## Example

**Swift** : Clone project and use 'Example' directory. Do 'pod install'.

**Objective-C** :  Clone project and use 'Example Obj-c' directory. Do 'pod install'.

## Installation guide

Khalti is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```swift
pod 'Khalti'
```
## Usage

### Adding CustomSchme
Khalti uses custom Scheme: So merhant should setup **URLScheme** unique for their app. We have made usability as of user case.

![Khalti scheme setup overview](https://raw.githubusercontent.com/khalti/khalti-sdk-ios/master/Screenshots/customUrlScheme.png)

After adding Url Scheme create global constant for same customUrlScheme as below
```swift
let khaltiUrlScheme:String = "KhaltiPayExampleScheme"
```

### Requirements
To work around with this redirection you have to implement some openUrl in ```Appdelegate.swift```.

```Khalti.shared.defaultAction()``` returns `true` if you initiate payment through Khalti.
```Khalti.shared.action(with: url)``` is needed for complete action after ebanking and card payment.

**Note:** Using ```Khalti.shared.action(with: url)```  is mandatory.

Add following code to `Appdelegate.swift`
```swift
 func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    Khalti.shared.action(with: url)
    return Khalti.shared.defaultAction() // Or true
}
```


### Using at particular ViewController
At your viewController during action of pay add initiate config file

When instantiating `Config`  pass public key, product id, product name, amount (in paisa).
Product web url and additional data are optional.
```swift
let TEST_CONFIG:Config = Config(publicKey: khaltiMerchantKey, amount: 1000, productId: "1234567890", productName: "Dragon_boss", productUrl: "http://gameofthrones.wikia.com/wiki/Dragons",additionalData: additionalData)
// Data passed here are based on Example project
```

**Note:**  Public is provided to every merchant of khalti. Intially test is available to every merchant and live key is provided after MoU signup with Khalti.


At this stage the scheme named you declared earlier is passed to `Khatli.shared.appUrlScheme`

```swift
Khalti.shared.appUrlScheme = khaltiUrlScheme // see above for file khaltiUrlScheme
// This can be used at appdelegate during didfinishlaunching.
// This should be mandatory
```

 Finally present the khaltiPay Viewcontroller by calling public funcation
```swift
Khalti.present(caller: self, with: TEST_CONFIG, delegate: self)
```

 **Params of present function of Khalti**

| param                    |        Value                                    |
|--------------------------|-------------------------------------------------|
| caller                   | viewController  from where you initate payment. |
| with                     | Config object                                   |
| delegate                 | self                                            |

  Delegate must be assigned to same Viewcontroller to get callback action from KhaltiPayDelegate.


### Example as used in Example Project
```swift
let extra:[String : Any] =  ["no":false,"yes":true,"int" : 0, "float":12.23]

let jsonData = try? JSONSerialization.data(withJSONObject: extra, options: JSONSerialization.WritingOptions())
let jsonString = String(data: jsonData!, encoding: .utf8)!

let additionalData:Dictionary<String,String> = [
    "merchant_name" : "HelloPaaaaisaPVTLtd.",
    "merchant_extra" : jsonString
]

Khalti.shared.appUrlScheme = khaltiUrlScheme
let khaltiMerchantKey = "test_public_key_dc74e0fd57cb46cd93832aee0a507256" // This key is from local server so it won't work if you use the example as is it. Use your own public test key

let TEST_CONFIG:Config = Config(publicKey: khaltiMerchantKey, amount: 1000, productId: "1234567890", productName: "Dragon_boss", productUrl: "http://gameofthrones.wikia.com/wiki/Dragons",additionalData: additionalData, cardPayment:false)
Khalti.present(caller: self, with: TEST_CONFIG, delegate: self)
```
Config file has property cardPayment with default value false, indication the cardPayment facility is OFF. If you want cardPayment available to your users then set cardPayment option to true while creating config object. Please read merchant terms and conditions before enabling this feature.
Additionally, Config class also accepts a Dictionary<String,String> which you can use to pass any additional data. Make sure you add a `merchant_` prefix in your map key.

### Using delegates
The viewController you implement pay action should contain KhaltiPayDelegate implementing
 `onCheckOutSuccess(data: Dictionary<String, Any>)`
 `onCheckOutError(action: String, message: String)`


```swift
extension YourViewController: KhaltiPayDelegate {
    func onCheckOutSuccess(data: Dictionary<String, Any>) {
        print(data)
        print("Oh there is success message received")
    }

    func onCheckOutError(action: String, message: String) {
        print(action)
        print(message)
        print("Oh there occure error in payment")
    }
}
```

## Summary


#### Callback Methods

| Method                                   | Description                                                                                                                                                                                                                                                                                                                                                                           |
|------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `onCheckOutSuccess(data: Dictionary<String, Any>)`                | This method is called when a transaction has been completed and confirmed by the user. A dictionary containing an access token, required to verify the transaction and data passed through Config instance is returned. Once this method is called, use the access token to verify the transaction. Please follow the [verification](http://docs.khalti.com/api/verification/) process for further instructions. |
| `onCheckOutError(action: String, message: String, data:Dictionary<String,Any>?)` | This method is called when an error occurs during payment initiation and confirmation. Action, message and errordata value is passed where action defines, the current action being performed, message defines the error and data defines the errorData associated with error if exists.                                                                                                                                              |


##### Response Sample
###### Success Messsage
| Key               |        Value                 |            Type         |
|-------------------|------------------------------|-------------------------|
| mobile            | 98XXXXXXXX                   |           String        |
| product_name      | Product Name                 |           String        |
| product_identity  | Product Id                   |           String        |
| product_url       | Product Url                  |           String        |
| amount            | 100                          |            Int          |
| token             | token                        |           String        |
| cardPayment       | false                        |           Bool          |

The success message also contains all the `key` and `value` provide as extra data while initiating `Config`.

###### Error Messsage
|  Variable                 | Description                            |    Type   |
|---------------------------|----------------------------------------|-----------|
| action                       | initiate/confirm/ebanking             |   String  |
| message                   | Detail Error Message                   |   String  |
| data                          | data of error   (Optional)               |   Dictionary<String,Any>?  |

## Support

For Queries, feel free to mail us at: [merchant@khalti.com](mailto:merchant@khalti.com?cc=ios@khalti.com,rajendrakarki@khalti.com,bikashgiri@khalti.com,developers@khalti.com,support@khalti.com)

<!-- Check out the source for Khalti checkout on [github ](https://github.com/khalti/khalti-sdk-ios/). -->
Check out the [API Documentation](http://docs.khalti.com/checkout/ios/).
