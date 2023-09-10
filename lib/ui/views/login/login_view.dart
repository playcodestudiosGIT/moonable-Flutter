import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moonable/providers/forms/login_form_provider.dart';
import 'package:moonable/router/router.dart';
import 'package:moonable/services/navigator_service.dart';
import 'package:moonable/settings/constants.dart';
import 'package:provider/provider.dart';

import '../../styles/form_input_decoration.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> keyLoginForm = GlobalKey<FormState>(debugLabel: 'login');
  // @override
  // void dispose() {
  //   // print('dispose');
  //   // keyLoginForm.currentState!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(maxWidth: 400, maxHeight: hSize(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text('Ingresar', style: text32Headline(context)),
            const SizedBox(height: 30),
            Form(
              key: keyLoginForm,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                constraints: const BoxConstraints(maxWidth: 400),
                width: double.infinity,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => (EmailValidator.validate(value.toString())) ? null : 'Introduzca un correo valido',
                      onChanged: (value) => loginFormProvider.setEmail(value),
                      decoration: FormDecor.formFieldInputDecoration(context: context, label: 'Correo Electrónico', icon: Icons.email),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) return 'Clave no puede estar vacia';
                        if (value.length < 6) return 'Clave debe ser mayor a 6 caracteres';
                        return null;
                      },
                      onChanged: (value) => loginFormProvider.setPassword(value),
                      decoration: FormDecor.formFieldInputDecoration(context: context, label: 'Clave secreta', icon: Icons.password),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  final bool isValid = keyLoginForm.currentState!.validate();
                  await loginFormProvider.validateForm(context: context, isValid: isValid);
                },
                child: Text(
                  'Ingresar',
                  style: text14BodyM(context),
                )),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(children: [
                TextSpan(text: 'No tienes cuenta?  ', style: text14BodyM(context)),
                TextSpan(
                    text: 'Registrate aqui',
                    style: text14BodyM(context).copyWith(color: primary(context)),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        NavigatorService.replaceTo(Flurorouter.register);
                      })
              ]),
            ),
            const SizedBox(height: 30),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                  onTap: () => NavigatorService.replaceTo(Flurorouter.login),
                  child: Text('Olvide mi contraseña', style: text14BodyM(context).copyWith(color: primary(context), fontSize: 10))),
            ),
            const SizedBox(height: 100),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
