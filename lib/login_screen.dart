import 'package:flutter/material.dart';
import 'package:stopwatch/stopwatch.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String name;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Runner'),
              validator: (text) =>
                  text!.isEmpty ? 'Enter the runner name' : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text!.isEmpty) return 'Enter runner email';
                final regex = RegExp(r"[^@]+@[^\.]+\..+");
                if (!regex.hasMatch(text)) return 'Enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _validate, child: const Text('Continue')),
          ],
        ),
      ),
    );
  }

  void _validate() {
    final form = _formKey.currentState;
    if (!form!.validate()) return;

    final name = _nameController.text;
    final email = _emailController.text;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => StopWatch(name: name, email: email),
      ),
    );
  }
}
