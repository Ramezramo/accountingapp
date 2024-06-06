import 'package:accounting_app_last/newdfiles/dboperations/categoryobject.dart';
import 'package:accounting_app_last/newdfiles/dboperations/financialaccount.dart';
import 'package:accounting_app_last/newdfiles/dboperations/transaction_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cubit/cubit/general/dboperationsbloc_cubit.dart';
// import '../../bloc/cubit/dboperationsbloc_cubit.dart';
import '../../dboperations/DealWithDataBase.dart';
// import 'dboperationsbloc_cubit.dart';

class DbOperationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Database Operations')),
      body: Center(
        child: BlocBuilder<DboperationsblocCubit, DboperationsblocState>(
          builder: (context, state) {
            if (state is DboperationsblocInitial) {
              return Text('Press the button to perform DB operation');
            } else if (state is AddingTransactionblocLoading) {
              return CircularProgressIndicator();
            } else if (state is AddingTransactionblocSuccess) {
              return Text('Success: ${state.result}',
                  style: TextStyle(fontSize: 24));
            } else if (state is AddingTransactionblocFailure) {
              return Text('Error: ${state.error}',
                  style: TextStyle(color: Colors.red));
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              // context.read<DboperationsblocCubit>().insertData();
            },
            child: Icon(Icons.play_arrow),
          ),
          // FloatingActionButton(
          //   onPressed: () =>
          //       context.read<DboperationsblocCubit>().performDbOperation(),
          //   child: Icon(Icons.play_arrow),
          // ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../bloc/cubit/dboperationsbloc_cubit.dart';
// import '../../dboperations/DealWithDataBase.dart';
// import 'details_page.dart';

// class DbOperationsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Database Operations')),
//       body: Center(
//         child: BlocConsumer<DboperationsblocCubit, DboperationsblocState>(
//           listener: (context, state) {
//             if (state is DboperationsblocSuccess) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailsPage(data: state.result),
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is DboperationsblocInitial) {
//               return Text('Press the button to perform DB operation');
//             } else if (state is DboperationsblocLoading) {
//               return CircularProgressIndicator();
//             } else if (state is DboperationsblocSuccess) {
//               return Text('Success: ${state.result}', style: TextStyle(fontSize: 24));
//             } else if (state is DboperationsblocFailure) {
//               return Text('Error: ${state.error}', style: TextStyle(color: Colors.red));
//             }
//             return Container();
//           },
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               context.read<DboperationsblocCubit>().insertData();
//             },
//             child: Icon(Icons.add),
//           ),
//           SizedBox(width: 20),
//           FloatingActionButton(
//             onPressed: () => context.read<DboperationsblocCubit>().performDbOperation(),
//             child: Icon(Icons.play_arrow),
//           ),
//         ],
//       ),
//     );
//   }
// }
