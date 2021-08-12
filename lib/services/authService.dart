// import 'package:flutter/material.dart';
// import 'package:flutter_tutorial/services/auth.dart';

// class AuthProvider extends InheritedWidget {
//   AuthProvider({
//     Key key,
//     @required this.auth,
//     this.child,
//   }) : super(
//           key: key,
//           child: child,
//         );
//   final Widget child;
//   final AuthBase auth;

//   static AuthBase of(BuildContext context) {
//     AuthProvider provider =
//         context.dependOnInheritedWidgetOfExactType<AuthProvider>();
//     return provider.auth;
//   }

//   @override
//   bool updateShouldNotify(AuthProvider oldWidget) {
//     return true;
//   }
// }
