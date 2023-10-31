import 'package:flutter/material.dart';
import 'package:project/utils/api_login.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscured = true;
  bool isSignUpView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _isObscured ? Colors.grey : Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final username = usernameController.text;
                          final password = passwordController.text;

                          if (isSignUpView) {
                            signUp(username, password);
                          } else {
                            login(username, password);
                          }
                        },
                        icon: Icon(Icons.person),
                        label: Text(
                          isSignUpView ? 'Sign Up' : 'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          shadowColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 30,
                          ),
                          tapTargetSize: MaterialTapTargetSize.padded,
                          animationDuration: Duration(milliseconds: 200),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (isSignUpView) {
                            isSignUpView = false;
                          } else {
                            isSignUpView = !isSignUpView;
                          }
                        });
                      },
                      child: Text(
                        isSignUpView
                            ? 'Sudah punya akun? Login'
                            : 'Belum punya akun? Sign up',
                        style: TextStyle(
                          color: isSignUpView ? Colors.blue : Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp(String username, String password) async {
    print('Signing up with Username: $username, Password: $password');
    // Implementasi sign-up Anda di sini
  }

  Future<void> login(String username, String password) async {
    final api = ApiLogin();
    final isInputValid = await api.inputCheck(username, password);

    if (isInputValid) {
      // Login berhasil, lanjutkan ke halaman beranda atau lakukan tindakan yang sesuai.
      Navigator.pushReplacementNamed(context, '/');
    } else {
      // Login gagal, tampilkan pesan kesalahan atau ambil tindakan lain sesuai kebutuhan.
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Gagal'),
            content: Text('Username atau password salah. Silakan coba lagi.'),
            actions: <Widget>[
              TextButton(
                // Ganti FlatButton menjadi TextButton
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
