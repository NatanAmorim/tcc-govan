import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:govan/controllers/cadastro_controller.dart';
import 'package:govan/views/login_page.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final controller = CadastroController();

  @override
  void initState() {
    super.initState();
    controller.emailController = TextEditingController();
    controller.passwordController = TextEditingController();
  }

  @override
  void dispose() {
    controller.emailController.dispose();
    controller.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cadastro',
                  style: GoogleFonts.roboto(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                const SizedBox(height: 10.0),
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
                              "Insira seus dados",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            const SizedBox(height: 10.0),
                            _buildUserTextField(),
                            const SizedBox(height: 10.0),
                            _buildPasswordTextField(),
                            const SizedBox(height: 10.0),
                            _buildSignUpButton(),
                            const SizedBox(height: 15.0),
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
        labelText: "E-mail*",
        prefixIcon: const Icon(Icons.person),
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
          final bool response = await controller.cadastrar(
            context: context,
          );
          if (response == true) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage()),
              (Route<dynamic> route) => false,
            );
          }
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
        labelText: "Senha*",
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
        prefixIcon: const Icon(Icons.lock),
      ),
    );
  }

  Widget _buildSignUpButton() {
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
        onPressed: () async {
          setState(() {
            controller.isLoggingIn = true;
          });
          try {
            final bool response = await controller.cadastrar(
              context: context,
            );
            if (response == true) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            }
          } finally {
            setState(() {
              controller.isLoggingIn = false;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: controller.isLoggingIn
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: LinearProgressIndicator(color: Colors.white),
                )
              : Text(
                  "Cadastrar",
                  style: Theme.of(context).textTheme.button,
                ),
        ),
      ),
    );
  }

  Widget _buildTextLinks() {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginPage()),
            (Route<dynamic> route) => false,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Fazer login",
            style: TextStyle(
              color: Colors.blue[800],
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
