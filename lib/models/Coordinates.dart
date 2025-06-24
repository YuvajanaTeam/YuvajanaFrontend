class Coordinates {
  final double top, left, width, height;

  Coordinates({
    required this.top,
    required this.left,
    required this.width,
    required this.height,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      top: (json['top'] as num).toDouble(),
      left: (json['left'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'top': top,
      'left': left,
      'width': width,
      'height': height,
    };
  }
}