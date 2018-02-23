# Khalti

[![CI Status](http://img.shields.io/travis/rjndra/Khalti.svg?style=flat)](https://travis-ci.org/rjndra/Khalti)
[![Version](https://img.shields.io/cocoapods/v/Khalti.svg?style=flat)](http://cocoapods.org/pods/Khalti)
[![License](https://img.shields.io/cocoapods/l/Khalti.svg?style=flat)](http://cocoapods.org/pods/Khalti)
[![Platform](https://img.shields.io/cocoapods/p/Khalti.svg?style=flat)](http://cocoapods.org/pods/Khalti)

## Relased version 0.1.2 Under Development with release version 0.1.2

Khalti is currently under development. Pod has already been released but updates are under process. Documentation will soon be available. Anyone intreseted can check the example and whole code to start integration Khalti.

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


![Khalti scheme setup overview](https://github.com/khalti/khalti-sdk-ios/blob/master/Screenshots/customUrlScheme.png)

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

## Author

Khalti

## License

Khalti is available under the MIT license. See the LICENSE file for more info.
