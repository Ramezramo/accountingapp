// import 'package:accountingapp/views/depreciation/StraightLineDepreciation.dart';
// import 'package:accountingapp/views/dephomepage/reducingbalancedp/ReducingBalanceDepreciation.dart';
import 'package:flutter/material.dart';
import 'package:sossoldi/pages/last_views/dephomepage/reducingbalancedp/ReducingBalanceDepreciation.dart';

import 'straitlinedepreciation/StraightLineDepreciation.dart';

class DepreciationCalculator extends StatefulWidget {
  const DepreciationCalculator({Key? key}) : super(key: key);

  @override
  State<DepreciationCalculator> createState() =>
      _DepreciationCalculatorState();
}

class _DepreciationCalculatorState extends State<DepreciationCalculator> {
  int _selectedIndex = 0;

  static  final List<Widget> _widgetOptions = <Widget>[
    StriaghtLineDep(),
     reducingBalance(),
    const Text('Page 3'),
    const Text('Page 4'), // Added fourth page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depreciation Calculator'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Set type to fixed
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Straight Line Depreciation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Reducing Balance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Units of production',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Fourth Page',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        selectedFontSize: 12, // Adjust the font size for selected items
        unselectedFontSize: 9, // Adjust the font size for unselected items
        selectedIconTheme: const IconThemeData(size: 30), // Adjust icon size for selected items
        unselectedIconTheme: const IconThemeData(size: 24), // Adjust icon size for unselected items
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Depreciation Calculator',
    home: DepreciationCalculator(),
  ));
}



// import 'package:flutter/material.dart';
//
// class DepreciationCalculator extends StatefulWidget {
//   const DepreciationCalculator({Key? key}) : super(key: key);
//
//   @override
//   State<DepreciationCalculator> createState() =>
//       _DepreciationCalculatorState();
// }
//
// class _DepreciationCalculatorState extends State<DepreciationCalculator> {
//   int _selectedIndex = 0;
//
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text('Page 1'),
//     Text('Page 2'),
//     Text('Page 3'),
//     Text('Page 4'), // Added fourth page
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Depreciation Calculator'),
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed, // Set type to fixed
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Image.asset("assets/images/bar-chart.png",height: 20,width: 20,),
//             label: 'Strait line depreciation',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: 'Double declining balance',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             label: 'Units of production',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             label: 'Fourth Page',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     title: 'Depreciation Calculator',
//     home: DepreciationCalculator(),
//   ));
// }
