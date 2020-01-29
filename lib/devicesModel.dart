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

  //Living room devices
  Device(
    imageUrl: 'assets/images/deviceAssets/bulb.png',
    deviceName: 'Lamp',
    inRoom: 'Living Room',
    state: 'On',
    level: '5',
    opacity: 1,
  ),
   Device(
    imageUrl: 'assets/images/deviceAssets/bulb.png',
    deviceName: 'A/C',
    inRoom: 'Living Room',
    state: 'On',
    level: '5',
    opacity: 1,
  ),
   Device(
    imageUrl: 'assets/images/deviceAssets/bulb.png',
    deviceName: 'Speaker',
    inRoom: 'Living Room',
    state: 'On',
    level: '5',
    opacity: 1,
  ),

  //Kitchen devices
  Device(
    imageUrl: 'assets/images/deviceAssets/fan.png',
    deviceName: 'Lamp',
    inRoom: 'Kitchen',
    state: 'Off',
    level: '5',
    opacity: 0.3,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/fan.png',
    deviceName: 'Refrigerator',
    inRoom: 'Kitchen',
    state: 'Off',
    level: '5',
    opacity: 0.3,
  ),
   Device(
    imageUrl: 'assets/images/deviceAssets/fan.png',
    deviceName: 'Exhaust Fan',
    inRoom: 'Kitchen',
    state: 'Off',
    level: '5',
    opacity: 0.3,
  ),
  //Bedroom devices
  Device(
    imageUrl: 'assets/images/deviceAssets/fan.png',
    deviceName: 'Lamp',
    inRoom: 'Bedroom',
    state: 'Off',
    level: '5',
    opacity: 0.3,
  ),
   Device(
    imageUrl: 'assets/images/deviceAssets/fan.png',
    deviceName: 'TV',
    inRoom: 'Bedroom',
    state: 'Off',
    level: '5',
    opacity: 0.3,
  ),
   Device(
    imageUrl: 'assets/images/deviceAssets/fan.png',
    deviceName: 'Speaker',
    inRoom: 'Bedroom',
    state: 'Off',
    level: '5',
    opacity: 0.3,
  ),
  //Playroom devices
  Device(
    imageUrl: 'assets/images/deviceAssets/ac.png',
    deviceName: 'Lamp',
    inRoom: 'Playroom',
    state: 'On',
    level: '5',
    opacity: 1,
  ),
    Device(
    imageUrl: 'assets/images/deviceAssets/ac.png',
    deviceName: 'A/C',
    inRoom: 'Playroom',
    state: 'On',
    level: '5',
    opacity: 1,
  ),
    Device(
    imageUrl: 'assets/images/deviceAssets/ac.png',
    deviceName: 'Baby Monitor',
    inRoom: 'Playroom',
    state: 'On',
    level: '5',
    opacity: 1,
  ),

  //Bathroom devices
  Device(
    imageUrl: 'assets/images/deviceAssets/ac.png',
    deviceName: 'Lamp',
    inRoom: 'Bathroom',
    state: 'On',
    level: '5',
    opacity: 1,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/ac.png',
    deviceName: 'Water Heater',
    inRoom: 'Bathroom',
    state: 'On',
    level: '5',
    opacity: 1,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/ac.png',
    deviceName: 'Exhaust Fan',
    inRoom: 'Bathroom',
    state: 'On',
    level: '5',
    opacity: 1,
  ),
];
