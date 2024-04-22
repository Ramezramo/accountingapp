import 'package:flutter/material.dart';
import 'package:accounting_app_last/pages/TVM_calculator/TVM_calculator.dart';
import 'package:accounting_app_last/pages/currency_calculator/currency_calc.dart';
// import 'package:accounting_app_last/pages/calculate_Income.dart';
// import 'package:accounting_app_last/pages/last_views/balancesheetmacker/balancesheetMaker.dart';
import 'package:accounting_app_last/pages/structure.dart';
import '../dephomepage/depreciationcalculater.dart';

class HomePageWithDrawerHeader extends StatefulWidget {
  const HomePageWithDrawerHeader({Key? key}) : super(key: key);

  @override
  State<HomePageWithDrawerHeader> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageWithDrawerHeader> {
  late int currentPage = 0;

  final List<Widget> bodies = [
    const Structure(),
    const DepreciationCalculator(),
    TVMcalculator(),
    CurrencyConverterForm(),
  ];

  final List<String> drawerItems = [
    'Main Page',
    'Depreciation Calculator',
    'TVM Calculator',
    'Currency Converter',
  ];

  final List<IconData> drawerIcons = [
    Icons.home,
    Icons.calculate,
    Icons.monetization_on,
    Icons.money,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    'Ramez Malak',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Added SizedBox for spacing
            for (int i = 0; i < drawerItems.length; i++)
              Column(
                children: [
                  ListTile(
                    leading: Icon(drawerIcons[i]), // Added icons to drawer items
                    title: Text(drawerItems[i]),
                    onTap: () {
                      setState(() {
                        currentPage = i;
                        Navigator.pop(context);
                      });
                    },
                  ),
                  const SizedBox(height: 10), // Added SizedBox for spacing
                ],
              ),
          ],
        ),
      ),
      body: bodies[currentPage],
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: HomePageWithDrawerHeader(),
//   ));
// }
