import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function(String email, String password, String username, bool signup)
      submitAuthForm;

  const AuthForm({Key? key, required this.submitAuthForm}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _signupMode = false;

  String _email = '';
  String _username = '';
  String _password = '';

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate() == true;
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState?.save();

      widget.submitAuthForm(_email, _password, _username, _signupMode);
    }
  }

  void _toggleSignupMode() {
    setState(() {
      _signupMode = !_signupMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: const ValueKey("email"),
                  validator: (value) =>
                      value == null || value.isEmpty || !value.contains('@')
                          ? 'Please enter a valid email address'
                          : null,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email address",
                  ),
                  onSaved: (value) {
                    _email = value ?? '';
                  },
                ),
                if (_signupMode)
                  TextFormField(
                    key: const ValueKey("username"),
                    validator: (value) =>
                        _signupMode && (value == null || value.length < 4)
                            ? 'A username should be at least 4 characters long'
                            : null,
                    decoration: const InputDecoration(
                      labelText: "Username",
                    ),
                    onSaved: (value) {
                      _username = value ?? "";
                    },
                  ),
                TextFormField(
                  key: const ValueKey("password"),
                  validator: (value) => value == null || value.length < 8
                      ? 'A password should be at least 8 characters long'
                      : null,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                  onSaved: (value) {
                    _password = value ?? "";
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_signupMode ? "Sign up" : "Login")),
                TextButton(
                  onPressed: _toggleSignupMode,
                  child: Text(_signupMode
                      ? "I already have an account"
                      : "Create a new account"),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
