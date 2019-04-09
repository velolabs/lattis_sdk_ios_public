# Lattis SDK for iOS
![Xcode](https://img.shields.io/badge/Xcode-10-blue.svg) ![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg) ![platform](https://img.shields.io/badge/platform-iOS%2010.0%2B-lightgrey.svg)
## Dependencies

* Oval.framework (Lattis networking API)
* [KeychainSwift](https://github.com/evgenyneu/keychain-swift.git)

## Installation

Add this line to your **Podfile**
```PodFile
pod 'LattisSDK'
```
run
```
pod install
```

> If you have any errors with previous step please run

`pod repo update`

> If you want to use previous version use tag `v1.1.5` or

`pod 'LattisSDK', '1.1.5'`

## Usage

Add **LattisSDKToken** (String) to you **Info.plist**

### Import
```swift
import LattisSDK
```
### Delegates
```swift
public protocol EllipseManagerDelegate: class {

    func manager(_ lockManager: EllipseManager, didRestoreConnected locks: [Ellipse])
    // Called when new locks discovered or old ones become not available
    // insert - contains only newly discovered locks
    // delete - contains not reachable locks
    // you can use lockManager.locks to get whole list of available locks
    func manager(_ lockManager: EllipseManager, didUpdateLocks insert: [Ellipse], delete: [Ellipse])

    // Called when state of bluetooth is changing
    func manager(_ lockManager: EllipseManager, didUpdateConnectionState connected: Bool)
}

public protocol EllipseDelegate: class {

    // Called when connection state of lock is changing
    // connection - represents current connection state of the lock
    func ellipse(_ ellipse: Ellipse, didUpdate connection: Ellipse.Connection)

    // Called when lock's security state changing (lock/unlock/etc)
    func ellipse(_ ellipse: Ellipse, didUpdate security: Ellipse.Security)

    // Called when lock's dynamic values changing (magnitude/battery level/RSSI)
    func ellipse(_ ellipse: Ellipse, didUpdate value: Ellipse.Value)
}
```

### Find locks
```swift
EllipseManager.shared.scan(with: self)
```

or you can subscribe to `EllipseManager` updates if `scan()` was already called from other class.
```swift
EllipseManager.shared.subscribe(handler: self)
```

* `self` (or any other object instance)  should confirm to `EllipseManagerDelegate` protocol

Call
```swift
EllipseManager.shared.stopScan()
```
if you don't need to discover new locks anymore.

You don't need to unsubscribe classes from `EllipseManager` updates. It will be done automatically. There is no strong references to handlers.

### Connect to the lock
```swift
let ellipse: Ellipse = EllipseManager.shared.locks.first
ellipse?.connect(handler: self)
```

or you can subscribe to lock updates if it's already connected
```swift
ellipse?.subscribe(self)
```

* `self` (or any other object instance)  should confirm to `EllipseDelegate` protocol

Call
```swift
ellipse?.disconnect()
```
if you want to disconnect the lock.

### Other features

#### Manage captive touch panel (FW => 2.75)

You can disable or enable captive touch panel
```swift
ellipse?.isCapTouchEnabled = false // true by default
```
* `isCapTouchEnabled == nil` means you don't have it's state yet. You can receive updates for that value in `didUpdate value` delegate method

#### Manage magnet auto lock (FW => 2.75)
You can  manage magnetometer based auto lock feature
```swift
ellipse?.isMagnetAutoLockEnabled = true // false by default
```
* `isMagnetAutoLockEnabled == nil` means you don't have it's state yet. You can receive updates for that value in `didUpdate value` delegate method. No specific case for the value, just catch case for the Captive Touch value and check `ellipse?.isMagnetAutoLockEnabled`

#### Shackle position check (FW => 2.75)
You can check if shackle is inserted or not.
```swift
ellipse?.isShackleInserted
```
You can receive updates for that value in `didUpdate value` delegate method.

## Example
You can find `Lattis Demo` directory in the root of this repository. It contains live demo project, demonstrating SDK API's usage.

## Restrictions

Frameworks is Universal (iOS Simulator support). You won't be able to upload your app with this framework to the AppStore. You can find a solution [here]( https://stackoverflow.com/questions/49927498/ios-carthage-submit-to-app-store-issues-unsupported-architecture-invalid-segme).
Framework now have partial support for Objective-C.
Objective-C support restrictions related to using nested types and enum associated values.
To use this all the features with Objective-C code you should write a Swift wrapper.
