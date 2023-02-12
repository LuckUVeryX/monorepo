import 'package:auth/gen/assets.gen.dart';
import 'package:auth/src/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utils/utils.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.loginLogo.image(),
              Text(
                'Start your career with Glints',
                style: context.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: auth.maybeWhen(
                    orElse: () =>
                        ref.read(authControllerProvider.notifier).login,
                    loading: () => null,
                  ),
                  child: auth.maybeWhen(
                    orElse: () => const Text('Login'),
                    loading: CircularProgressIndicator.adaptive,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
