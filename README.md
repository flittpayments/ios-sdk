# Flitt iOS SDK - Apple Pay Integration Guide

This guide provides implementation instructions for integrating Apple Pay in your iOS application using the Flitt iOS SDK.

## Prerequisites

- iOS 10.0 or higher (iOS 11.0+ recommended for best Apple Pay experience)
- Xcode 12.0 or higher
- A Flitt merchant account
- Apple Developer account with Apple Pay merchant ID

## Initial Setup

For detailed instructions on setting up your Apple Developer account, registering a merchant ID, and configuring your Xcode project for Apple Pay, please refer to our official documentation:

[Flitt iOS SDK Documentation](https://docs.flitt.com/api/mobile/apple-ios-swift/)

The documentation above covers:
- Creating and registering a merchant identifier
- Setting up the Apple Pay capability in your Xcode project
- Configuring the necessary certificates
- Required Info.plist entries

## Step 3: Install the Flitt SDK

### Using CocoaPods

Add the following to your Podfile:

```ruby
pod 'Flitt'
```

Then run:

```bash
pod install
```

### Using Swift Package Manager

Add the package dependency to your Package.swift file:

```swift
dependencies: [
    .package(url: "https://github.com/flittpayments/ios-sdk", from: "1.0.0")
]
```

## Step 4: Initialize the Flitt SDK

```swift
import UIKit
import Flitt

class PaymentViewController: UIViewController {
    
    private var flittApi: PSCloudipspApi!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlitt()
    }
    
    private func setupFlitt() {
        let flittView = PSCloudipspWKWebView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.width, height: self.view.bounds.height))
    
        view.addSubview(flittView)
        
        // Initialize with your merchant ID from the Flitt dashboard
        flittApi = PSCloudipspApi(merchant: YOUR_MERCHANT_ID, andCloudipspView: flittView)
    }
}
```

## Step 5: Implement Apple Pay

### Method 1: Standard Apple Pay Flow

This is the recommended implementation that creates an order and processes payment in one step:

```swift
import UIKit
import Flitt

class PaymentViewController: UIViewController, PSApplePayCallbackDelegate, PSPayCallbackDelegate {
    
    private var flittApi: PSCloudipspApi!
    
    // Create an order object
    private var order: PSOrder {
        return PSOrder(
            order: AMOUNT_IN_CENTS, // e.g., 1000 for $10.00
            aStringCurrency: "USD",  // Currency code
            aIdentifier: UUID().uuidString, // Unique order ID
            aAbout: "Product Description"
        )
    }
    
    // MARK: - Payment Action
    @objc private func handleApplePayTap() {
        if PSCloudipspApi.supportsApplePay() {
            flittApi.applePay(order, andDelegate: self)
        } else {
            showApplePayNotSupportedAlert()
        }
    }
    
    // MARK: - PSApplePayCallbackDelegate
    func onApplePayNavigate(_ viewController: UIViewController!) {
        print("Apple Pay sheet is ready to present")
        present(viewController, animated: true)
    }
    
    // MARK: - PSPayCallbackDelegate
    func onPaidProcess(_ receipt: PSReceipt!) {
        print("Payment processed successfully: \(receipt)")
        // Handle successful payment - update UI, navigate to success screen, etc.
        // Note: The Apple Pay sheet dismisses automatically
    }
    
    func onPaidFailure(_ error: Error!) {
        print("Payment failed: \(error.localizedDescription)")
        // Handle payment failure
    }
    
    func onWaitConfirm() {
        print("Waiting for confirmation")
    }
    
    private func showApplePayNotSupportedAlert() {
        let alert = UIAlertController(
            title: "Apple Pay Not Available",
            message: "This device doesn't support Apple Pay payments.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
```

### Method 2: Using a Payment Token

For more control or to split the authorization and capture steps:

```swift
import UIKit
import Flitt

class TokenPaymentViewController: UIViewController, PSApplePayCallbackDelegate, PSPayCallbackDelegate {
    
    private var flittApi: PSCloudipspApi!
    
    @objc private func handleApplePayWithTokenTap() {
        if PSCloudipspApi.supportsApplePay() {
            // Use a pre-generated payment token from the Flitt API
            flittApi.applePay(withToken: "YOUR_PAYMENT_TOKEN", andDelegate: self)
        } else {
            showApplePayNotSupportedAlert()
        }
    }
    
    // Implement delegate methods as shown in Method 1
}
```

## Step 6: Test Your Integration

1. **Sandbox Testing**:
    - Use Apple's sandbox environment for testing
    - Add test cards to your Wallet app on your test device
    - Test the complete payment flow

2. **Test Devices**:
    - Always test on physical devices, not just simulators
    - Test on different iOS versions if possible
    - Verify correct behavior on both iPhone and iPad

## Handling Common Issues

### "Payment Not Completed" Error

If users see "Payment Not Completed" in the Apple Pay sheet despite successful payment processing:

1. **Check Error Logs**: Look for errors including `com.apple.extensionKit.errorDomain` or `RBSRequestErrorDomain`
2. **Verify Payment Credentials**: Ensure test cards are valid in the sandbox environment
3. **Add Apple Pay Completion Handling**: Make sure your delegate methods correctly handle the completion flow
4. **Check Device Configuration**: Verify Apple Pay is properly set up on the test device
5. **Contact Flitt Support**: If the issue persists, contact Flitt with your merchant ID and transaction logs

### Other Common Issues

1. **Apple Pay Sheet Not Appearing**:
    - Check that you've implemented `onApplePayNavigate` and are presenting the view controller
    - Verify Apple Pay entitlements in your app

2. **Currency Not Supported**:
    - Verify your merchant account supports the currency you're using
    - Test with a currency that's definitely supported by your account

3. **Payment Success Not Detected**:
    - Ensure you've implemented all delegate methods
    - Check that the order amount is within acceptable limits

## Best Practices

1. **Testing**: Always test with both the sandbox environment and real devices
2. **Error Handling**: Implement comprehensive error handling for a smooth user experience
3. **Localization**: Support multiple currencies and localize payment information
4. **Security**: Never store sensitive payment information in your app

## Support

For additional support, contact Flitt at support@flitt.com
