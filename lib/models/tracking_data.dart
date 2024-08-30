class TrackingData {
  final String awb;
  final String courier;
  final String shipper;
  final String receiver;
  final String origin;
  final String destination;
  final String description;

  TrackingData({
    required this.awb,
    required this.courier,
    required this.shipper,
    required this.receiver,
    required this.origin,
    required this.destination,
    required this.description,
  });

  // Convert a TrackingData object into a Map
  Map<String, dynamic> toMap() {
    return {
      'awb': awb,
      'courier': courier,
      'shipper': shipper,
      'receiver': receiver,
      'origin': origin,
      'destination': destination,
      'description': description,
    };
  }

  // Create a TrackingData object from a Map
  factory TrackingData.fromMap(Map<String, dynamic> map) {
    return TrackingData(
      awb: map['awb'] ?? '',
      courier: map['courier'] ?? '',
      shipper: map['shipper'] ?? '',
      receiver: map['receiver'] ?? '',
      origin: map['origin'] ?? '',
      destination: map['destination'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
