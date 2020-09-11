import 'dart:convert';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';

import 'agora_rtm_message_model.dart';

class AgoraRtmUtils {
  static AgoraRtmClient _client;
  static bool isLogin = true;

  /// Agora 初始化
  static Future<AgoraRtmClient> getAgoraRtmClient() async {
    if (_client == null) {
      _client = await AgoraRtmClient.createInstance(
          '7252774b1b1c48a6bfb61ef72ed9e71a');
    }
    return _client;
  }

  /// 查询用户是否在线
  ///  true-在线  , false-离线
  static Future<bool> queryPeerOnlineStatus(String peerUid) async {
    if (peerUid.isEmpty) {
      return false;
    } else {
      try {
        Map<String, bool> result =
            await _client.queryPeersOnlineStatus([peerUid]);
        return result[peerUid];
      } catch (errorCode) {
        return false;
      }
    }
  }

  /// 获取声网的消息类型
  /// 1-请求视频通话
  /// 2-取消请求通话
  /// 3-拒绝通话请求
  static String getAgoraMsgType(int type) {
    switch (type) {
      case 1:
        return "CALLVIDEO";
      case 2:
        return "CANCEL_VIDEO";
      case 3:
        return "REFUSE_VIDEO";
      default:
        return "";
    }
  }

  /// 声网RTM初始化、注册接收
  Future initAgoraRtm() async {
    if (isLogin) {
      /// 没有登录不能初始化
      return;
    }
    // 初始化
    _client = await getAgoraRtmClient();
    // 登录
    // loginAgoraRtm();
    // 设置消息接收器
    _client.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      print('\npeerId:$peerId \n接收到的消息:${message}');
      if (message.text.isNotEmpty) {
        // 收到视频请求，
        Map msg = json.decode(message.text);
        AgoraRtmMessageModel msgModel = AgoraRtmMessageModel.fromJson(msg);

        if (msgModel.msgType == getAgoraMsgType(1)) {
          try {
            // 收到通话请求时的响铃页面
            // 跳到响铃页面

          } catch (e) {
            print(e.toString());
          }
        } else if (msgModel.msgType == getAgoraMsgType(2)) {
          // 收到消息：视频请求者取消了通话
        } else if (msgModel.msgType == getAgoraMsgType(3)) {
          // 对方拒绝了通话请求
        }
      }
    };
    _client.onConnectionStateChanged = (int state, int reason) {
      // _log('Connection state changed: ' +  state.toString() +  ', reason: ' + reason.toString());
      if (state == 5) {
        _client.logout();
      }
    };
  }

  /// 登录rtm
  loginAgoraRtm(String str) async {
    try {
      await _client.login(null, str);
      print('AgoraRtm登录成功');
    } catch (e) {
      // reason;  code;
      print('AgoraRtm登录错误: ${e.toString()}');
      switch (e.code) {
        case 8:
          print(
              '用户已登录，或正在登录 Agora RTM 系统，或未调用 logoutWithCompletion 方法退出 AgoraRtmConnectionStateAborted 状态。');
          _client.logout();
          loginAgoraRtm(str);
          break;
        default:
      }
    }
  }

  ///退出rtm
  logoutAgoraRtm() {
    _client.logout();
  }

  /// 发送消息
  static _agoraRtmSendMessage({
    String peerId,
    String message = '',
  }) async {
    String content = message;
    if (content.isEmpty) {
      print('消息文本不能为空');
      return;
    }
    try {
      //文本消息内容。最大长度不得超过 32 KB。 1KB相当于1024个英文字母，或者是512个汉字。
      AgoraRtmMessage message = AgoraRtmMessage.fromText(content);
      print('发送的消息是:${message.text}');
      await _client.sendMessageToPeer(peerId, message, false);
      print('消息发送成功');
      Map<String, dynamic> data = json.decode(content);
      AgoraRtmMessageModel msgModel = AgoraRtmMessageModel.fromJson(data);
      if (msgModel.msgType == getAgoraMsgType(1)) {
        print('消息发送成功==>请求视频通话');
      }
    } catch (errorCode) {
      print('消息发送失败: ' + errorCode.toString());
    }
  }

  /// 请求视频通话
  static sendVideoCallMsg(String receivId) async {
    bool isonline = await queryPeerOnlineStatus(receivId);
    if (isonline) {
      print('对方不在线');
      return;
    }
    String msg = _initAgoraRtmMessage(receivId, msgType: getAgoraMsgType(1));
    _agoraRtmSendMessage(message: msg, peerId: receivId);
  }

  /// 取消视频通话
  cancelVideoCallMsg(String receivId) {
    String msg = _initAgoraRtmMessage(receivId, msgType: getAgoraMsgType(2));
    _agoraRtmSendMessage(message: msg, peerId: receivId);
  }

  /// 拒绝视频通话
  refuseVideoCallMsg(String receivId) {
    String msg = _initAgoraRtmMessage(receivId, msgType: getAgoraMsgType(3));
    _agoraRtmSendMessage(message: msg, peerId: receivId);
  }

  /// 组装消息数据
  /// msgType: 1 请求视频通话 2 取消视频通话  3 拒绝视频通话
  /// msgOperation: 消息的操作
  static _initAgoraRtmMessage(
    String receivId, {
    String msgType = '',
    String message = '',
  }) {
    // {
    //   "msgType": 1,
    //   "sendId": "发送者id",
    //   "receiveId": "接受者id",
    //   "sendAvatar": "发送者头像",
    //   "sendName": "发送者名字",
    //   "sendText": ""
    // }

    Map<String, dynamic> data = {
      "msgType": msgType,
      // "sendId": Provide.value<UserInfoProvide>(getGlobalContext())
      //     .userInfoModel
      //     .userid
      //     .toString(),
      // "sendAvatar": Provide.value<UserInfoProvide>(getGlobalContext())
      //     .userInfoModel
      //     .avatar,
      // "sendName":
      //     Provide.value<UserInfoProvide>(getGlobalContext()).userInfoModel.name,
      // "sendText": message,
      "receiveId": receivId,
    };

    return json.encode(data);
  }
}
