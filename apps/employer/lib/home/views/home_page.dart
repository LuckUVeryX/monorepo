import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final auth = ref.watch(authControllerProvider);
              return IconButton(
                onPressed: auth.maybeWhen(
                  orElse: () =>
                      ref.read(authControllerProvider.notifier).logout,
                  loading: () => null,
                ),
                icon: const Icon(Icons.logout),
              );
            },
          ),
        ],
      ),
      body: const SafeArea(child: _HomePage()),
    );
  }
}

class _HomePage extends ConsumerWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    return auth.buildWhen(
      data: (user) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            Text(
              'Welcome Employer ${user?.displayName}!',
              style: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            )
          ],
        );
      },
    );
  }
}
