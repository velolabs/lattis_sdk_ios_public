/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, { Component } from 'react';
import {
  StyleSheet,
  FlatList,
  View,
  Text,
  NativeModules,
  NativeEventEmitter,
  Modal,
  TouchableWithoutFeedback,
  Switch,
  Button,
} from 'react-native';

const Lattis = NativeModules.RNEllipseManager;
var dismiss;

export default class App extends Component {
  
  lattisEmitter = new NativeEventEmitter(Lattis);

  constructor(props) {
    super(props);
    dismiss = this.hideDetails;
  }

  array = [];
  locksListener;
  connectionStateListener;

  state = {
    arrayHolder: [],
    detailsMacId: null,
  }

  add(locks) {
    this.array = this.array.concat(locks)
    this.setState({ arrayHolder: [...this.array]})
  }

  connect(lock) {
    Lattis.connect(lock.macId)
  }

  handle(lock) {
    console.log(lock.state)
  }

  componentDidMount() {
    this.setState({ arrayHolder: [...this.array] })

    this.locksListener = this.lattisEmitter.addListener(Lattis.locksUpdated, (locks) => this.add(locks));
    this.connectionStateListener = this.lattisEmitter.addListener(Lattis.lockConnectionStateChanged, (lock) => this.handle(lock));
    Lattis.startScan()
  }

  componentWillUnmount() {
    this.locksListener.remove();
    this.connectionStateListener.remove();
  }

  hideDetails = () => {
    this.setState({ detailsMacId: null })
  }

  render() {
    return (
      <View style={styles.container}>
        <Modal
          animationType='slide'
          transparent={false}
          visible={this.state.detailsMacId != null}
        >
          <Details macId={this.state.detailsMacId} />
        </Modal>

        <FlatList
          data={this.state.arrayHolder}
          extraData={this.state.arrayHolder}
          renderItem={({item}) => 
            <TouchableWithoutFeedback onPress = { () => this.setState({ detailsMacId: item.macId }) }>
              <Text style={styles.item}>{item.name}</Text>
            </TouchableWithoutFeedback>
          }
          keyExtractor={(item, index) => item.macId}
        />
      </View>
    );
  }
};

class Details extends Component {

  lattisEmitter = new NativeEventEmitter(Lattis);

  constructor(props) {
    super(props);
    this.macId = props.macId;
  }

  lockStateListener;
  connectionStateListener;
  valuesListener;
  macId;
  state = {
    title: 'Connecting...',
    isLocked: true,
    magLock: false,
    capTouch: false,
    serialNumber: 'N/A',
    batteryLevel: 'N/A',
    fwVersion: 'N/A'
  }

  handleConnection(lock) {
    if (lock.macId != this.macId) return
    if (lock.state === Lattis.connectionPaired) {
      this.setState({ title: 'Connected!' })
    }
    if (lock.state === Lattis.connectionReady) {
      
    }
  }

  handleSecurity(lock) {
    if (lock.macId != this.macId) return
    this.setState({ isLocked: lock.state === Lattis.securityLocked })
  }

  handleValues(lock) {
    if (lock.macId != this.macId) return
    switch (lock.valueType) {
      case Lattis.valuesSerialNumber:
        this.setState({ serialNumber: lock.value });
        break;
      case Lattis.valuesMagLock:
        this.setState({ magLock: lock.value });
        break;
      case Lattis.valuesCapTouch:
        this.setState({ capTouch: lock.value });
        break;
      case Lattis.valuesFWVersion:
        this.setState({ fwVersion: lock.value });
        break;
      case Lattis.valuesBatteryLevel:
        this.setState({ batteryLevel: (lock.value*100).toString() + '%' });
        break;
      default:
        break;
    }
  }

  toggleSecurity(unlock) {
    if (unlock) {
      Lattis.unlock(this.macId)
    } else {
      Lattis.lock(this.macId)
    }
    this.setState({ isLocked: !unlock })
  }

  toggleMagLock(on) {
    if (on) {
      Lattis.enableMagLock(this.macId)
    } else {
      Lattis.disableMagLock(this.macId)
    }
    this.setState({ magLock: on })
  }

  toggleCapTouch(on) {
    if (on) {
      Lattis.enableCapTouch(this.macId)
    } else {
      Lattis.disableCapTouch(this.macId)
    }
    this.setState({ capTouch: on})
  }

  componentDidMount() {
    this.connectionStateListener = this.lattisEmitter.addListener(Lattis.lockConnectionStateChanged, (lock) => this.handleConnection(lock))
    this.lockStateListener = this.lattisEmitter.addListener(Lattis.lockSecurityStateChanged, (lock) => this.handleSecurity(lock))
    this.valuesListener = this.lattisEmitter.addListener(Lattis.lockValuesUpdated, (lock) => this.handleValues(lock))
    Lattis.connect(this.macId)
  }

  componentWillUnmount() {
    this.connectionStateListener.remove();
    this.lockStateListener.remove();
    this.valuesListener.remove();
    Lattis.disconnect(this.macId);
  }

  render() {
    return (
      <View style={styles.details}>
        <Text style={styles.statusText}>{this.state.title}</Text>
        <View style={styles.detailRow}>
          <Text style={styles.toggle}>Mac ID:</Text>
          <Text style={styles.toggle}>{this.macId}</Text>
        </View>
        <View style={styles.detailRow}>
          <Text style={styles.toggle}>Locked</Text>
          <Switch 
            style={styles.toggle}
            onValueChange={(on) => this.toggleSecurity(on)}
            value={!this.state.isLocked}
          />
          <Text style={styles.toggle}>Unlocked</Text>
        </View>
        <View style={styles.detailRow}>
          <Text style={styles.toggle}>Mag lock</Text>
          <Switch 
            onValueChange={(on) => this.toggleMagLock(on)}
            value={this.state.magLock}
          />
        </View>
        <View style={styles.detailRow}>
          <Text style={styles.toggle}>Cap touch</Text>
          <Switch
            onValueChange={(value) => this.toggleCapTouch(value)}
            value={this.state.capTouch}
          />
        </View>
        <View style={styles.detailRow}>
          <Text style={styles.toggle}>SN:</Text>
          <Text style={styles.toggle}>{this.state.serialNumber}</Text>
        </View>
        <View style={styles.detailRow}>
          <Text style={styles.toggle}>Battery Level:</Text>
          <Text style={styles.toggle}>{this.state.batteryLevel}</Text>
        </View>
        <View style={styles.detailRow}>
          <Text style={styles.toggle}>FW Version:</Text>
          <Text style={styles.toggle}>{this.state.fwVersion}</Text>
        </View>
        <Button title="Disconnect" onPress={dismiss}/>
      </View>
    );
  }
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 64
   },
   item: {
     padding: 10,
     fontSize: 18,
     height: 44,
   },
   details: {
     flex: 1,
     flexDirection: "column",
     alignItems: "center",
     padding: 16,
     paddingTop: 64
   },
   statusText: {
     fontSize: 20,
     height: 44,
     textAlign: "center"
   },
   toggle: {
    padding: 20,
    fontSize: 18,
    alignSelf: "center",
   },
   detailRow: {
     flexDirection: "row",
     justifyContent: 'center',
     padding: 20,
     height: 44
   }
});


