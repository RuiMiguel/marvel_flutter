import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:marvel/core/controllers/login_controller.dart';
import 'package:marvel/styles/colors.dart';
import 'package:marvel/ui/commons/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = "login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;
  late TextEditingController privateKeyEditingController;
  late TextEditingController publicKeyEditingController;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    controller = context.read<LoginController>();

    privateKeyEditingController = TextEditingController(
      text: controller.getPrivateKey(),
    );
    publicKeyEditingController = TextEditingController(
      text: controller.getPublicKey(),
    );
  }

  Widget _loginDescription() {
    if (controller.hasCredentials()) {
      return Text(
        AppLocalizations.of(context)!.your_current_credentials,
        style: Theme.of(context).textTheme.bodyText1,
      );
    } else {
      return Linkify(
        text: AppLocalizations.of(context)!
            .add_your_developer_credentials_to_login,
        style: Theme.of(context).textTheme.bodyText1,
        linkStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 24,
              color: red,
            ),
        onOpen: (link) => print("Clicked ${link.url}!"),
      );
    }
  }

  Widget _loginButtons() {
    if (controller.hasCredentials()) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style,
            onPressed: () async {
              var logged = await context.read<LoginController>().login(
                    privateKey: privateKeyEditingController.text,
                    publicKey: publicKeyEditingController.text,
                  );
              if (!logged) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.login_fail),
                  ),
                );
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              AppLocalizations.of(context)!.save,
            ),
          ),
          const SizedBox(width: 30),
          ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style,
            onPressed: () {
              context.read<LoginController>().logout();
              Navigator.of(context).pop();
            },
            child: Text(
              AppLocalizations.of(context)!.logout,
            ),
          ),
        ],
      );
    } else {
      return ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style,
        onPressed: () async {
          var logged = await context.read<LoginController>().login(
                privateKey: privateKeyEditingController.text,
                publicKey: publicKeyEditingController.text,
              );
          if (!logged) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.login_fail),
              ),
            );
          }
        },
        child: Text(
          AppLocalizations.of(context)!.login,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).shadowColor,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _loginDescription(),
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: privateKeyEditingController,
                                  autocorrect: false,
                                  cursorColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  decoration: InputDecoration(
                                    hintText: "*****",
                                    labelText: AppLocalizations.of(context)!
                                        .private_key,
                                    hintStyle:
                                        Theme.of(context).textTheme.subtitle1,
                                    labelStyle:
                                        Theme.of(context).textTheme.subtitle1,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor),
                                    ),
                                    border: UnderlineInputBorder(),
                                  ),
                                  onEditingComplete: () {},
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  controller: publicKeyEditingController,
                                  autocorrect: false,
                                  cursorColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  decoration: InputDecoration(
                                    hintText: "*****",
                                    labelText: AppLocalizations.of(context)!
                                        .public_key,
                                    hintStyle:
                                        Theme.of(context).textTheme.subtitle1,
                                    labelStyle:
                                        Theme.of(context).textTheme.subtitle1,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor),
                                    ),
                                    border: UnderlineInputBorder(),
                                  ),
                                  onEditingComplete: () {},
                                ),
                                const SizedBox(height: 80),
                                _loginButtons(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
