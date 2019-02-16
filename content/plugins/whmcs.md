#   Official Khalti module for WHMCS
This is third party gateway modules to integrate Khalti payment solution with the WHMCS platform.

## Installation
1. Download the ZIP (or tar.gz) file from the releases [See the releases](https://github.com/khalti/whmcs-khaltigateway-plugin/releases)
2. Simply extract at the root folder of your WHMCS installation. Following files will be copied

## File Structure
```
modules /
 | gateways /
   | khaltigateway.php
   | callback /
       | khaltigateway.php
   | khaltigateway /
      | common.php
      | index.php
      | init.php
      | step2.php
```
   (Basically, the plugin creates
   - file khaltigateway.php under modules/gateways directory of your root installation,
   - directory khaltigateway/ under modules/gateways directory of your root installation
   - file khaltigateway.php under modules/gateways/callback directory of your root installation. (This file is kept just to maintain the convention that WHMCS suggests)

## Activate
Login to admin area of your WHMCS installation and enable the gateway from
``Setup -> Payments -> Payment Gateways``
(Refer to the image below)
![Enabling Gateway](https://raw.githubusercontent.com/khalti/whmcs-khaltigateway-plugin/master/modules/gateways/khaltigateway/assets/enable.png)

## Configure
Once the gateway is enabled, the gateway parameters need to be configured.
(Refer to the image below)
![Configuring Khalti Payment Gateway](https://raw.githubusercontent.com/khalti/whmcs-khaltigateway-plugin/master/modules/gateways/khaltigateway/assets/configure.png)
PS: Please make sure that the currency "NPR" is selected for the option "Convert to For Processing"
