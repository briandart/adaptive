import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:provider/provider.dart';

import 'package:adaptive_app/adaptive_login.dart' as auth;
import 'adaptive_playlists.dart';
import 'package:adaptive_app/app_state.dart';
import 'playlist_details.dart';



// Define the access scopes for the YouTube API.
final scopes = [
  'https://www.googleapis.com/auth/youtube.readonly',
];

// TODO: Replace with your Client ID and Client Secret for Desktop configuration.
final clientId = ClientId(
  'TODO-Client-ID.apps.googleusercontent.com',
  'TODO-Client-secret',
);

final _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const AdaptivePlaylists();
      },
      redirect: (context, state) {
        // Redirect to the login page if the user is not logged in.
        if (!context.read<AuthedUserPlaylists>().isLoggedIn) {
          return '/login';
        } else {
          return null;
        }
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (context, state) {
            return auth.AdaptiveLogin(
              clientId: clientId,
              scopes: scopes,
              loginButtonChild: const Text('Login to YouTube'),
            );
          },
        ),
        GoRoute(
          path: 'playlist/:id',
          builder: (context, state) {
            final title = state.uri.queryParameters['title']!;
            final id = state.pathParameters['id']!;
            return Scaffold(
              appBar: AppBar(title: Text(title)),
              body: PlaylistDetails(
                playlistId: id,
                playlistName: title,
              ),
            );
          },
        ),
      ],
    ),
  ],
);

void main() {
  runApp(
    ChangeNotifierProvider<AuthedUserPlaylists>(
      create: (context) => AuthedUserPlaylists(),
      child: const PlaylistsApp(),
    ),
  );
}

class PlaylistsApp extends StatelessWidget {
  const PlaylistsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Your Playlists',
      theme: FlexColorScheme.light(
        scheme: FlexScheme.red,
        useMaterial3: true,
      ).toTheme,
      darkTheme: FlexColorScheme.dark(
        scheme: FlexScheme.red,
        useMaterial3: true,
      ).toTheme,
      themeMode: ThemeMode.dark, // Or ThemeMode.System if you prefer
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
