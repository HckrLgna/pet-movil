import 'package:flutter/material.dart';
import 'package:pets_movil/providers/login_form_provider.dart';
import 'package:pets_movil/services/services.dart';
import 'package:provider/provider.dart';

import 'package:pets_movil/ui/input_decoration.dart';
import 'package:pets_movil/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  
  const RegisterScreen({Key? key}) : super(key: key);
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
                    Text("Crear cuenta",style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: const _LoginForm(),
                      )
                    
                  ],
                )
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'), 
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())
                ),
                child: const Text('Ya tienes una cuenta',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
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
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(            
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,      
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Jhon Doe',
              labelText: 'Nombre de usuario',
              prefixIcon: Icons.person_add
            ),
            onChanged: (value) => loginForm.name = value,
            validator: (value) {                
              if (value == null || value.isEmpty) {
              return 'Campo necesario';
              }
              if (value.length < 4) {
                return 'Muy corto';
              }
                return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Jhon@correo.com',
              labelText: 'Correo electronico',
              prefixIcon: Icons.alternate_email_rounded
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);
              return regExp.hasMatch(value ?? '') ? null : 'Ingrese un correo valido ';
            },
          ),
          const SizedBox(height: 30,),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
              hintText: '**************',
              labelText: 'Contraseña',
              prefixIcon: Icons.password
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              if  (value!=null && value.length>=2) return null;
              return 'La contraseña debe ser mayor a 2 caracteres';
            },
          ),
          const SizedBox(height: 30,),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
              hintText: '**************',
              labelText: 'Confirmar contraseña',
              prefixIcon: Icons.password
            ),
            onChanged: (value) => loginForm.passwordConfirmation = value,
            validator: (value) {
              if  (value!=null && value.length>=2) return null;
              return 'El campo debe ser mayor a 2 caracteres';
            },
          ),
          const SizedBox(height: 30,),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,              
            onPressed: loginForm.isLoading ? null : () async {
              final navigator = Navigator.of(context);
              FocusScope.of(context).unfocus();
              final authService = Provider.of<AuthService2>(context, listen: false);
              if ( !loginForm.isValidForm() )return;
              loginForm.isLoading = true;
              final String? errorMessage =  await authService.createUser( loginForm.name, loginForm.email, loginForm.password, loginForm.passwordConfirmation);
              if( errorMessage== null ){
                navigator.pushReplacementNamed( 'home' );
              }else{ 
                if ( errorMessage == 'Las contraseñas no coinciden' ){
                  NotificationsService.showSnackbar( 'Las contraseñas no coinciden' );
                }                 
                if ( errorMessage == 'El correo ya esta registrado' ){
                  NotificationsService.showSnackbar( 'El correo ya esta registrado' );
                }                 
                await Future.delayed( const Duration(seconds: 2) );
                loginForm.isLoading = false;  
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric( horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading ? 'Espere...' : 'Registrar',
          
                style: const TextStyle( color: Colors.white ),
              )
            ),
          )
        ],
      )
      );
  }
}