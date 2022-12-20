import 'package:flutter/material.dart';
import 'package:pets_movil/providers/login_form_provider.dart';
import 'package:provider/provider.dart';

import 'package:pets_movil/ui/input_decoration.dart';
import 'package:pets_movil/widgets/widgets.dart';

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
                height: 150,
              ),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Login",style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 30),
                     ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: _LoginForm(),
                      )
                    
                  ],
                )
              ),
              const SizedBox(height: 50),
              const Text('Crear una nueva cuenta',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 50)
            ],
          ),
        )
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        //TODO: mantener el key 
        key: LoginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Jhon@correo.com',
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: (value) => LoginForm.email = value,
              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);
                return regExp.hasMatch(value ?? '') ? null : 'Ingrese un correo valido ';
              },
            ),
            SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '**************',
                labelText: 'Password',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => LoginForm.password = value,
              validator: (value) {
                if  (value!=null && value.length>=6) return null;
                return 'la contraseña debe ser mayor a 6 caracteres';
              },
            ),
            SizedBox(height: 30,),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric( horizontal: 80, vertical: 15),
                child: Text(
                  LoginForm.isLoading ? 'Espere...' : 'Ingresar',
            
                  style: TextStyle( color: Colors.white ),
                )
              ),
              onPressed: LoginForm.isLoading ? null : () async {
                //TODO: login form
                FocusScope.of(context).unfocus();
                if (!LoginForm.isValidForm())return;
                LoginForm.isLoading = true;
                //Navigator.pushReplacementNamed(context, 'home');
                await Future.delayed(Duration(seconds: 2));
                LoginForm.isLoading = false;
                Navigator.pushReplacementNamed(context, 'home');
              },
            )
          ],
        )
        ),
    );
  }
}