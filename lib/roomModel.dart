class Room {
  String imageUrl;
  String roomName;
  String description;
  String nDevices;

  Room({
    this.imageUrl,
    this.roomName,
    this.description,
    this.nDevices,
  });
}

List<Room> rooms = [
  Room(
    imageUrl: 'assets/images/livingroom.png',
    roomName: 'Living Room',
    description: 'Family space',
    nDevices: '5',
  ),
  Room(
    imageUrl: 'assets/images/kitchen.png',
    roomName: 'Kitchen',
    description: 'Cooking space',
    nDevices: '2',
  ),
  Room(
    imageUrl: 'assets/images/bedroom.png',
    roomName: 'Bedroom',
    description: 'Sleeping Space',
    nDevices: '4',
  ),
  Room(
    imageUrl: 'assets/images/bedroom.png',
    roomName: 'Kids Room',
    description: 'Sleeping Space',
    nDevices: '4',
  ),
  Room(
    imageUrl: 'assets/images/bathroom.png',
    roomName: 'Bathroom',
    description: 'Fresh!',
    nDevices: '2',
  ),
];
