import 'package:flutter/material.dart';
import 'package:pets_movil/providers/login_form_provider.dart';
import 'package:provider/provider.dart';

import 'package:pets_movil/ui/input_decoration.dart';
import 'package:pets_movil/widgets/widgets.dart';

import '../services/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 180,
            ),
            CardContainer(
                child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text("Login",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: const _LoginForm(),
                )
              ],
            )),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'register'),
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())),
              child: const Text('Crear una nueva cuenta',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 50)
          ],
        ),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: LoginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            initialValue: 'Fer@gmail.com',
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Jhon@correo.com',
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_rounded),
            onChanged: (value) => LoginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Ingrese un correo valido ';
            },
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            initialValue: '123',
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: '**************',
                labelText: 'Password',
                prefixIcon: Icons.lock_outline_rounded),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  LoginForm.isLoading ? 'Espere...' : 'Ingresar',
                  style: TextStyle(color: Colors.white),
                )),
            onPressed: LoginForm.isLoading
                ? null
                : () async {
                    //TODO: login form
                    FocusScope.of(context).unfocus();
                    //final authService = Provider.of<AuthService>(context, listen: false);
                    if (!LoginForm.isValidForm()) return;
                    LoginForm.isLoading = true;
                    // final String? errorMessage =  await authService.login(LoginForm.email,LoginForm.password);
                    final String? errorMessage = null;
                    if (errorMessage == null) {
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      print(errorMessage);
                      NotificationsService.showSnackbar(errorMessage);
                      await Future.delayed(Duration(seconds: 2));
                      LoginForm.isLoading = false;
                    }
                  },
          )
        ],
      ),
    );
  }
}
