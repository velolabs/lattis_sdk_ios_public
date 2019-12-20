//
//  RNEllipseManager.m
//  RNLattisSDK
//
//  Created by Ravil Khusainov on 18.12.2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNEllipseManager.h"
#import <React/RCTConvert.h>
@import LattisSDK;

#define LOCKS_UPDATED @"locksUpdated"
#define LOCK_CONNECTION_STATE_CHANGED @"lockConnectionStateChanged"
#define LOCK_SECURITY_STATE_CHANGED @"lockSecurityStateChanged"
#define LOCK_VALUES_UPDATED @"lockValuesUpdated"

#define CONNECTION_PAIRED @"connectionPaired"
#define CONNECTION_UNPAIRED @"connectionUnpaired"
#define CONNECTION_CONNECTING @"connectionConnecting"
#define CONNECTION_RECONNECTING @"connectionReconnecting"
#define CONNECTION_FLASHING_LED @"connectionFlasingLed"
#define CONNECTION_MANAGE_CAP_TOUCH @"connectionManageCapTouch"
#define CONNECTION_FAILED @"connectionFailed"
#define CONNECTION_UPDATING @"connectionUpdating"
#define CONNECTION_RESTORED @"connectionRestored"
#define CONNECTION_READY @"connectionReady"

#define SECURITY_UNLOCKED @"securityUnloced"
#define SECURITY_LOCKED @"securityLocked"
#define SECURITY_MIDDLE @"securityMiddle"
#define SECURITY_INVALID @"securityInvalid"
#define SECURITY_AUTO @"securityAuto"

#define VALUES_FW_VERSION @"valuesFWVersion"
#define VALUES_SERIAL_NUMBER @"valuesSerialNumber"
#define VALUES_CAP_TOUCH @"valuesCapTouch"
#define VALUES_MAG_LOCK @"valuesMagLock"
#define VALUES_SHACKLE @"valuesShackle"
#define VALUES_BATTERY_LEVEL @"valuesBatteryLevel"

@interface RNEllipseManager() <LSEllipseManagerDelegate, LSEllipseDelegate>

@end

@implementation RNEllipseManager

RCT_EXPORT_MODULE();

+ (BOOL)requiresMainQueueSetup {
  return YES;
}

- (NSArray<NSString *> *)supportedEvents {
  return @[LOCKS_UPDATED, LOCK_CONNECTION_STATE_CHANGED, LOCK_SECURITY_STATE_CHANGED, LOCK_VALUES_UPDATED];
}

- (NSDictionary *)constantsToExport {
  return @{
    LOCKS_UPDATED: LOCKS_UPDATED,
    LOCK_CONNECTION_STATE_CHANGED: LOCK_CONNECTION_STATE_CHANGED,
    LOCK_SECURITY_STATE_CHANGED: LOCK_SECURITY_STATE_CHANGED,
    LOCK_VALUES_UPDATED: LOCK_VALUES_UPDATED,
    CONNECTION_PAIRED: CONNECTION_PAIRED,
    CONNECTION_UNPAIRED: CONNECTION_UNPAIRED,
    CONNECTION_CONNECTING: CONNECTION_CONNECTING,
    CONNECTION_FLASHING_LED: CONNECTION_FLASHING_LED,
    CONNECTION_RECONNECTING: CONNECTION_RECONNECTING,
    CONNECTION_MANAGE_CAP_TOUCH: CONNECTION_MANAGE_CAP_TOUCH,
    CONNECTION_FAILED: CONNECTION_FAILED,
    CONNECTION_UPDATING: CONNECTION_UPDATING,
    CONNECTION_RESTORED: CONNECTION_RESTORED,
    CONNECTION_READY: CONNECTION_READY,
    SECURITY_UNLOCKED: SECURITY_UNLOCKED,
    SECURITY_LOCKED: SECURITY_LOCKED,
    SECURITY_MIDDLE: SECURITY_MIDDLE,
    SECURITY_INVALID: SECURITY_INVALID,
    SECURITY_AUTO: SECURITY_AUTO,
    VALUES_SERIAL_NUMBER: VALUES_SERIAL_NUMBER,
    VALUES_MAG_LOCK: VALUES_MAG_LOCK,
    VALUES_CAP_TOUCH: VALUES_CAP_TOUCH,
    VALUES_FW_VERSION: VALUES_FW_VERSION,
    VALUES_SHACKLE: VALUES_SHACKLE,
    VALUES_BATTERY_LEVEL: VALUES_BATTERY_LEVEL
  };
}

- (NSDictionary *)connectionTable {
  return @{
    @(LSEllipseConnectionPaired): CONNECTION_PAIRED,
    @(LSEllipseConnectionUnpaired): CONNECTION_UNPAIRED,
    @(LSEllipseConnectionConnecting): CONNECTION_CONNECTING,
    @(LSEllipseConnectionReconnecting): CONNECTION_RECONNECTING,
    @(LSEllipseConnectionFlashingLED): CONNECTION_FLASHING_LED,
    @(LSEllipseConnectionManageCapTouch): CONNECTION_MANAGE_CAP_TOUCH,
    @(LSEllipseConnectionFailed): CONNECTION_FAILED,
    @(LSEllipseConnectionUpdating): CONNECTION_UPDATING,
    @(LSEllipseConnectionRestored): CONNECTION_RESTORED,
    @(LSEllipseConnectionReady): CONNECTION_READY
  };
}

