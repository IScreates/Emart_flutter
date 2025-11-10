import 'package:flutter/material.dart';
import 'package:myapp/consts/consts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:myapp/views/orders_screen/Components/order_place_details.dart';
import 'package:myapp/views/orders_screen/Components/order_status.dart';

class OrdersDetails extends StatelessWidget {
  final dynamic data;

  const OrdersDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order status section
              orderStatus(
                color: redColor,
                icon: Icons.done,
                title: "Order Placed",
                showDone: data['order_placed'],
              ),
              orderStatus(
                color: Colors.blue,
                icon: Icons.thumb_up,
                title: "Order Confirmed",
                showDone: data['order_confirmed']
              ),
              orderStatus(
                  color: Colors.yellow,
                  icon: Icons.car_crash,
                  title: "On Delivery",
                  showDone: data['order_on_delivery']
              ),

              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  title: "Delivered",
                  showDone:data['order_delivered']
              ),

              const Divider(),
              10.heightBox,
              orderPlaceDetails(
                data: data,
                D1 : data['order_code'],
                D2 : data['shipping_method'],
                title1: "order Code",
                title2: "shipping Method",
              ),
              orderPlaceDetails(
                data: data,
                D1 : data['order_date'].toDate(),
                D2 : data['payment_method'],
                title1: "Order Date",
                title2: "Payment Method",
              ),
            ],
        ),
        )
      )
    );
  }
}