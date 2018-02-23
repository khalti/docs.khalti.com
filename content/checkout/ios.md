# Khalti

[![CI Status](http://img.shields.io/travis/rjndra/Khalti.svg?style=flat)](https://travis-ci.org/rjndra/Khalti)
[![Version](https://img.shields.io/cocoapods/v/Khalti.svg?style=flat)](http://cocoapods.org/pods/Khalti)
[![License](https://img.shields.io/cocoapods/l/Khalti.svg?style=flat)](http://cocoapods.org/pods/Khalti)
[![Platform](https://img.shields.io/cocoapods/p/Khalti.svg?style=flat)](http://cocoapods.org/pods/Khalti)

## Relase 0.1.2

Pod has already been released but updates are under process. Documentation will soon be available. Anyone intreseted can check the example and whole code to start integration Khalti.

## Pod Depedency 
Khalti has currenlty depenceny on  ```Alamofire```.
This dependency will be soon be removed.

For best working with UI incorporated in this library ```IQKeyboardManager``` is used. Suggest using 
```ruby
pod 'IQKeyboarManager'
```

So installation of ```Khalti``` provides automatically dependency pod ```Alamofire``` but use of ```IQKeyboardManager``` is up to you.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation guide

Khalti is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Khalti'
```
## Usage
Khalti uses custom Scheme: So merhant should setup **URLScheme** unique for their app. We have made usability as of user case.


![Khalti scheme setup overview](../img/customUrlScheme.png)

After adding Url Scheme create global constant for same customUrlScheme as below 
```ruby
let khaltiUrlScheme:String = "KhaltiPayExampleScheme"
```


To work around with this redirection you have to implement some openUrl in ```Appdelegate.swift```. 
```Khalti.shared.defaultAction()``` returns true if you initiate payment through Khalti.
```Khalti.shared.action(with: url)``` is needed for complete action after ebanking and card payment. 

**Note:** If ```Khalti.shared.defaultAction()```  is missed delegate ```onCheckOutSuccess(data: Dictionary<String, Any>)``` might not work properly.

In ```Appdelegate.swift```
```ruby
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        Khalti.shared.action(with: url)
        return Khalti.shared.defaultAction()
    }
```


At your viewController during action of pay add initiate config file

When instantiating `Config`  pass public key, product id, product name, amount (in paisa).
product web url and additional data are optional.


At this stage the scheme named you declared earlier is passed to Khatli.shared.appUrlScheme
 ```ruby 
 Khalti.shared.appUrlScheme = khaltiUrlScheme // see above for file khaltiUrlScheme
 ```

 Finally present the khaltiPay Viewcontroller by calling public funcation 
  ```ruby
  Khalti.present(caller: self, with: TEST_CONFIG, delegate: self)
  ```

 **Params of presnt function of Khalti **

| param               |        Value                                    |
|---------------------|-------------------------------------------------|
| caller              | viewController  from where you initate payment. |
| with                | Config object                                   |
| delegate            | self                                            |

  Delegate must be assigned to same Viewcontroller to get callback action from KhaltiPayDelegate.


**Example as used in Example Project**
```ruby
        let extra:[String : Any] =  ["no":false,"yes":true,"int" : 0, "float":12.23]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: extra, options: JSONSerialization.WritingOptions())
        let jsonString = String(data: jsonData!, encoding: .utf8)!
        
        let additionalData:Dictionary<String,String> = [
            "merchant_name" : "HelloPaaaaisaPVTLtd.",
            "merchant_extra" : jsonString
         ]
        
        Khalti.shared.appUrlScheme = khaltiUrlScheme
        let khaltiMerchantKey = "test_public_key_dc74e0fd57cb46cd93832aee0a507256"
        
        let TEST_CONFIG:Config = Config(publicKey: khaltiMerchantKey, amount: 1000, productId: "1234567890", productName: "Dragon_boss", productUrl: "http://gameofthrones.wikia.com/wiki/Dragons",additionalData: additionalData)
        Khalti.present(caller: self, with: TEST_CONFIG, delegate: self)
```

Additionally, Config class also accepts a Dictionary<String,String> which you can use to pass any additional data. Make sure you add a `merchant_` prefix in your map key.


The viewController you implement pay action should contain KhaltiPayDelegate implementing

 `onCheckOutSuccess(data: Dictionary<String, Any>)`
 `onCheckOutError(action: String, message: String)`

 **Success: Params**
 	Contains `data` of type `Dictionary<String,String>` extact replication of `config` object with extra param `token`

 **Error: Params**
 	Contains `message` as error messasge 
 	`action` is received as `""` as in this version. 

```ruby

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
| `onCheckOutSuccess(data: Dictionary<String, Any>)`                | This method is called when a transaction has been completed and confirmed by the user. A dictionary containing an access token, required to verify the transaction and data passed through Config instance is returned. Once this method is called, use the access token to verify the transaction. Please follow the [verification](./../api/verification.md) process for further instructions. |
| `onCheckOutError(action: String, message: String)` | This method is called when an error occurs during payment initiation and confirmation. Action and message value is passed where action defines, the current action being performed and message defines the error.                                                                                                                                                                      |


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

The success message also contains all the `key` and `value` provide as extra data while initiating `Config` 

###### Error Messsage
|  Variable                 | Description                            |    Type   |
|---------------------------|----------------------------------------|-----------|   
| action                    | Action performed - initiate, confirm   |   String  |
| message                   | Detail Error Message                   |   String  |


## Author

Khalti

## License

Khalti is available under the MIT license. See the LICENSE file for more info.

Check out the source for [Khalti checkout on Github](https://github.com/khalti/khalti-sdk-ios).

