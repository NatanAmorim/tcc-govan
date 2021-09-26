import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:govan/controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();

  @override
  void initState() {
    super.initState();
    controller.usernameController = TextEditingController();
    controller.passwordController = TextEditingController();
  }

  @override
  void dispose() {
    controller.usernameController.dispose();
    controller.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bem Vindo a goVan!',
                  style: GoogleFonts.roboto(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    height: 380,
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: controller.formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Fazer login',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            _buildUserTextField(),
                            SizedBox(
                              height: 10.0,
                            ),
                            _buildPasswordTextField(),
                            SizedBox(
                              height: 10.0,
                            ),
                            _buildLoginButton(),
                            SizedBox(
                              height: 15.0,
                            ),
                            _buildTextLinks(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserTextField() {
    return TextFormField(
      controller: controller.usernameController,
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
        hintText: "Usuário",
        labelText: "Usuário",
        prefixIcon: Icon(
          Icons.person,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: controller.passwordController,
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
      onFieldSubmitted: (_) async {
        setState(() {
          controller.isLoggingIn = true;
        });
        try {
          final response = controller.login(); // TODO: get return value
          // if (isLoggedIn) {
          //   Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          //   (Route<dynamic> route) => false,
          // );
          // }
        } finally {
          setState(() {
            controller.isLoggingIn = false;
          });
        }
      },
      obscureText: controller.isObscurePassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: "Senha",
        labelText: "Senha",
        hintStyle: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            controller.isObscurePassword
                ? Icons.visibility
                : Icons.visibility_off,
            color: Colors.grey[600],
          ),
          onPressed: () => setState(() {
            controller.isObscurePassword = !controller.isObscurePassword;
          }),
        ),
        prefixIcon: Icon(
          Icons.lock,
        ),
      ),
    );
  }

  Widget _buildTextLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Esqueçeu sua senha?",
          style: TextStyle(
            color: Colors.blue[800],
            decoration: TextDecoration.underline,
          ),
        ),
        Text(
          "Criar conta",
          style: TextStyle(
            color: Colors.blue[800],
            decoration: TextDecoration.underline,
          ),
        ),
      ],
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
            borderRadius: BorderRadius.circular(50.0),
          )),
        ),
        onPressed: controller.isLoggingIn ? null : () => controller.login(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: controller.isLoggingIn
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: LinearProgressIndicator(
                    color: Colors.purpleAccent,
                  ),
                )
              : Text(
                  "ENTRAR",
                  style: Theme.of(context).textTheme.button,
                ),
        ),
      ),
    );
  }
}
