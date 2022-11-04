<p align="center">
<img src="https://raw.githubusercontent.com/khalti/khalti-flutter-sdk/master/assets/khalti_logo.png"  width="300" alt="Khalti Payment Gateway" />
</p>

<p align="center">
<strong>Khalti Payment Gateway</strong><br>
<small>Android SDK</small>
</p>

<p align="center">
<a href="https://mvnrepository.com/artifact/com.khalti/khalti-android"><img src="https://img.shields.io/maven-central/v/com.khalti/khalti-android?color=%235C2D91" alt="Maven Central"></a>
<a href="https://docs.khalti.com/"><img src="https://img.shields.io/badge/Khalti-Docs-blueviolet" alt="Khalti Docs"></a>
<a href="https://github.com/khalti/khalti-sdk-android/blob/master/LICENSE"><img src="https://img.shields.io/badge/License-BSD--3-informational" alt="BSD-3 License"></a>
<a href="https://github.com/khalti/khalti-sdk-android/issues"><img src="https://img.shields.io/github/issues/khalti/khalti-sdk-android" alt="GitHub issues"></a>
<a href="https://khalti.com"><img src="https://img.shields.io/website?url=https%3A%2F%2Fdocs.khalti.com" alt="Website"></a>
<a href="https://github.com/khalti/khalti-sdk-android/releases"><img alt="GitHub Release Date" src="https://img.shields.io/github/release-date/khalti/khalti-sdk-android"></a>
<a href="https://www.facebook.com/khalti.official"><img src="https://img.shields.io/badge/follow--000?style=social&logo=facebook" alt="Follow Khalti in Facebook"></a>
<a href="https://www.instagram.com/khaltiofficial"><img src="https://img.shields.io/badge/follow--000?style=social&logo=instagram" alt="Follow Khalti in Instagram"></a>
<a href="https://twitter.com/intent/follow?screen_name=khaltiofficial"><img src="https://img.shields.io/twitter/follow/khaltiofficial?style=social" alt="Follow Khalti in Twitter"></a>
<a href="https://www.youtube.com/channel/UCrXM4HqK9th3E2a04Z9Lh-Q"><img src="https://img.shields.io/youtube/channel/subscribers/UCrXM4HqK9th3E2a04Z9Lh-Q?label=Subscribe&style=social" alt="Subscribe Youtube Channel"></a>
</p>

---
Welcome to Khalti Android SDK's official documentation.

!!! note "This documentation is intended for v3+ of the SDK."

    If you are looking for documentation of older versions, 
    please visit [here](https://github.com/khalti/khalti-sdk-android/blob/v2.01.01/README.md).


### Requirements
- Android API Level 16+

### Installation

#### Update your project plugins
In your root-level (project-level) Gradle file (build.gradle), add rules to include the Android Gradle plugin.
Check that you have Google's Maven repository as well.

```groovy title="build.gradle (project-level)" hl_lines="4 5"
buildscript {
	repositories {
		// Check that you have the following line (if not, add it):
		google()  // Google's Maven repository
		mavenCentral() // Include to import Khalti Android SDK
	}
	dependencies {
		// ...
	}
}
```

#### Add the Khalti Android SDK to your app
In your module (app-level) Gradle file (usually app/build.gradle), add these lines.

```groovy title="build.gradle (app-level)" hl_lines="8 9 15"
android {
	defaultConfig {
		minSdkVersion 16 // or greater
	}

	// Enable Java 8 support for the SDK to work
	compileOptions {
		sourceCompatibility JavaVersion.VERSION_1_8
		targetCompatibility JavaVersion.VERSION_1_8
	}
}

dependencies {
	// ...
	implementation 'com.khalti:khalti-android:<insert latest version>'
}
```

!!! info "Latest version"
		[![Maven Central](https://img.shields.io/maven-central/v/com.khalti/khalti-android?color=%235C2D91)](https://mvnrepository.com/artifact/com.khalti/khalti-android)

#### Register a contract for Activity Result

=== "Kotlin" 

    ``` kotlin
    private val khaltiPay = registerForActivityResult(OpenKhaltiPay()) {
        when (it) {
            is PaymentSuccess -> // Handle success
            is PaymentError -> // Handle error
            is PaymentCancelled -> // Handle cancellation
        }
    }
    ```

=== "Jetpack Compose"

    ``` kotlin
    val khaltiPay = rememberLauncherForActivityResult(OpenKhaltiPay()) {
        when (it) {
            is PaymentSuccess -> // Handle success
            is PaymentError -> // Handle error
            is PaymentCancelled -> // Handle cancellation
        }
    }
    ```

=== "Java"

    ``` java
    private ActivityResultLauncher<PaymentResult> khaltiPay = registerForActivityResult(new OpenKhaltiPay(),
      result -> {
        if (result instanceof PaymentSuccess) {
          // Handle success
        } else if (result instanceof PaymentError) {
          // Handle error
        } else {
          // Handle cancellation
        }
      }
    );
    ```


#### Launch Khalti Pay Activity

=== "Kotlin"

    ``` kotlin
    val config = KhaltiPayConfiguration(
      "https://pay.khalti.com/?pidx=id",
      "https://redirect.khalti.com"
    )

    khaltiPay.launch(config)
    ```

=== "Jetpack Compose"

    ``` kotlin
    val config = KhaltiPayConfiguration(
      "https://pay.khalti.com/?pidx=id",
      "https://redirect.khalti.com"
    )

    khaltiPay.launch(config)
    ```

=== "Java"

    ``` java
    KhaltiPayConfiguration config = new KhaltiPayConfiguration(
      "https://pay.khalti.com/?pidx=id",
      "https://redirect.khalti.com"
    )

    khaltiPay.launch(config)
    ```

!!! tip "How do I generate the payment URL?"

    Read the [Initiating Payment](https://docs.khalti.com/khalti-epayment/#initiating-a-payment-request) section,
    in order to generate the payment URL.

At this point, the pay activity will open, and will return a success result
if the user successfully completes the payment flow.

#### Server Verification
After successful client side payment, the next step is to perform server verification.

!!! note "Server verification is mandatory."

		As the client side makes the payment directly to Khalti without going through your server first, you need to be sure that the customer actually paid the money they were supposed to before completing their order.
    This type of verification can only be done securely from the server.

    Know [how to perform server verification here](https://docs.khalti.com/api/verification/).
