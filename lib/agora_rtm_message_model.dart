import 'package:json_annotation/json_annotation.dart';

part 'agora_rtm_message_model.g.dart';

@JsonSerializable()
class AgoraRtmMessageModel extends Object {
  AgoraRtmMessageModel(
    this.msgType,
    this.sendAvatar,
    this.sendText,
    this.sendName,
    this.sendId,
    this.receiveId,
  );

  factory AgoraRtmMessageModel.fromJson(Map<String, dynamic> srcJson) =>
      _$AgoraRtmMessageModelFromJson(srcJson);

  @JsonKey(name: 'msgType')
  String msgType;

  @JsonKey(name: 'sendAvatar')
  String sendAvatar;

  @JsonKey(name: 'sendText')
  String sendText;

  @JsonKey(name: 'sendName')
  String sendName;

  @JsonKey(name: 'sendId')
  String sendId;

  @JsonKey(name: 'receiveId')
  String receiveId;

  @JsonKey(name: 'receivedName')
  String receivedName;

  @JsonKey(name: 'receivedAvatar')
  String receivedAvatar;

  Map<String, dynamic> toJson() => _$AgoraRtmMessageModelToJson(this);
}
