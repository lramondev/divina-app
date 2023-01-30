import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/app/app_store.dart';
import 'package:divina/modules/login/login_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  AppStore appStore = Modular.get<AppStore>();
  LoginStore loginStore = Modular.get<LoginStore>();

  final formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  void dispose() {
    mailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void load() async {
    mailController.text = loginStore.email;
    passController.text = loginStore.password;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Platform.isIOS
          ? exit(0)
          : SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return true;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark
        ),
        child: Observer(
          builder: (BuildContext context) {  
            return Scaffold(
              body: Stack(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            
                            const Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: Image(image: AssetImage('assets/img/divina-128.png'), height: 128, width: 128),
                            ),
          
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: mailController,
                                onChanged: loginStore.setEmail,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value!) ? 'email inválido' : null,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                                decoration: const InputDecoration(
                                  errorStyle: TextStyle(
                                    fontSize: 18
                                  ),
                                  contentPadding: EdgeInsets.all(16),
                                  icon: Icon(Icons.mail),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(fontSize: 22)
                                ),
                              ),
                            ),
                                
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: passController,
                                onChanged: loginStore.setPassword,
                                obscureText: !loginStore.showPassword,
                                validator: (value) => value!.length < 6 ? 'senha inválida' : null,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(
                                    fontSize: 18
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                  icon: const Icon(Icons.vpn_key),
                                  labelText: 'Senha',
                                  labelStyle: const TextStyle(fontSize: 22),
                                  suffixIcon: IconButton(
                                    onPressed: loginStore.toggleShowPassword,
                                    icon: Icon(loginStore.showPassword ? Icons.visibility : Icons.visibility_off, size: 24.0),
                                  ),
                                ),
                              ),
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
                              child: CheckboxListTile(
                                value: loginStore.isRememberMe,
                                onChanged: (bool? value) => loginStore.toggleRememberMe(),
                                title: const Text("Lembrar-me")
                              ),
                            ),
                                
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                    )
                                  )
                                ),
                                onPressed: () async {
                                  if(!loginStore.isLoading) {
                                    final form = formKey.currentState!;
                                    if(form.validate()) {
                                      await loginStore.login().then((value) {
                                        if(loginStore.appStore.user.id > 0) {
                                          Modular.to.popAndPushNamed('/home/').then((value) => loginStore.isLoading = false);   
                                        }
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(value[0].message, style: const TextStyle(fontSize: 18), textAlign: TextAlign.center)
                                          )
                                        );
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16)
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16), 
                                      child: loginStore.isLoading ? const SizedBox(
                                        height: 28,
                                        width: 28,
                                        child:  CircularProgressIndicator(),
                                      ) : const Text('Entrar', textAlign: TextAlign.center, style: TextStyle(fontSize: 24))
                                    ),
                                  ),
                                ),
                              ),
                            ),
                                
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
                              child: SizedBox(
                                height: 48,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  child: const Text('Esqueceu a senha?', style: TextStyle(fontSize: 18)),
                                  onPressed: () => {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Não disponível', style: TextStyle(fontSize: 18), textAlign: TextAlign.center)
                                      )
                                    )
                                    //Modular.to.pushNamed('/login/reset')
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  )
                ],
              )
            );
          },
        ),
      )
    );
  }
}