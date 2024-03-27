import 'package:accountingapp/views/balancesheetmacker/balancesheetMaker.dart';
import 'package:flutter/material.dart';

import '../depreciation/depreciationcalculater.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController textField1Controller = TextEditingController();

  final TextEditingController textField2Controller = TextEditingController();

  final List bodies  = [const DepreciationCalculator(),const BalanceSheetMaker()];

  late  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Programmed by',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'ramez malak',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('depreciation calculator'),
              onTap: () {
                setState(() {
                  currentPage = 0;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text('balance sheet'),
              onTap: () {
                setState(() {
                  currentPage = 1;
                  Navigator.pop(context);
                });
              },
            ),
            // You can add more ListTile widgets for additional links
          ],
        ),
      ),
      body:  bodies[currentPage],
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Handle the additional button press
      //   },
      //   child: const Icon(Icons.web_sharp),
      // ),
    );
  }
}
