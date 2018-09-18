# Lattis SDK for iOS
![Xcode](https://img.shields.io/badge/Xcode-10-blue.svg) ![Swift](https://img.shields.io/badge/Swift-4.2-orange.svg) ![platform](https://img.shields.io/badge/platform-iOS%2010.0%2B-lightgrey.svg)
## Dependencies

* Oval.framework (Lattis networking API)
* [KeychainSwift](https://github.com/evgenyneu/keychain-swift.git)

## Installation

Add this line to your **Podfile**
`pod 'LattisSDK'`
run
`pod install`

> If you have any errors with previous step please run
`pod repo update`

> If you want to use previous version use tag `v1.0.5` or
`pod 'LattisSDK', '1.0.5'`

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

or you can unsubscribe to lock updates if it's already connected
```swift
ellipse?.subscribe(self)
```

* `self` (or any other object instance)  should confirm to `EllipseDelegate` protocol

Call
```swift
ellipse?.disconnect()
```
if you want to disconnect the lock.

## Example
You can find `Lattis Demo` directory in the root of this repository. It contains live demo project, demonstrating SDK API's usage.

## Restrictions

Frameworks are build for iOS devices only. This dependency can't be used on iOS Simulator
