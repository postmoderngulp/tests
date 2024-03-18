import 'dart:convert';

import '../../domain/entities/board.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BoardModel implements Board {
  @override
  double height;

  @override
  String label;

  @override
  String picture;

  @override
  String title;

  @override
  double width;
  BoardModel({
    required this.height,
    required this.label,
    required this.picture,
    required this.title,
    required this.width,
  });
 

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'height': height,
      'label': label,
      'picture': picture,
      'title': title,
      'width': width,
    };
  }

  factory BoardModel.fromMap(Map<String, dynamic> map) {
    return BoardModel(
      height: map['height'] as double,
      label: map['label'] as String,
      picture: map['picture'] as String,
      title: map['title'] as String,
      width: map['width'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory BoardModel.fromJson(String source) => BoardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant BoardModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.height == height &&
      other.label == label &&
      other.picture == picture &&
      other.title == title &&
      other.width == width;
  }

  @override
  int get hashCode {
    return height.hashCode ^
      label.hashCode ^
      picture.hashCode ^
      title.hashCode ^
      width.hashCode;
  }
}
