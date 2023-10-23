import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'adaptive_login.dart';

class Playlists extends StatelessWidget {
  const Playlists({required this.playlistSelected, super.key});

  final PlaylistsListSelected playlistSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthedUserPlaylists>(  // Update this line
      builder: (context, flutterDev, child) {
        final playlists = flutterDev.playlists;
        if (playlists.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return _PlaylistsListView(
          items: playlists,
          playlistSelected: playlistSelected,
        );
      },
    );
  }
}

Widget _PlaylistsListView({required items, required PlaylistsListSelected playlistSelected})

class PlaylistsListSelected {
}