import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mebeluiexam/sms_verify/sms_verify_code.dart';

FirebaseAuth _authUser = FirebaseAuth.instance;

class SmsPage extends StatefulWidget {
  const SmsPage({Key? key}) : super(key: key);

  @override
  _SmsPageState createState() => _SmsPageState();
}

class _SmsPageState extends State<SmsPage> {
  var send = Firebase.initializeApp();
  var _formKey = GlobalKey<FormState>();
  String? phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Login Page With SMS",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              // Email
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  onSaved: (e) {
                    print("Telefon Uzunligi: ${e!.length}");
                    phone = e;
                  },
                  initialValue: "+998",
                  maxLength: 13,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Bo'sh Qolishi Mumkin Emas !";
                    }
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                child: Text("Sms Jo'nat !"),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifySmsCode(phone)));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
