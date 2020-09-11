// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agora_rtm_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgoraRtmMessageModel _$AgoraRtmMessageModelFromJson(Map<String, dynamic> json) {
  return AgoraRtmMessageModel(
    json['msgType'] as String,
    json['sendAvatar'] as String,
    json['sendText'] as String,
    json['sendName'] as String,
    json['sendId'] as String,
    json['receiveId'] as String,
  )
    ..receivedName = json['receivedName'] as String
    ..receivedAvatar = json['receivedAvatar'] as String;
}

Map<String, dynamic> _$AgoraRtmMessageModelToJson(
        AgoraRtmMessageModel instance) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'sendAvatar': instance.sendAvatar,
      'sendText': instance.sendText,
      'sendName': instance.sendName,
      'sendId': instance.sendId,
      'receiveId': instance.receiveId,
      'receivedName': instance.receivedName,
      'receivedAvatar': instance.receivedAvatar,
    };
