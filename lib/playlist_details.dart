import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PlaylistDetails extends StatelessWidget {
  const PlaylistDetails(
      {required this.playlistId, required this.playlistName, super.key});
  final String playlistId;
  final String playlistName;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthedUserPlaylists>(  // Update this line
      builder: (context, flutterDev, _) {
        final playlistItems = flutterDev?.playlistItems(playlistId: playlistId);
        if (playlistItems.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return _PlaylistDetailsListView(playlistItems: playlistItems);
      },
    );
  }

  Widget _PlaylistDetailsListView({required playlistItems}) {}
}