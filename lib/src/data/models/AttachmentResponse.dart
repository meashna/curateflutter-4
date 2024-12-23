import 'dart:convert';
/// id : 68
/// path : "resources/attachments/2022/10/25/079544d0-6cca-11ed-8a56-f3ad937d1f8d.jpg"
/// size : 181
/// inUse : 0
/// userId : 10
/// mimeType : "image/jpeg"
/// createdAt : "2022-11-25T14:04:08.583Z"
/// extension : ".jpg"
/// updatedAt : "2022-11-25T14:04:08.583Z"
/// uniqueName : "079544d0-6cca-11ed-8a56-f3ad937d1f8d.jpg"
/// originalName : "scaled_image_picker5979746159739403302.jpg"

AttachmentResponse attachmentResponseFromJson(String str) => AttachmentResponse.fromJson(json.decode(str));
String attachmentResponseToJson(AttachmentResponse data) => json.encode(data.toJson());
class AttachmentResponse {
  AttachmentResponse({
      num? id, 
      String? path, 
      num? size, 
      num? inUse, 
      num? userId, 
      String? mimeType, 
      String? createdAt, 
      String? extension, 
      String? updatedAt, 
      String? uniqueName, 
      String? originalName,}){
    _id = id;
    _path = path;
    _size = size;
    _inUse = inUse;
    _userId = userId;
    _mimeType = mimeType;
    _createdAt = createdAt;
    _extension = extension;
    _updatedAt = updatedAt;
    _uniqueName = uniqueName;
    _originalName = originalName;
}

  AttachmentResponse.fromJson(dynamic json) {
    _id = json['id'];
    _path = json['path'];
    _size = json['size'];
    _inUse = json['inUse'];
    _userId = json['userId'];
    _mimeType = json['mimeType'];
    _createdAt = json['createdAt'];
    _extension = json['extension'];
    _updatedAt = json['updatedAt'];
    _uniqueName = json['uniqueName'];
    _originalName = json['originalName'];
  }
  num? _id;
  String? _path;
  num? _size;
  num? _inUse;
  num? _userId;
  String? _mimeType;
  String? _createdAt;
  String? _extension;
  String? _updatedAt;
  String? _uniqueName;
  String? _originalName;
AttachmentResponse copyWith({  num? id,
  String? path,
  num? size,
  num? inUse,
  num? userId,
  String? mimeType,
  String? createdAt,
  String? extension,
  String? updatedAt,
  String? uniqueName,
  String? originalName,
}) => AttachmentResponse(  id: id ?? _id,
  path: path ?? _path,
  size: size ?? _size,
  inUse: inUse ?? _inUse,
  userId: userId ?? _userId,
  mimeType: mimeType ?? _mimeType,
  createdAt: createdAt ?? _createdAt,
  extension: extension ?? _extension,
  updatedAt: updatedAt ?? _updatedAt,
  uniqueName: uniqueName ?? _uniqueName,
  originalName: originalName ?? _originalName,
);
  num? get id => _id;
  String? get path => _path;
  num? get size => _size;
  num? get inUse => _inUse;
  num? get userId => _userId;
  String? get mimeType => _mimeType;
  String? get createdAt => _createdAt;
  String? get extension => _extension;
  String? get updatedAt => _updatedAt;
  String? get uniqueName => _uniqueName;
  String? get originalName => _originalName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['path'] = _path;
    map['size'] = _size;
    map['inUse'] = _inUse;
    map['userId'] = _userId;
    map['mimeType'] = _mimeType;
    map['createdAt'] = _createdAt;
    map['extension'] = _extension;
    map['updatedAt'] = _updatedAt;
    map['uniqueName'] = _uniqueName;
    map['originalName'] = _originalName;
    return map;
  }

}