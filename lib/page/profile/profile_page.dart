import 'package:TATO/moudle/entity/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../user_info_provide.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    return Provider<UserInfoProvide>(
        create:(_)=>UserInfoProvide(),
        dispose: (context, value) => value.dispose(),
        child: Container(
          child: Text(
            '${context.watch<UserInfoProvide>().userEntity.username}'
          ),
        ));
  }
}
