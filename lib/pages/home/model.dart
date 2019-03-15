
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/network/clients/client_home.dart';

class HomeModelImpl extends IBaseModel implements IMainModel {

  @override
  Future onLoadMoreData({String type, Map<String, dynamic> query}) {
  }

  @override
  Future onLoadNetData({String type, Map<String, dynamic> query}) async {
    switch(type) {
      case const_util.NEWPUBLISH:
        return await HomeClient.getNewPublish(query);
        break;
      case const_util.NEWREPLY:
        return await HomeClient.getNewReply(query);
        break;
      default:
        return await HomeClient.getTodayHot(query);
    }
  }

  @override
  Future onRefresh({String type, Map<String, dynamic> query}) {

  }

}