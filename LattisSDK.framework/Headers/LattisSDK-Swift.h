// Generated by Apple Swift version 5.0.1 (swiftlang-1001.0.82.4 clang-1001.0.46.5)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <Foundation/Foundation.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import CoreBluetooth;
@import Foundation;
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="LattisSDK",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif




SWIFT_CLASS("_TtC9LattisSDK7Ellipse")
@interface Ellipse : NSObject
/// Ellipse unique identifier for internal Lattis services
/// warning:
/// Not the same as Bluetoothd device Mac Address
@property (nonatomic, readonly, copy) NSString * _Nonnull macId;
/// GATT Server name
@property (nonatomic, readonly, copy) NSString * _Nonnull name;
/// Convenience property; Only checks if device is pared
@property (nonatomic, readonly) BOOL isPaired;
/// Convinience property; Check if FW update is finished
@property (nonatomic, readonly) BOOL isUpdated;
@property (nonatomic, readonly, copy) NSString * _Nullable firmwareVersion;
@property (nonatomic, readonly, copy) NSString * _Nullable bootloaderVersion;
@property (nonatomic, readonly, copy) NSString * _Nullable serialNumber;
@property (nonatomic, readonly) BOOL isFactoryMode;
- (void)disconnect;
/// Call this to secure the lock
/// If lock is already in secure state it will notify all handlers with actual security state
- (void)lock;
/// Call this to unsecure the lock
/// If lock is already in unsecure state it will notify all handlers with actual security state
- (void)unlock;
/// Enable automatic locks
/// This feature based on RSSI/connection
/// It will lock automatically when disconnected from the lock or too far from it based on RSSI streingh
- (void)enableAutoLock;
/// Asynchronos read of actual security state
/// Response will come in delegate method
- (void)checkSecurityStatus;
- (BOOL)updateWithContentsOf:(NSURL * _Nonnull)url error:(NSError * _Nullable * _Nullable)error;
/// Strart Firmware update. You can handle the progress in delegate methods (self.connection == .updating(Float))
/// \param firmware Prepared bytes array
///
- (void)updateWithFirmware:(NSArray<NSNumber *> * _Nonnull)firmware;
/// Remove all the cached values (signed message, challenge key)
- (void)cleanCache;
/// Reset the lock to the factory mode (remove public key)
/// \param disconnect use true if you don’t want to reconnect automatically after reset
///
- (void)factoryResetWithDisconnect:(BOOL)disconnect;
/// Reboot the lock
- (void)bootReset;
/// Check if shackle is insertet to the lock
@property (nonatomic) BOOL isShackleInserted;
/// Set only property
/// set true to start blinking, it won’t stop automatically
/// will stop after disconnect or if you set false to the property
@property (nonatomic) BOOL isLEDBlinking;
/// Async read of actual captive touch state
/// Handle response in delegate methotds
- (void)readCapTouchState;
/// Starts blinking LEDs. No pairing requered. You can call it even for disconnected lock
/// \param completion callback received when LEDs stop blinking or Error occured
///
- (void)flashLEDWithCompletion:(void (^ _Nullable)(NSError * _Nullable))completion;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end





@class CBService;
@class CBCharacteristic;

@interface Ellipse (SWIFT_EXTENSION(LattisSDK)) <CBPeripheralDelegate>
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didDiscoverServices:(NSError * _Nullable)error;
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didDiscoverCharacteristicsForService:(CBService * _Nonnull)service error:(NSError * _Nullable)error;
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didWriteValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic error:(NSError * _Nullable)error;
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didUpdateValueForCharacteristic:(CBCharacteristic * _Nonnull)characteristic error:(NSError * _Nullable)error;
- (void)peripheral:(CBPeripheral * _Nonnull)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic * _Nonnull)characteristic error:(NSError * _Nullable)error;
@end



@protocol LSEllipseDelegate;
enum LSEllipseConnection : NSInteger;
enum LSEllipseSecurity : NSInteger;

@interface Ellipse (SWIFT_EXTENSION(LattisSDK))
- (void)connectWithHandler:(id <LSEllipseDelegate> _Nonnull)handler;
- (void)subscribe:(id <LSEllipseDelegate> _Nonnull)handler;
- (void)unsubscribe:(id <LSEllipseDelegate> _Nonnull)handler;
@property (nonatomic, readonly) enum LSEllipseConnection connectionState;
@property (nonatomic, readonly) enum LSEllipseSecurity securityState;
@property (nonatomic) BOOL objcIsCapTouchEnabled;
@property (nonatomic) BOOL objcIsMagnetAutoLockEnabled;
@property (nonatomic, readonly) enum LSEllipseSecurity objcSecurity;
@end


