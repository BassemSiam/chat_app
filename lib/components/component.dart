import 'package:chat_app/components/Const.dart';
import 'package:chat_app/models/Message_model.dart';
import 'package:flutter/material.dart';

Widget defultTextField({
  bool hideText = false,
  required TextEditingController controler,
  Color color = Colors.white,
  Color textColor = Colors.white,
  Widget? suffixIcon,
  Icon? prefixIcon,
  String? hintText,
  double fontSize = 18,
  final String? Function(String?)? validet,
  Function(String)? onSumbitted,
  Function(String)? onChange,
}) =>
    TextFormField(
      obscureText: hideText,
      onFieldSubmitted: onSumbitted,
      onChanged: onChange,
      validator: validet,
      controller: controler,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: color,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
          ),
        ),
      ),
    );

Widget defultButton({
  required String? TextInput,
  Color BackgroundColor = Colors.white,
  Color TextColor = Colors.black,
  required Function() onTap,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          '$TextInput',
          style: TextStyle(
            color: TextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

void ShowSnackBar(BuildContext context, String massage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Text(
            massage,
          ),
          Icon(
            Icons.accessibility_new,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}

void navigatTo(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void navigatAndRemove(BuildContext context, Widget screen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

class BubleChat extends StatelessWidget {
  BubleChat({required this.message});

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(8),
        child: Text(
          message.message!,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.blue),
      ),
    );
  }
}

class BubleChatRe extends StatelessWidget {
  BubleChatRe({required this.message});

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(8),
        child: Text(
          message.message!,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: primaryColor),
      ),
    );
  }
}





//  Align(
//             alignment: Alignment.centerRight,
//             child: Container(
//               padding: EdgeInsets.only(left: 15),
//               margin: EdgeInsets.all(16),
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'using flutter are you there?',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.white,
//                 ),
//               ),
//               height: 70,
//               width: 200,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                   color: Colors.blue),
//             ),
//           ),
        

