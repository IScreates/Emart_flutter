import 'package:myapp/consts/consts.dart';
import 'package:myapp/consts/lists.dart';

import '../../widgets_common/our_button.dart';
import '../../controller/cart_controller.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox (
        height: 60,
        child :ourButton(onPress: (){

        }, color: redColor, textColor: whiteColor, title: "Place My Order"),
      ),
      appBar: AppBar(
        title: "Choose Payment Method".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),

      body: Padding(
        padding: EdgeInsets.all(12.0),
      child :Column(
        children : List.generate(paymentMethodsImg.length, (index){
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                style: BorderStyle.solid,
                color: redColor,width: 5
              )
            ),
            margin: EdgeInsets.only(bottom: 8),
            child: Image.asset(paymentMethodsImg[index],width: double.infinity, height: 120, fit: BoxFit.cover),
          );
        }),
      ),
      ),
    );
  }
}
