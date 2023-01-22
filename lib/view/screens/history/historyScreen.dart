/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_wash_app/controller/history_controller.dart';
import 'package:car_wash_app/helper/date_converter.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}


class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<HistoryController>().getInvoiceListFromDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: GetBuilder<HistoryController>(builder: (historyController) {
        return historyController.isLoading?Center(child: CircularProgressIndicator()):ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(

                              right: BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "Date",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )))),
                  Expanded(
                      flex: 2,
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(

                              right: BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "Invoice",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )))),
                  Expanded(
                      flex: 2,
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(

                              right: BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "Amount",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(

                              right: BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                          child: Center(
                              child: Text(
                                "Sync",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )))),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: historyController.invoiceShow!.length,
              itemBuilder: (_, index) {
                var invoice = historyController.invoiceShow;

                return Container(
                  decoration: BoxDecoration(
                    border: Border(

                    right: BorderSide(color: Colors.grey, width: 1),
                    left: BorderSide(color: Colors.grey, width: 1),
                    bottom: BorderSide(color: Colors.grey, width: 1),
                ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                              height: 30,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border(

                                  right:
                                      BorderSide(color: Colors.grey, width: 1),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                 DateConverter.isoStringToDateTimeString(historyController.invoiceShow[index].createdAt!.substring(0,25))
                                ,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    ),
                              )))),
                      Expanded(
                          flex: 2,
                          child: Container(
                              height: 30,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border(

                                  right:
                                      BorderSide(color: Colors.grey, width: 1),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                      historyController.invoiceShow[index].invoiceNo!,

                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    ),
                              )))),
                      Expanded(
                          flex: 2,
                          child: Container(
                              height: 30,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border(

                                  right:
                                      BorderSide(color: Colors.grey, width: 1),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                      historyController.invoiceShow[index].amount.toString()!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    ),
                              )))),
                      Expanded(
                          flex: 1,
                          child: Container(
                              height: 30,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border(

                                  right:
                                  BorderSide(color: Colors.grey, width: 1),
                                ),
                              ),
                              child: Image.asset(historyController.invoiceShow[index].isSaved==1?"assets/images/server.png":"assets/images/db.png",height: 10,width: 10,)))
                    ],
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
*/
