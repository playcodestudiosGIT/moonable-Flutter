import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moonable/providers/forms/register_form_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigator_service.dart';
import '../../../settings/constants.dart';
import '../../styles/form_input_decoration.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> registerKey = GlobalKey<FormState>(debugLabel: 'register');

  // @override
  // void dispose() {
  //   // registerKey.currentState!.dispose();
  //   // super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final registerFormProvider = Provider.of<RegisterFormProvider>(context);
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        constraints: BoxConstraints(maxWidth: 400, maxHeight: hSize(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text('Registro', style: text32Headline(context)),
            const SizedBox(height: 30),
            Form(
              key: registerKey,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                width: double.infinity,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => (EmailValidator.validate(value.toString())) ? null : 'Correo invalido',
                      onChanged: (value) => registerFormProvider.setEmail(value),
                      decoration: FormDecor.formFieldInputDecoration(context: context, label: 'Correo Electrónico', icon: Icons.email),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => (value!.isNotEmpty) ? null : 'No puede estar vacio',
                      onChanged: (value) => registerFormProvider.setNombre(value),
                      decoration: FormDecor.formFieldInputDecoration(context: context, label: 'Nombre', icon: Icons.person),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => (value!.isNotEmpty) ? null : 'No puede estar vacio',
                      onChanged: (value) => registerFormProvider.setApellido(value),
                      decoration: FormDecor.formFieldInputDecoration(context: context, label: 'Apellido', icon: Icons.group),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) return 'No puede estar vacio';
                        if (value.length < 6) return 'No puede ser menor a 6 caracteres';
                        if (value != registerFormProvider.password2) return 'Las claves no coinciden';
                        return null;
                      },
                      onChanged: (value) => registerFormProvider.setPassword1(value),
                      decoration: FormDecor.formFieldInputDecoration(context: context, label: 'Clave', icon: Icons.password),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) return 'No puede estar vacio';
                        if (value.length < 6) return 'No puede ser menor a 6 caracteres';
                        if (value != registerFormProvider.password1) return 'Las claves no coinciden';
                        return null;
                      },
                      onChanged: (value) => registerFormProvider.setPassword2(value),
                      decoration: FormDecor.formFieldInputDecoration(context: context, label: 'Repita la clave', icon: Icons.password),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  final authProvider = Provider.of<AuthProvider>(context, listen: false);
                  final isValid = registerKey.currentState!.validate();

                  if (!isValid) return;
                  authProvider.register(
                    nombre: registerFormProvider.nombre,
                    apellido: registerFormProvider.apellido,
                    correo: registerFormProvider.email,
                    password: registerFormProvider.password1,
                  );
                },
                child: Text(
                  'Registrar',
                  style: text14BodyM(context),
                )),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(children: [
                TextSpan(text: 'Ya tienes cuenta?  ', style: text14BodyM(context)),
                TextSpan(
                    text: 'Ingresa aqui',
                    style: text14BodyM(context).copyWith(color: primary(context)),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        NavigatorService.replaceTo(Flurorouter.login);
                      })
              ]),
            ),
            const SizedBox(height: 100),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
