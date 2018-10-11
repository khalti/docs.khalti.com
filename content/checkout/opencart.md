# Opencart

This is Khalti Payment Gateway extension for Opencart.

Check out the source for [Khalti plugin on Github](https://github.com/khalti/khalti-opencart).

## Installation ##

The basic steps to follow:

- Go to `Extension > Installer` in your admin dashboard
- Upload the zip file of module ([link](https://github.com/khalti/khalti-opencart))

![Upload extension](../img/opencart/upload.png)

- Now after successful upload go to `Extensions > Extensions`
- Choose `Payment` on extension type section you will get a list with Khalti in it.
- Select to edit button. You will see fields as below.

![Extension lists](../img/opencart/khalti_extension.png)

- Set `Test mode` to *Yes* and Status to *Enabled*. Enter your test public key and test secret key in respective fields and save. You can get keys from `Keys` section in your merchant dashboard

![Set up](../img/opencart/setup.png)

- After successful upload go to `Design > Theme Editor` in dashboard side nav
- Select `common > header.twig` from `Choose a template` section
```
<script  "https://khalti.com/static/khalti-checkout.js" type="text/javascript"></script>
```
- Add above line  in `header.twig` and save.

![header.twig](../img/opencart/khalti_chackout.png)

*you may need to manage permission of your project folders*

*if downloaded zip is not compatible try compressing to zip after you uncompressing it*

#### Manual Installation ####
- Extract the zip file.
- Copy all files on the root directory of project
- add script with src "https://khalti.com/static/khalti-checkout.js" on your themes header file which is located on "catalog/view/theme/YOUR_THEME_NAME/common/header.twig
- clear Opencart cache

## Testing ##

- Before testing set default currency to Nepalese Rupee. ([How](https://www.opencart.com/blog?page=4&blog_id=228))
- Go to your shop and complete a transaction from Wallet payment type.

## Deploy ##

- If a test is passed successfully, go to keys section in your merchant dashboard. You will get your Live keys there.
- Uncheck the Test Mode and enter your public and secret keys in respective fields
- Finally save the changes.
