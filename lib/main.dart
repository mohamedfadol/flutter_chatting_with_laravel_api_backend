import 'package:chat_app_with_laravel/blocs/chat/chat_bloc.dart';
import 'package:chat_app_with_laravel/blocs/user/user_bloc.dart';
import 'package:chat_app_with_laravel/repositories/auth/auth_repository.dart';
import 'package:chat_app_with_laravel/repositories/chat/chat_respository.dart';
import 'package:chat_app_with_laravel/screens/chat_list/chat_list_screen.dart';
import 'package:chat_app_with_laravel/screens/guest/guest_screen.dart';
import 'package:chat_app_with_laravel/screens/splash/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/auth/auth_bloc.dart';
import 'cubits/guest/guest_cubit.dart';
import 'repositories/chat_message/chat_message_repository.dart';
import 'repositories/user/user_repository.dart';
import 'screens/chat/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<ChatRepository>(
          create: (_) => ChatRepository(),
        ),
        RepositoryProvider<ChatMessageRepository>(
          create: (_) => ChatMessageRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc()),
          BlocProvider(
            create: (context) => GuestCubit(
              authRepository: context.read<AuthRepository>(),
              authBloc: context.read<AuthBloc>(),
            ),
          ),
          BlocProvider(
            create: (context) => ChatBloc(
              chatRepository: context.read<ChatRepository>(),
              chatMessageRepository: context.read<ChatMessageRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) =>
                UserBloc(userRepository: context.read<UserRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (_) => const SplashScreen(),
            GuestScreen.routeName: (_) => const GuestScreen(),
            ChatListScreen.routeName: (_) => const ChatListScreen(),
            ChatScreen.routeName: (_) => const ChatScreen(),
          },
        ),
      ),
    );
  }
}
