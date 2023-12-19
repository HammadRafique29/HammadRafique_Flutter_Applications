import 'package:flutter/material.dart';
// import 'Dashboard.dart';
import 'dart:async';
import 'db.dart';

DatabaseHelper dbHelper = DatabaseHelper();

String ActiveCustomer = "None";
TextEditingController Amount = TextEditingController();
List<dynamic> CustomerHistory = [{}];
List<dynamic> CustomerDetail = [{}];
List<dynamic> TotalBalance = [{}];
Color ResultTextColor = Colors.green.withOpacity(0.2);
Color ResultIconColor = Colors.green;
String Message = "Everything is not Clear";
List<Map<String, dynamic>> tempHistory = [{}];

class Khata extends StatefulWidget {
  late List<dynamic> CustomerHistory;
  final List<dynamic>? CustomerDetail;
  final int? userId;

  Khata(
      {super.key,
      required this.CustomerHistory,
      required this.CustomerDetail,
      required this.userId});

  @override
  State<Khata> createState() => _KhataState();
}

class _KhataState extends State<Khata> {
  void SetupData() async {
    List<Map<String, dynamic>> TotalBalance = await dbHelper.getAllBalances();

    int balance = CustomerHistory[CustomerHistory.length - 1]["Balance"];
    if (balance >= 0) {
      ResultTextColor = Colors.green.withOpacity(0.2);
      ResultIconColor = Colors.green;
    } else {
      ResultTextColor = Colors.red.withOpacity(0.2);
      ResultIconColor = Colors.red;
    }
    setState(() {
      if (balance > 0) {
        Message = "You Have To Take";
      } else if (balance == 0) {
        Message = "Everything Is Clear";
      } else {
        Message = "You Have To Give";
      }
      print(CustomerHistory);
      print("test Content Loaded");
    });
  }

  List<Widget> paymentHistor(BuildContext context) {
    List<Widget> History = [];
    int i = 0;
    for (var key in CustomerHistory) {
      if (CustomerHistory[i]["Description"] != "Initial") {
        int balance = CustomerHistory[i]["Balance"];
        int action;
        Color balanceColor;
        if (balance >= 0) {
          balanceColor = Colors.green;
        } else {
          balanceColor = Colors.red;
        }
        History.add(BuildHistoryItems(context, i, balance, balanceColor));
        i += 1;
      } else {
        i += 1;
      }
    }
    return History;
  }

