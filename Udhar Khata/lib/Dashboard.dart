// import 'package:flutter/material.dart';
// import 'package:udhar_khata/KhataPage.dart';
// import 'add_customer.dart';
// import 'db.dart';

// var GiveBalance = 0;
// var TakeBalance = 0;
// DatabaseHelper dbHelper = DatabaseHelper();
// List<Map<String, dynamic>> allUserHistory = [{}];
// List<Map<String, dynamic>> allUsers = [{}];
// List<Map<String, dynamic>> UserBalance = [{}];
// List<String> UserKeyCodes = [];
// List<String> UserUIDCodes = [];
// List<Map<String, dynamic>> userHistory = [{}];

// TextEditingController CustomerSearchController = TextEditingController();

// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   void UpdateHistoryData() async {
//     allUsers = await dbHelper.getAllUsers();
//     allUserHistory = await dbHelper.getAllUserHistory();
//     UserBalance = await dbHelper.getAllBalances();

//     if (UserBalance.length <= 0) {
//       dbHelper.insertBalance(0, 0);
//       UserBalance = await dbHelper.getAllBalances();
//     } else {
//       GiveBalance = UserBalance[UserBalance.length - 1]["Give"];
//       TakeBalance = UserBalance[UserBalance.length - 1]["Take"];
//     }
//     setState(() {
//       print("############# ${GiveBalance} ${TakeBalance}");
//       print("##### Content Loaded");
//     });
//   }

//   void UpdateUserBalance() async {}

//   List<Widget> CustomersData(BuildContext context) {
//     List<Widget> Customers = [];

//     for (var users in allUsers) {
//       var id = users["ID"];
//       var key = users["UserCode"];
//       if (id == null && key == null) {
//         return [Container()];
//       }

//       Future<int> GetHistory(id) async {
//         Future<int> getUserHistory(userId) async {
//           userHistory = await dbHelper.getHistoryByUserId(userId);
//           return 1;
//         }

//         await getUserHistory(id);
//         return 1;
//       }

//       GetHistory(id);
//       setState(() {
//         userHistory = userHistory;
//       });

//       var temp = userHistory.length;
//       print(temp);
//       if (temp > 0) {
//         var balance = userHistory[userHistory.length - 1]["Balance"];
//         print("########## Blace ${balance}");
//         print("########## Blace ${userHistory[userHistory.length - 1]}");
//         if (balance == null) {
//           return [Container()];
//         }
//         Customers.add(
//           GestureDetector(
//             onTap: () async {
//               final result = await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Khata(
//                     UserHistory: [{}],
//                     UserKhata: 10,
//                     userId: 1,
//                   ),
//                 ),
//               );
//               setState(() {
//                 UpdateHistoryData();
//               });
//             },
//             child: Container(
//               width: MediaQuery.sizeOf(context).width,
//               height: MediaQuery.sizeOf(context).height * 0.08,
//               padding: EdgeInsets.only(
//                   top: MediaQuery.sizeOf(context).height * 0.015),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(blurRadius: 1, color: Colors.grey.shade300)
//                 ],
//               ),
//               // padding: EdgeInsets.all(10),
//               child: ListTile(
//                 leading: Container(
//                   width: 27,
//                   height: 27,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       color: Colors.grey.shade300),
//                   child: Center(
//                     child: Text(
//                       key,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 title: Text(key),
//                 trailing: Text(
//                   "Rs ${userHistory[userHistory.length - 1]['Balance']}"
//                       .replaceFirst('-', ''),
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: balance >= 0 ? Colors.green : Colors.red,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//     }
//     return Customers;
//   }

//   Widget Customers(context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height * 0.8,
//       color: Colors.white,
//       child: SingleChildScrollView(
//         child: Column(
//           children: CustomersData(context),
//         ),
//       ),
//     );
//   }

//   BoxDecoration decorationStyle(clr, rds, bdr) {
//     Border Bdr_Style;
//     if (bdr[0] > 0.0) {
//       Bdr_Style = Border.all(width: bdr[0], color: bdr[1]);
//     } else {
//       Bdr_Style = Border.all(width: bdr[0], color: bdr[1]);
//     }
//     return BoxDecoration(
//         borderRadius: BorderRadius.circular(rds),
//         color: clr,
//         border: Bdr_Style);
//   }

//   Text customTextBox(txt, fnt, clr, aln, tpe) {
//     FontWeight fntType;
//     if (tpe == "bold") {
//       fntType = FontWeight.bold;
//     } else {
//       fntType = FontWeight.normal;
//     }

//     return Text(
//       txt,
//       style: TextStyle(fontSize: fnt, color: clr, fontWeight: fntType),
//       textAlign: aln,
//     );
//   }

