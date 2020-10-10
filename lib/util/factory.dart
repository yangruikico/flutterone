import 'package:TATO/moudle/state/app_state.dart';
import 'package:TATO/services/weiguan.dart';
import 'package:redux/redux.dart';

class WgFactory {

  Store<AppState> _store;
  WgService mWgService;

  Store<AppState> getStore() {
    if (_store == null) {
      final List<Middleware<AppState>> wms=[];
      _store=Store<AppState> (null,
        initialState: AppState(),
        middleware:wms
      );


    }
    return _store;
  }



  Future<WgService> getWgService() async{
    if (mWgService == null) {
      mWgService=WgService();
    }
    return mWgService;
  }


}
