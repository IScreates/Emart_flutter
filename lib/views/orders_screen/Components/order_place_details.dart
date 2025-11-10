import 'package:myapp/consts/consts.dart';

Widget orderPlaceDetails( { required title1, required title2,required D1, required data, required D2}){
  return  Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title1".text.fontFamily(semibold).make(),
              "$D1".text.color(redColor).fontFamily(semibold).make()
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.fontFamily(semibold).make(),
              "$D2".text.color(redColor).fontFamily(semibold).make()
            ],
          ),
        ],
      )
  );
}