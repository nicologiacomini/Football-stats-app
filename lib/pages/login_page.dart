import 'package:flutter/material.dart';
import 'package:betstats_app/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    var signInDone = await Auth.mailSignIn(
        _userController.text.trim(), _passwordController.text.trim());
    if (signInDone != null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username o password errati")));
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _hidePassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/title.png",
          height: 50.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text(
                "Benvenuto",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 53, 157),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(20.0),
              child: TextField(
                cursorColor: const Color.fromARGB(255, 4, 53, 157),
                keyboardType: TextInputType.emailAddress,
                // autofillHints: const [AutofillHints.email],
                controller: _userController,
                style: const TextStyle(fontSize: 15.0),
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  iconColor: Color.fromARGB(255, 4, 53, 157),
                  border: InputBorder.none,
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 4, 53, 157),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(20.0),
              child: TextField(
                cursorColor: const Color.fromARGB(255, 4, 53, 157),
                obscureText: _hidePassword,
                keyboardType: TextInputType.visiblePassword,
                // autofillHints: const [AutofillHints.password],
                controller: _passwordController,
                style: const TextStyle(fontSize: 15.0),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _hidePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    color: const Color.fromARGB(255, 4, 53, 157),
                    onPressed: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    },
                  ),
                  icon: const Icon(Icons.key),
                  iconColor: const Color.fromARGB(255, 4, 53, 157),
                  border: InputBorder.none,
                  labelText: "Password",
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 4, 53, 157),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: signIn,
                child: const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 4, 53, 157),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
