import 'package:flutter/material.dart';
import 'package:milkcollection/help/login_helper.dart';
import 'package:milkcollection/models/login.dart';
import 'package:milkcollection/page/dashboard.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  Login_modle? login_modle;

  checkpassword() async {
    Login login = Login();
    login_modle = await login.getLoginData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("here is default data, you don't need to chnage this"),
            TextField(
              controller: TextEditingController()..text = 'F01',
              onChanged: (text) => {},
            ),
            TextField(
              controller: TextEditingController()..text = '7490000624',
              onChanged: (text) => {},
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async{
                  await checkpassword();
                  if (login_modle!.message == "success") {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DeshboardPage(
                              name: login_modle!.FarmerName,
                              code: login_modle!.FarmerCode,
                            )));
                  }
                },
                child: const Text("submit", style: TextStyle(color: Colors.blue),))
          ],
        ),
      ),
    );
  }
}
