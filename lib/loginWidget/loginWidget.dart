// import 'package:flutter/material.dart';

// class MyHomePage extends StatelessWidget {
//   final AuthService authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: authService.isLoggedIn(),
//       builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.data == true) {
//             return LoggedInWidget();
//           } else {
//             return NotLoggedInWidget();
//           }
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
//   void widget(){
    
//   }
// }
