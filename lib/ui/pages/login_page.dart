import 'package:cloud_storage/ui/components/loading_indicator.dart';
import 'package:dog/dog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/api/v1.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = TextEditingController();
    final pw = TextEditingController();
    final keepLogin = useState(false);
    final showPwd = useState(false);
    final isLoading = useState(false);

    loginEvent() => login(
          context,
          email.text.trim(),
          pw.text,
          keepLogin.value,
          isLoading,
        );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Spacer(),
                        const SizedBox(
                          height: 20,
                          child: Text('logo'),
                        ),
                        const Spacer(),
                        TextField(
                          controller: email,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: pw,
                          textInputAction: TextInputAction.go,
                          onSubmitted: (v) => loginEvent(),
                          obscureText: !showPwd.value,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(showPwd.value ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  showPwd.value = !showPwd.value;
                                },
                              ),
                              hintText: 'Password',
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              )),
                        ),
                        const SizedBox(height: 16),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: loginEvent,
                            child: isLoading.value
                                ? const LoadingIndicator()
                                : const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text('LOGIN'),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }

  void login(
    BuildContext context,
    String email,
    String pw,
    bool keepLogin,
    ValueNotifier<bool> isLoading,
  ) async {
    if (isLoading.value) {
      return;
    }
    APIV1.baseUrl = 'http://localhost:8080';
    isLoading.value = true;
    // final res = await APIV1.login(email, pw, keepLogin);
    // if (res.isError) {
    //   dog.e(res.body);
    //   isLoading.value = false;
    //   showDialog(context: context, builder: (_) => const AlertDialog(title: Text('Login failed')));
    //   return;
    // }
    context.go('/test-root');
    isLoading.value = false;
  }
}
