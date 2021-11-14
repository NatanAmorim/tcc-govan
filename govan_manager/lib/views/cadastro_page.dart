import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:govan/controllers/cadastro_controller.dart';
import 'package:govan/views/login_page.dart';
import 'package:govan/widgets/integer_field.dart';

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
    controller.cnhController = TextEditingController();
    controller.cepController = TextEditingController();
    controller.bairroController = TextEditingController();
    controller.cidadeController = TextEditingController();
    controller.logadouroController = TextEditingController();
    controller.numeroController = TextEditingController();
    controller.complementoController = TextEditingController();
    controller.nomeController = TextEditingController();
    controller.rgController = TextEditingController();
    controller.cpfController = TextEditingController();
  }

  @override
  void dispose() {
    controller.emailController.dispose();
    controller.passwordController.dispose();
    controller.cnhController.dispose();
    controller.cepController.dispose();
    controller.bairroController.dispose();
    controller.cidadeController.dispose();
    controller.logadouroController.dispose();
    controller.numeroController.dispose();
    controller.complementoController.dispose();
    controller.nomeController.dispose();
    controller.rgController.dispose();
    controller.cpfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Cadastro de Motorista'),
        ),
        key: controller.scaffoldKey,
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Cadastro",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
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
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
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
                                      builder: (BuildContext context) =>
                                          const LoginPage()),
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
                                controller.isObscurePassword =
                                    !controller.isObscurePassword;
                              }),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                          ),
                        ), // const
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: controller.nomeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu Nome Completo';
                            }
                            return null;
                          },
                          style: GoogleFonts.roboto(),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: "Nome Completo*",
                            prefixIcon: const Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: controller.cnhController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite o número de CNH';
                            }
                            return null;
                          },
                          style: GoogleFonts.roboto(),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: "CNH*",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: controller.rgController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu RG';
                            }
                            return null;
                          },
                          style: GoogleFonts.roboto(),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: "RG*",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: controller.cpfController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu CPF';
                            }
                            return null;
                          },
                          style: GoogleFonts.roboto(),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: "CPF*",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "Endereço",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: controller.cepController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu CEP';
                            }
                            return null;
                          },
                          style: GoogleFonts.roboto(),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: "CEP*",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: controller.bairroController,
                          validator: (value) {
                            return null;
                          },
                          style: GoogleFonts.roboto(),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: "Bairro",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: controller.cidadeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite o nome Nome da sua Cidade';
                            }
                            return null;
                          },
                          style: GoogleFonts.roboto(),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: "Cidade*",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: controller.logadouroController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu Logadouro';
                            }
                            return null;
                          },
                          style: GoogleFonts.roboto(),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: "Logadouro*",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        IntegerFieldWidget(
                          fieldName: 'Número',
                          controller: controller.numeroController,
                          validator: (value) {
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: controller.complementoController,
                          validator: (value) {
                            return null;
                          },
                          style: GoogleFonts.roboto(),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: "Complemento",
                          ),
                        ),
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
          ),
        ),
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
    return InkWell(
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
    );
  }
}
