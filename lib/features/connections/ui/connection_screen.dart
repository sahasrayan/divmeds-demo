import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/connections/models/connection_model.dart';
import 'package:divmeds/features/connections/repositories/connection_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/outsider_profile_section.dart';
import 'package:flutter/material.dart';

class ConnectionListScreen extends StatefulWidget {
  final String serverUrl;
  final String token;
  final String loggedInUserId;
  final String userId; // Add userId to fetch connections for a specific user

  const ConnectionListScreen({
    super.key,
    required this.serverUrl,
    required this.token,
    required this.loggedInUserId,
    required this.userId, 
  });

  @override
  ConnectionListScreenState createState() => ConnectionListScreenState();
}

class ConnectionListScreenState extends State<ConnectionListScreen> {
  late Future<List<Connection>?> futureConnections;
  late ConnectionRepository connectionRepository;
  late User lookingForSearchedUser;

  @override
  void initState() {
    super.initState();
    connectionRepository = ConnectionRepository(serverUrl: widget.serverUrl);
    futureConnections = connectionRepository.getUserConnections(widget.userId, widget.token); // Fetch connections for the specific user
  }

  void _removeConnection(String connectionId) async {
    bool success = await connectionRepository.removeConnection(connectionId, widget.token);
    if (success) {
      setState(() {
        futureConnections = connectionRepository.getUserConnections(widget.userId, widget.token); // Refresh connections
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove connection')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connections'),
        backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
      ),
      body: FutureBuilder<List<Connection>?>(
        future: futureConnections,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No connections found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final connection = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(connection.recipient), // Assuming recipient is a URL
                  ),
                  title: Text(connection.recipient), // Assuming recipient is the name
                  trailing: IconButton(
                    icon: Icon(Icons.person_remove),
                    onPressed: () => _removeConnection(connection.id),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileSectionOutsider(
                       
                          userId: connection.recipient,
                          loggedInUserId: widget.loggedInUserId,
                          token: widget.token,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