  Widget BuildHistoryItems(
      BuildContext context, int i, int balance, Color balanceColor) {
    return GestureDetector(
      onTap: () async {
        int userId = CustomerHistory[i]["UID"];
        int action = CustomerHistory[i]["Action"];
        String desc = CustomerHistory[i]["Description"];
        var result = await viewHistory(context, userId, action, desc);
        if (result != null && result[0] == 1) {
          // Handle the result from the "Save" button
          print("##2 Saved Clicked");
        } else if (result != null && result[0] == 0) {
          // Handle the result from the "Cancel" button
          print("##2 Cancel Clicked");
        }
        setState(() {
          print("##2 Changes Made");
          widget.CustomerHistory.removeWhere((item) =>
              item["UID"] == userId &&
              item["Description"] == desc &&
              item["Balance"] == action);
          CustomerHistory = widget.CustomerHistory;
        });
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.95,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
        ),
        child: ListTile(
          title: Text("${CustomerHistory[i]["Description"]}",
              style: TextStyle(fontSize: 14)),
          subtitle: Container(
            child: Text('Bal. Rs ${CustomerHistory[i]["Balance"]}',
                style: TextStyle(fontSize: 12)),
          ),
          trailing: Text("Rs ${CustomerHistory[i]["Action"]}",
              style: TextStyle(fontSize: 16, color: balanceColor)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CustomerHistory = widget.CustomerHistory;
    CustomerDetail = widget.CustomerDetail!;
    // print("#### ${CustomerDetail}");
    // print("#### ${CustomerHistory}");

    if (CustomerHistory.length == 1 && CustomerHistory[0].keys.length == 0) {
      SetupData();
    }
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    ActiveCustomer = "None";
                    CustomerDetail = [{}];
                    CustomerHistory = [{}];
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new_rounded),
                ),
                SizedBox(width: 5),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.shade200),
                  child: Center(
                    child: Text(CustomerDetail[0]["UserCode"],
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(width: 15),
                Text(CustomerDetail[0]["Name"]),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.9,
              padding: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    margin: EdgeInsets.only(bottom: 20),
                    // height: 60,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: ResultTextColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      leading: Icon(
                        Icons.remove_circle,
                        color: ResultIconColor,
                      ),
                      title: Text(
                          'Rs ${CustomerHistory[CustomerHistory.length - 1]["Balance"]}',
                          style: TextStyle(fontSize: 15)),
                      subtitle: Text(Message, style: TextStyle(fontSize: 15)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: SingleChildScrollView(
                      child: Column(
                        children: paymentHistor(context),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          height: 40,
                          // color: Colors.redAccent,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Set borderRadius to 0 for a rectangle
                                ),
                              ),
                              onPressed: () async {
                                var DialogData = await Add_Payment(context);
                                var amount = DialogData?[0];
                                var Desc = DialogData?[1];

                                if (amount != null) {
                                  // Inserting History in Database
                                  dbHelper.insertCustomerHistory([
                                    widget.userId,
                                    Desc != '' ? Desc : "Give Money",
                                    int.parse(amount),
                                    int.parse(amount) +
                                        widget.CustomerHistory[
                                            widget.CustomerHistory.length -
                                                1]["Balance"]
                                  ]);
                                  // Appending the List of Dat
                                  var updatedBalance = int.parse(amount) +
                                      widget.CustomerHistory[
                                              widget.CustomerHistory.length - 1]
                                          ["Balance"];

                                  widget.CustomerHistory.add({
                                    "UID": widget.userId,
                                    "Description":
                                        Desc != '' ? Desc : "Give Money",
                                    "Action": int.parse(amount),
                                    "Balance": updatedBalance,
                                  });

                                  List<int> BalanceCalculation =
                                      await dbHelper.getPositiveNegativeSum();

                                  dbHelper.updateBalance(
                                      1,
                                      BalanceCalculation[1],
                                      BalanceCalculation[0]);
                                  setState(() {
                                    SetupData();
                                  });
                                } else {}
                              },
                              child: const Text("MANA DIYE")),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          height: 40,
                          // color: Colors.redAccent,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Set borderRadius to 0 for a rectangle
                              ),
                            ),
                            onPressed: () async {
                              var DialogData = await Add_Payment(context);
                              var amount = DialogData?[0];
                              var Desc = DialogData?[1];

                              if (amount != null) {
                                print("### Inserting Data in Database");
                                // print("### ${widget.CustomerHistory}");
                                dbHelper.insertCustomerHistory([
                                  widget.userId,
                                  Desc != '' ? Desc : "Taken Money",
                                  -int.parse(amount),
                                  -int.parse(amount) +
                                      widget.CustomerHistory[
                                              widget.CustomerHistory.length - 1]
                                          ["Balance"]
                                ]);
                                widget.CustomerHistory.add({
                                  "UID": widget.userId,
                                  "Description":
                                      Desc != '' ? Desc : "Taken Money",
                                  "Action": int.parse(amount),
                                  "Balance": -int.parse(amount) +
                                      widget.CustomerHistory[
                                              widget.CustomerHistory.length - 1]
                                          ["Balance"],
                                });

                                widget.CustomerHistory = await dbHelper
                                    .getHistoryByUserId(widget.userId!);

                                List<int> BalanceCalculation =
                                    await dbHelper.getPositiveNegativeSum();

                                dbHelper.updateBalance(
                                    1,
                                    -1 * (BalanceCalculation[1]),
                                    BalanceCalculation[0]);

                                setState(() {
                                  SetupData();
                                });
                              } else {
                                print('User canceled');
                              }
                            },
                            child: const Text("MANA LIYA"),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

Future<List<String>?> Add_Payment(BuildContext context) async {
  TextEditingController Amount = TextEditingController();
  TextEditingController Description = TextEditingController();

  Completer<List<String>?> completer = Completer<List<String>?>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.27,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: Text(
                  "Khata Amount",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.54,
                height: MediaQuery.sizeOf(context).height * 0.05,
                child: TextField(
                  controller: Amount,
                  decoration: const InputDecoration(
                    hintText: 'Enter Your Amount',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.54,
                height: MediaQuery.sizeOf(context).height * 0.05,
                child: TextField(
                  controller: Description,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.54,
                margin: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          CustomerDetail = [{}];
                          CustomerHistory = [{}];
                          Navigator.pop(context);
                          completer.complete(null); // Signal cancellation
                        },
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: ElevatedButton(
                        child: const Text("Save"),
                        onPressed: () {
                          if (Amount.text != "") {
                            if (Description.text != '') {
                              completer
                                  .complete([Amount.text, Description.text]);
                            } else {
                              completer.complete([Amount.text, '']);
                            }

                            CustomerDetail = [{}];
                            CustomerHistory = [{}];
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  return completer.future;
}

Future<List<int>> viewHistory(
    BuildContext context, int userId, int action, String Desc) async {
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();
  amount.text = action.toString();
  description.text = Desc;

  var result = [0, 0];

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.27,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: Text(
                  "Khata Amount",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.54,
                height: MediaQuery.of(context).size.height * 0.05,
                child: TextField(
                  controller: amount,
                  enabled: false,
                  decoration: const InputDecoration(
                    hintText: 'Enter Your Amount',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.54,
                height: MediaQuery.of(context).size.height * 0.05,
                child: TextField(
                  enabled: false,
                  controller: description,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.54,
                margin: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red, // Change this to your desired color
                  ),
                  child: const Text("Delete"),
                  onPressed: () async {
                    dbHelper.deleteHistoryByUserId(userId,
                        action: action.toString(), description: Desc);
                    result = [-1, -1];
                    List<int> BalanceCalculation =
                        await dbHelper.getPositiveNegativeSum();

                    dbHelper.updateBalance(
                        1, BalanceCalculation[1], BalanceCalculation[0]);

                    Navigator.pop(context, result);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
  return result;
}
