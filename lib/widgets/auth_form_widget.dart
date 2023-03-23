import 'package:flutter/material.dart';

import '../Utils/utils_functions.dart';

class AuthFormWidget extends StatefulWidget {

  final void Function(String email, String password, String nickName, bool isLogin, BuildContext ctx) submitFn;
  final bool isLoading;

  const AuthFormWidget({super.key, required this.submitFn, required this.isLoading});

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  bool createMode = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Image(
                width: 300,
                height: 300,
                fit: BoxFit.fill,
                image: AssetImage('images/logo_transparent.png'),
              ),
              addVerticalSpace(10),
              TextFormField(
                key: const ValueKey('authForm-email'),
                onFieldSubmitted: (value) {},
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: 'Email'),
                validator: (value) {
                  RegExp regExp = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
                    return "Adresse email invalide.";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {},
              ),
              addVerticalSpace(10),
              TextFormField(
                key: const ValueKey('authForm-password'),
                onFieldSubmitted: (value) {},
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: 'Mot de passe'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 7) {
                    return "Format du mot de passe invalide.";
                  } else {
                    return null;
                  }
                },
              ),
              addVerticalSpace(10),
              if(createMode)
              TextFormField(
                key: const ValueKey('authForm-nickname'),
                onFieldSubmitted: (value) {},
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: 'Surnom'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 4) {
                    return "Le surnom doit faire au moins 4 caractères.";
                  } else {
                    return null;
                  }
                },
              ),
              addVerticalSpace(10),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(createMode ? 'S\'enregistrer' : 'Se connecter')
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      createMode = !createMode;
                    });
                  },
                  child: Text(
                    createMode ? 'J\'ai déjà un compte' : 'Créer un compte',
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  )),
            ],
          ),
        ),
    );
  }
}
