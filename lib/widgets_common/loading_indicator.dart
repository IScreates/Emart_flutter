import 'package:myapp/consts/consts.dart';

Widget loadingIndicator(color){
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}