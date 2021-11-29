import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:govan/controllers/login_controller.dart';
import 'package:govan/views/cadastro_page.dart';
import 'package:govan/views/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = LoginController();

  @override
  void initState() {
    super.initState();
    controller.isLoggingIn = false;

    controller.emailController = TextEditingController();
    controller.senhaController = TextEditingController();
  }

  @override
  void dispose() {
    controller.emailController.dispose();
    controller.senhaController.dispose();
    super.dispose();
  }

  bool _isObscurePassword = true;
  bool _loggingIn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('goVan - Passagueiro'),
        ),
        body: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Card(
              child: Container(
                height: 361,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: controller.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
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
                          height: 15.0,
                        ),
                        _buildPasswordTextField(context: context),
                        SizedBox(
                          height: 15.0,
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
          ),
        ),
      ),
    );
  }

  Widget _buildUserTextField() {
    return TextFormField(
      autofocus: true,
      controller: controller.emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Digite seu E-mail';
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
        labelText: "E-mail",
        prefixIcon: Icon(
          Icons.person,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField({required BuildContext context}) {
    return TextFormField(
      controller: controller.senhaController,
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
      onFieldSubmitted: (_) => login(context),
      obscureText: _isObscurePassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        labelText: "Senha",
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
        InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const CadastroPage()),
              (Route<dynamic> route) => false,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Criar conta",
              style: TextStyle(
                color: Colors.blue[800],
                decoration: TextDecoration.underline,
              ),
            ),
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
        onPressed: controller.isLoggingIn ? null : () => login(context),
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

  login(BuildContext context) async {
    setState(() {
      controller.isLoggingIn = !controller.isLoggingIn;
    });
    try {
      final bool isLoggedIn = await controller.login(context: context);

      if (isLoggedIn) {
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } finally {
      setState(() {
        controller.isLoggingIn = !controller.isLoggingIn;
      });
    }
  }
}