//   Widget appBarContent(context) {
//     return Container(
//       width: MediaQuery.sizeOf(context).width,
//       height: MediaQuery.sizeOf(context).height * 0.15,
//       color: Colors.white,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Container(
//               width: MediaQuery.sizeOf(context).width * 0.45,
//               height: 80,
//               margin: const EdgeInsets.only(bottom: 10),
//               // padding: const EdgeInsets.all(10),
//               decoration: decorationStyle(
//                   Colors.redAccent.withOpacity(0.4), 10.0, [0.0, Colors.white]),
//               child: ListTile(
//                 leading: Icon(
//                   Icons.arrow_circle_down_outlined,
//                   color: Colors.red.shade800,
//                   size: 30,
//                 ),
//                 title: customTextBox("Rs ${TakeBalance}", 17.0,
//                     Colors.red.shade800, TextAlign.left, "bold"),
//                 subtitle: customTextBox("You have to Take", 12.5,
//                     Colors.red.shade800, TextAlign.left, "nr"),
//               )),
//           const SizedBox(width: 10),
//           Container(
//               width: MediaQuery.sizeOf(context).width * 0.45,
//               height: 80,
//               margin: const EdgeInsets.only(bottom: 10),
//               decoration: decorationStyle(Color.fromARGB(255, 27, 230, 68),
//                   10.0, [0.0, Colors.blueGrey]),
//               child: ListTile(
//                 leading: Icon(
//                   Icons.arrow_circle_up_outlined,
//                   color: Colors.green.shade800,
//                   size: 30,
//                 ),
//                 title: customTextBox("Rs ${GiveBalance}", 17.0,
//                     Colors.green.shade800, TextAlign.left, "bold"),
//                 subtitle: customTextBox("You have to Give", 12.0,
//                     Colors.green.shade800, TextAlign.left, "nr"),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget CustomerSearch(context) {
//     return Container(
//       width: MediaQuery.sizeOf(context).width,
//       height: MediaQuery.sizeOf(context).height * 0.07,
//       color: Colors.white,
//       padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               height: MediaQuery.sizeOf(context).height * 0.055,
//               decoration:
//                   decorationStyle(Colors.white, 10.0, [1.0, Colors.grey]),
//               padding: EdgeInsets.only(left: 20),
//               child: TextField(
//                 controller: CustomerSearchController,
//                 decoration: InputDecoration(
//                     hintText: 'Search Customers',
//                     border: InputBorder.none,
//                     hintStyle: TextStyle(fontWeight: FontWeight.normal)),
//               ),
//             ),
//           ),
//           Container(
//             width: 60,
//             child: GestureDetector(
//               child: const Icon(
//                 Icons.picture_as_pdf,
//                 color: Colors.red,
//                 size: 30,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget addNewCustomer(context) {
//     return Container(
//       width: MediaQuery.sizeOf(context).width * 0.5,
//       height: 40,
//       child: FloatingActionButton(
//         foregroundColor: Colors.white,
//         backgroundColor: Colors.redAccent,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(
//               10), // Set borderRadius to 0 for a rectangle
//         ),
//         child: Text("Add New Customer"),
//         onPressed: () async {
//           print("Add Customer");
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Add_Customer(),
//             ),
//           );
//           setState(() {
//             UpdateHistoryData();
//           });
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           appBarContent(context),
//           CustomerSearch(context),
//           Expanded(
//             child: Stack(
//               children: [
//                 Customers(context),
//                 Positioned(
//                   top: MediaQuery.sizeOf(context).height -
//                       MediaQuery.sizeOf(context).height * 0.28,
//                   left: MediaQuery.sizeOf(context).width * 0.27,
//                   child: addNewCustomer(context),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:udhar_khata/KhataPage.dart';
import 'add_customer.dart';
import 'db.dart';
import 'pdf.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late DatabaseHelper dbHelper;
  late List<Map<String, dynamic>> allUsers;
  late List<Map<String, dynamic>> userBalance;
  late TextEditingController customerSearchController;
  late ExcelGenerator excelGenerator;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    excelGenerator = ExcelGenerator();
    allUsers = [];
    userBalance = [];
    customerSearchController = TextEditingController();
    _updateData();
  }

  Future<void> _updateData() async {
    allUsers = await dbHelper.getAllUsers();
    userBalance = await dbHelper.getAllBalances();

    if (userBalance.isEmpty) {
      dbHelper.insertBalance(0, 0);
      userBalance = await dbHelper.getAllBalances();
    }

    setState(() {});
  }

  Widget _appBarContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _balanceTile(
              context,
              Icons.arrow_circle_down_outlined,
              Colors.red.shade800,
              userBalance.length > 0 ? userBalance[0]["Take"] : 0,
              "You have to Take"),
          const SizedBox(width: 10),
          _balanceTile(
              context,
              Icons.arrow_circle_up_outlined,
              Colors.green.shade800,
              userBalance.length > 0 ? userBalance[0]["Give"] : 0,
              "You have to Give"),
        ],
      ),
    );
  }

  Widget _balanceTile(BuildContext context, IconData icon, Color color,
      int balance, String subtitle) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: 80,
      margin: const EdgeInsets.only(bottom: 10),
      decoration:
          _decorationStyle(color.withOpacity(0.4), 10.0, [0.0, Colors.white]),
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
          size: 30,
        ),
        title:
            _customTextBox("Rs $balance", 17.0, color, TextAlign.left, "bold"),
        subtitle: _customTextBox(subtitle, 12.5, color, TextAlign.left, "nr"),
      ),
    );
  }

  BoxDecoration _decorationStyle(Color clr, double rds, List<dynamic> bdr) {
    Border bdrStyle;
    if (bdr[0] > 0.0) {
      bdrStyle = Border.all(width: bdr[0], color: bdr[1]);
    } else {
      bdrStyle = Border.all(width: bdr[0], color: bdr[1]);
    }
    return BoxDecoration(
        borderRadius: BorderRadius.circular(rds), color: clr, border: bdrStyle);
  }

  Text _customTextBox(
      String txt, double fnt, Color clr, TextAlign aln, String tpe) {
    FontWeight fntType;
    if (tpe == "bold") {
      fntType = FontWeight.bold;
    } else {
      fntType = FontWeight.normal;
    }

    return Text(
      txt,
      style: TextStyle(fontSize: fnt, color: clr, fontWeight: fntType),
      textAlign: aln,
    );
  }

  Widget _customerSearch(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.055,
              decoration:
                  _decorationStyle(Colors.white, 10.0, [1.0, Colors.grey]),
              padding: EdgeInsets.only(left: 20),
              child: TextField(
                controller: customerSearchController,
                onChanged: (value) {
                  _updateData(); // Trigger data update when search input changes
                },
                decoration: InputDecoration(
                  hintText: 'Search Customers',
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
          Container(
            width: 60,
            child: GestureDetector(
              onTap: () async {
                await ExcelGenerator.generateExcel();
              },
              child: const Icon(
                Icons.picture_as_pdf,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> getFilteredUsers(String searchTerm) {
    // Filter users based on the search term
    return allUsers
        .where((user) =>
            user["Name"].toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
  }

  Widget _addNewCustomer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 40,
      child: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text("Add New Customer"),
        onPressed: () async {
          print("Add Customer");
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Add_Customer(),
            ),
          );
          _updateData();
        },
      ),
    );
  }

  Widget _customers(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      color: Colors.white,
      child: SingleChildScrollView(
        child: _buildCustomerList(context),
      ),
    );
  }

  Widget _buildCustomerList(BuildContext context) {
    // Use filteredUsers instead of allUsers
    List<Map<String, dynamic>> filteredUsers = getFilteredUsers(
        customerSearchController.text); // Pass the current search term
    return Column(
      children: filteredUsers.map((user) {
        return _buildCustomerItem(context, user);
      }).toList(),
    );
  }

  Widget _buildCustomerItem(BuildContext context, Map<String, dynamic> user) {
    var id = user["ID"];
    var key = user["UserCode"];
    var customerName = user["Name"];

    if (id == null && key == null) {
      return Container();
    }

    Future<List<Map<String, dynamic>>> getHistory(int userId) async {
      List<Map<String, dynamic>> userHistory =
          await dbHelper.getHistoryByUserId(userId);
      return userHistory;
    }

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getHistory(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // or some loading indicator
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        var userHistory = snapshot.data ?? [];

        if (userHistory.isNotEmpty) {
          var lastHistoryEntry = userHistory[userHistory.length - 1];
          var balance = lastHistoryEntry["Balance"];

          if (balance == null) {
            return Container();
          }

          return GestureDetector(
            onTap: () async {
              var AllUserHistory = await dbHelper.getHistoryByUserId(id);
              var customerDetails = await dbHelper.getUserByID(id);

              List<Map<String, dynamic>> updatedHistory =
                  List.from(AllUserHistory);
              List<Map<String, dynamic>> updatedCustomer =
                  List.from(customerDetails);

              // updatedHistory.add({
              //   "UID": id,
              //   "Description": "Des2",
              //   "Action": 100,
              //   "Balance": 200,
              // });

              print("### ${updatedHistory}");
              print("### ${updatedCustomer}");

              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Khata(
                    CustomerHistory: updatedHistory,
                    CustomerDetail: updatedCustomer,
                    userId: id,
                  ),
                ),
              );
              _updateData();
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.08,
              padding: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height * 0.015,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(blurRadius: 1, color: Colors.grey.shade300)
                ],
              ),
              child: ListTile(
                leading: Container(
                  width: 27,
                  height: 27,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.shade300,
                  ),
                  child: Center(
                    child: Text(
                      key,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                title: Text(customerName),
                trailing: Text(
                  "Rs ${balance}",
                  style: TextStyle(
                    fontSize: 15,
                    color: balance >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBarContent(context),
          _customerSearch(context),
          Expanded(
            child: Stack(
              children: [
                _customers(context),
                Positioned(
                  top: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height * 0.28,
                  left: MediaQuery.of(context).size.width * 0.27,
                  child: _addNewCustomer(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
