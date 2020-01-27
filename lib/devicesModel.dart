class Device {
  String imageUrl;
  String deviceName;
  String inRoom;
  String state;
  String level;
  double opacity;

  Device({
    this.imageUrl,
    this.deviceName,
    this.inRoom,
    this.state,
    this.level,
    this.opacity,
  });
}

List<Device> devices = [
  Device(
    imageUrl: 'assets/images/deviceAssets/bulb.png',
    deviceName: 'Lamp',
    inRoom: 'Living Room',
    state: 'On',
    level: '5',
    opacity: 1,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/ac.png',
    deviceName: 'A/C',
    inRoom: 'Living Room',
    state: 'On',
    level: '5',
    opacity: 1,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/fan.png',
    deviceName: 'Fan',
    inRoom: 'Bedroom',
    state: 'Off',
    level: '5',
    opacity: 0.3,
  ),
];
