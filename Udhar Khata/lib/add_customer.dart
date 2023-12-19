import 'package:flutter/material.dart';
import 'db.dart';

DatabaseHelper dbHelper = DatabaseHelper();

class Add_Customer extends StatefulWidget {
  const Add_Customer({super.key});

  @override
  State<Add_Customer> createState() => _Add_CustomerState();
}

final CountryCode = TextEditingController();
final PhoneNumber = TextEditingController();
final CustomerName = TextEditingController();

Widget InputUserName(BuildContext context) {
  return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: 60,
      padding: const EdgeInsets.only(left: 0, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.grey.shade300),
      ),
      child: ListTile(
        leading: Icon(Icons.person_add_alt_1),
        title: TextField(
          controller: CustomerName,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Type Customer Name',
          ),
        ),
      ));
}

Widget buildDropdown() {
  List<String> sampleValues = ['Option 1', 'Option 2'];
  String selectedValue = sampleValues[0];

  return DropdownButton<String>(
    value: selectedValue,
    onChanged: (String? newValue) {
      selectedValue = newValue!;
    },
    items: sampleValues.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget InputPhoneNumber(BuildContext context) {
  return Container(
    width: MediaQuery.sizeOf(context).width * 0.8,
    height: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 60,
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.grey.shade300),
          ),
          width: MediaQuery.sizeOf(context).width * 0.15,
          child: TextField(
            controller: CountryCode,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: '+92'),
          ),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width * 0.6,
          height: 60,
          padding: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.grey.shade300),
          ),
          child: ListTile(
            leading: const Icon(Icons.phone_iphone_rounded),
            title: TextField(
              controller: PhoneNumber,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Enter Phone Number'),
            ),
          ),
        ),
      ],
    ),
  );
}

String extractInitials(String fullName) {
  List<String> words = fullName.split(" ");

  String initials = words.length > 0 ? words[0][0] : "";
  if (words.length > 1) {
    initials += words[1][0];
  }
  return initials.toUpperCase();
}

Widget AddCustomerButton(context) {
  return Container(
    width: MediaQuery.sizeOf(context).width * 0.7,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () async {
        await dbHelper.insertUser({
          'UserCode': extractInitials(CustomerName.text),
          'Name': CustomerName.text,
          'PhoneCode': CountryCode.text,
          'PhoneNumber': PhoneNumber.text,
        });

        List<Map<String, dynamic>> user =
            await dbHelper.getUserByName(CustomerName.text);
        await dbHelper.insertHistory(user[0]["ID"], 'Initial', 0, 0);
        CustomerName.clear();
        PhoneNumber.clear();
        CountryCode.clear();
        Navigator.pop(context);
      },
      child: const Text("Add Customer"),
    ),
  );
}

class _Add_CustomerState extends State<Add_Customer> {
  DatabaseHelper dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_rounded),
            ),
            title: Text("Add New Customers"),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: MediaQuery.sizeOf(context).height * 0.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.red),
                    boxShadow: [
                      BoxShadow(blurRadius: 5, color: Colors.grey.shade200)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                        child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Image(
                        image: AssetImage("images/person.png"),
                        width: 250,
                        height: 250,
                      ),
                    )),
                    const SizedBox(height: 60),
                    Center(child: InputUserName(context)),
                    Center(child: InputPhoneNumber(context)),
                    Center(child: AddCustomerButton(context))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
