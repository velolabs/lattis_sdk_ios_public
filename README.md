# Lattis SDK for iOS

## Requirements

* Oval.framework (Lattis networking API)
* CommonCrypto.framework
* [KeychainSwift](https://github.com/evgenyneu/keychain-swift.git)

## Installation

Add this line to your **Podfile**

`pod 'LattisSDK', '1.1.3'`

run

`pod install`

> Note:
If you have any errors with previous step please run
`pod repo update`

## Usage

Add **LattisSDKToken** (String) to you **Info.plist**

## Example
You can find `Lattis Demo` directory in the root of this repository. It contains live demo project, demonstrating SDK API's usage. 

## Restrictions

Frameworks are build for iOS devices only. This dependency can't be used on iOS Simulator