- (NSDictionary *)securityTable {
  return @{
    @(LSEllipseSecurityUnlocked): SECURITY_UNLOCKED,
    @(LSEllipseSecurityLocked): SECURITY_LOCKED,
    @(LSEllipseSecurityMiddle): SECURITY_MIDDLE,
    @(LSEllipseSecurityInvalid): SECURITY_INVALID,
    @(LSEllipseSecurityAuto): SECURITY_AUTO,
  };
}

- (NSDictionary *)valuesTable {
  return @{
    @(LSEllipseValueFirmwareVersion): VALUES_FW_VERSION,
    @(LSEllipseValueSerialNumber): VALUES_SERIAL_NUMBER,
    @(LSEllipseValueCapTouchEnabled): VALUES_CAP_TOUCH,
    @(LSEllipseValueShackleInserted): VALUES_SHACKLE,
    @(LSEllipseValueMagnetAutoLockEnabled): VALUES_MAG_LOCK,
    @(LSEllipseValueBatteryLevel): VALUES_BATTERY_LEVEL,
  };
}

RCT_EXPORT_METHOD(startScan) {
  [[EllipseManager shared] scanWith:self];
}

RCT_EXPORT_METHOD(stopScan) {
  [[EllipseManager shared] stopScan];
}

RCT_EXPORT_METHOD(connect:(NSString *)macId) {
  [[self ellipse:macId] connectWithHandler:self];
}

RCT_EXPORT_METHOD(disconnect:(NSString *)macId) {
  [[self ellipse:macId] disconnect];
}

RCT_EXPORT_METHOD(lock:(NSString *)macId) {
  [[self ellipse:macId] lock];
}

RCT_EXPORT_METHOD(unlock:(NSString *)macId) {
  [[self ellipse:macId] unlock];
}

RCT_EXPORT_METHOD(getLock:(NSString *)macId callback:(RCTResponseSenderBlock)callback) {
  Ellipse *ellipse = [self ellipse:macId];
  NSDictionary *lock = @{
    @"name": ellipse.name,
    @"macId": ellipse.macId,
    @"isLocked": @(ellipse.securityState == LSEllipseSecurityLocked),
  };
  callback(@[[NSNull null], lock]);
}

RCT_EXPORT_METHOD(enableMagLock:(NSString *)macId) {
  [self ellipse:macId].objcIsMagnetAutoLockEnabled = YES;
}

RCT_EXPORT_METHOD(disableMagLock:(NSString *)macId) {
  [self ellipse:macId].objcIsMagnetAutoLockEnabled = NO;
}

RCT_EXPORT_METHOD(enableCapTouch:(NSString *)macId) {
  [self ellipse:macId].objcIsCapTouchEnabled = YES;
}

RCT_EXPORT_METHOD(disableCapTouch:(NSString *)macId) {
  [self ellipse:macId].objcIsCapTouchEnabled = NO;
}


- (Ellipse *)ellipse:(NSString *)macId {
  return [[[EllipseManager shared].locks filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"macId = %@", macId]] firstObject];
}

- (void)manager:(EllipseManager * _Nonnull)lockManager didRestoreConnected:(NSArray<Ellipse *> * _Nonnull)locks {
  
}

- (void)manager:(EllipseManager * _Nonnull)lockManager didUpdateConnectionState:(BOOL)connected {
  
}

- (void)manager:(EllipseManager * _Nonnull)lockManager didUpdateLocks:(NSArray<Ellipse *> * _Nonnull)insert delete:(NSArray<Ellipse *> * _Nonnull)delete_ {
  NSMutableArray <NSDictionary *> * locks = [NSMutableArray new];
  for (Ellipse *l in insert) {
    [locks addObject: @{@"name": l.name, @"macId": l.macId} ];
  }
  [self sendEventWithName:LOCKS_UPDATED body:locks];
}

- (void)ellipse:(Ellipse * _Nonnull)ellipse didUpdate:(enum LSEllipseSecurity)security {
  [self sendEventWithName:LOCK_SECURITY_STATE_CHANGED body:@{@"macId": ellipse.macId, @"state": [self.securityTable objectForKey:@(security)]}];
}

- (void)ellipse:(Ellipse * _Nonnull)ellipse didUpdate:(enum LSEllipseConnection)connection error:(NSError * _Nullable)error {
  [self sendEventWithName:LOCK_CONNECTION_STATE_CHANGED body:@{@"macId": ellipse.macId, @"state": [self.connectionTable objectForKey:@(connection)]}];
}

- (void)ellipse:(Ellipse * _Nonnull)ellipse didUpdate:(id _Nonnull)value with:(enum LSEllipseValue)valueType {
  [self sendEventWithName:LOCK_VALUES_UPDATED body:@{
    @"macId": ellipse.macId,
    @"value": value,
    @"valueType": [self.valuesTable objectForKey:@(valueType)]
  }];
}

@end

