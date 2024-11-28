import 'package:finance/_backend/users.dart';
import 'package:finance/provider/stock_provider.dart';
import 'package:finance/services/stock_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestDY extends StatefulWidget {
  const TestDY({super.key});

  @override
  State<TestDY> createState() => _TestDYState();
}

class _TestDYState extends State<TestDY> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _userService = UserService();
  String _responseMessage = '';

  void _register() async {
    final id = _idController.text;
    final password = _passwordController.text;
    final username = _usernameController.text;
    final email = _emailController.text;

    if (id.isEmpty || username.isEmpty || password.isEmpty || email.isEmpty) {
      setState(() {
        _responseMessage = '모든 필드를 입력해주세요.';
      });
      return;
    }

    // AuthService를 통해 회원가입 요청
    final response =
        await _userService.registerUser(id, password, username, email);
    setState(() {
      _responseMessage = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 토큰발급
    final accessToken = Provider.of<StockProvider>(context).accessToken;

    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Center(
          child: TextButton(
            onPressed: () => {
              StockService().getForeignMajorIndex(accessToken, 'FX@KRWJS', 'X'),
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.greenAccent,
            ),
            child: const Text('Test 버튼'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _idController,
                decoration: InputDecoration(labelText: '아이디'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: '비밀번호'),
                obscureText: true,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: '이름'),
                obscureText: true,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: '이메일'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('회원가입'),
              ),
              SizedBox(height: 20),
              Text(
                _responseMessage,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