SWIFT_CLASS("_TtC9LattisSDK14EllipseManager")
@interface EllipseManager : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) EllipseManager * _Nonnull shared;)
+ (EllipseManager * _Nonnull)shared SWIFT_WARN_UNUSED_RESULT;
/// Actual list of avaliable locks
@property (nonatomic, readonly, copy) NSArray<Ellipse *> * _Nonnull locks;
/// Check BLE status
@property (nonatomic, readonly) BOOL isOn;
/// Default challenge key
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, copy) NSString * _Nullable secret;)
+ (NSString * _Nullable)secret SWIFT_WARN_UNUSED_RESULT;
+ (void)setSecret:(NSString * _Nullable)newValue;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
/// Stop scan for locks
- (void)stopScan;
- (void)disconnectWithEllipse:(Ellipse * _Nonnull)ellipse;
- (void)clean;
@end

@protocol LSEllipseManagerDelegate;

@interface EllipseManager (SWIFT_EXTENSION(LattisSDK))
- (void)scanWith:(id <LSEllipseManagerDelegate> _Nonnull)handler;
- (void)startScan;
- (void)subscribeWithDelegate:(id <LSEllipseManagerDelegate> _Nonnull)delegate;
@end

@class CBCentralManager;
@class NSNumber;

@interface EllipseManager (SWIFT_EXTENSION(LattisSDK)) <CBCentralManagerDelegate>
- (void)centralManagerDidUpdateState:(CBCentralManager * _Nonnull)central;
- (void)centralManager:(CBCentralManager * _Nonnull)central didDiscoverPeripheral:(CBPeripheral * _Nonnull)peripheral advertisementData:(NSDictionary<NSString *, id> * _Nonnull)advertisementData RSSI:(NSNumber * _Nonnull)RSSI;
- (void)centralManager:(CBCentralManager * _Nonnull)central didConnectPeripheral:(CBPeripheral * _Nonnull)peripheral;
- (void)centralManager:(CBCentralManager * _Nonnull)central didFailToConnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
- (void)centralManager:(CBCentralManager * _Nonnull)central didDisconnectPeripheral:(CBPeripheral * _Nonnull)peripheral error:(NSError * _Nullable)error;
- (void)centralManager:(CBCentralManager * _Nonnull)central willRestoreState:(NSDictionary<NSString *, id> * _Nonnull)dict;
@end

typedef SWIFT_ENUM(NSInteger, LSEllipseConnection, closed) {
  LSEllipseConnectionPaired = 0,
  LSEllipseConnectionUnpaired = 1,
  LSEllipseConnectionConnecting = 2,
  LSEllipseConnectionReconnecting = 3,
  LSEllipseConnectionFlashingLED = 4,
  LSEllipseConnectionManageCapTouch = 5,
  LSEllipseConnectionFailed = 6,
  LSEllipseConnectionUpdating = 7,
  LSEllipseConnectionRestored = 8,
};

enum LSEllipseValue : NSInteger;

SWIFT_PROTOCOL("_TtP9LattisSDK17LSEllipseDelegate_")
@protocol LSEllipseDelegate
- (void)ellipse:(Ellipse * _Nonnull)ellipse didUpdate:(enum LSEllipseConnection)connection error:(NSError * _Nullable)error;
- (void)ellipse:(Ellipse * _Nonnull)ellipse didUpdate:(enum LSEllipseSecurity)security;
- (void)ellipse:(Ellipse * _Nonnull)ellipse didUpdate:(id _Nonnull)value with:(enum LSEllipseValue)valueType;
@end


SWIFT_PROTOCOL("_TtP9LattisSDK24LSEllipseManagerDelegate_")
@protocol LSEllipseManagerDelegate
- (void)manager:(EllipseManager * _Nonnull)lockManager didRestoreConnected:(NSArray<Ellipse *> * _Nonnull)locks;
- (void)manager:(EllipseManager * _Nonnull)lockManager didUpdateLocks:(NSArray<Ellipse *> * _Nonnull)insert delete:(NSArray<Ellipse *> * _Nonnull)delete_;
- (void)manager:(EllipseManager * _Nonnull)lockManager didUpdateConnectionState:(BOOL)connected;
@end

typedef SWIFT_ENUM(NSInteger, LSEllipseSecurity, closed) {
  LSEllipseSecurityUnlocked = 0,
  LSEllipseSecurityLocked = 1,
  LSEllipseSecurityMiddle = 2,
  LSEllipseSecurityInvalid = 3,
  LSEllipseSecurityAuto = 4,
};

typedef SWIFT_ENUM(NSInteger, LSEllipseValue, closed) {
  LSEllipseValueFirmwareVersion = 0,
  LSEllipseValueSerialNumber = 1,
  LSEllipseValueCapTouchEnabled = 2,
  LSEllipseValueShackleInserted = 3,
  LSEllipseValueMagnetAutoLockEnabled = 4,
};

#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
