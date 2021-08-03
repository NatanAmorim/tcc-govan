import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController usernameController, passwordController;

  bool _isObscurePassword = true;
  bool _loggingIn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('goVan - Passageiro'),
        ),
        body: Container(
          child: Center(
            child: Card(
              child: Container(
                height: 375,
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        _buildUserTextField(),
                        SizedBox(
                          height: 15.0,
                        ),
                        _buildPasswordTextField(),
                        SizedBox(
                          height: 15.0,
                        ),
                        _buildLoginButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserTextField() {
    return TextFormField(
      controller: usernameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Digite seu nome de usuário';
        }
        return null;
      },
      style: GoogleFonts.roboto(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintStyle: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        hintText: "Nome do usuário",
        labelText: "Nome do usuário",
        prefixIcon: Icon(
          Icons.person,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Digite a sua senha';
        } else if (value.length < 4) {
          return 'Mínimo 4 caracteres';
        }
        return null;
      },
      style: GoogleFonts.roboto(),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => login(),
      obscureText: _isObscurePassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: "Digite sua Senha",
        labelText: "Digite sua Senha",
        hintStyle: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey[600],
          ),
          onPressed: () => setState(() {
            _isObscurePassword = !_isObscurePassword;
          }),
        ),
        prefixIcon: Icon(
          Icons.lock,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 68.0,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).accentColor,
          ),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          )),
        ),
        onPressed: _loggingIn ? null : () => login(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: _loggingIn
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  "ENTRAR",
                  style: Theme.of(context).textTheme.button,
                ),
        ),
      ),
    );
  }

  login() async {
    setState(() {
      _loggingIn = !_loggingIn;
    });
    try {
      // bool isLoggedIn = await controller.login();

      // if (isLoggedIn) {
      //   Get.off(() => PacScreen());
      // }
    } finally {
      setState(() {
        _loggingIn = !_loggingIn;
      });
    }
  }

  Future<bool> auth() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return false;
    }

    var request = <String, String>{
      'usuario_username': usernameController.text,
      'usuario_senha': passwordController.text,
    };

    await Future.delayed(const Duration(seconds: 2));

    if (usernameController.text == 'admin' &&
        passwordController.text == 'admin') {
      return true;
    } else {
      return false;
    }
  }
}
