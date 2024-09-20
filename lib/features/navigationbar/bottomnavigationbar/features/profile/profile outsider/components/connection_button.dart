import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/connections/repositories/connection_repo.dart';
import 'package:flutter/material.dart';

class ConnectionButton extends StatefulWidget {
  final String userId;
  final String loggedInUserId;
  final String token;
  final String initialStatus;

  const ConnectionButton({
    super.key,
    required this.userId,
    required this.loggedInUserId,
    required this.token,
    required this.initialStatus,
  });

  @override
  ConnectionButtonState createState() => ConnectionButtonState();
}

class ConnectionButtonState extends State<ConnectionButton> {
  late String _connectionStatus;
  late ConnectionRepository _connectionRepository;

  @override
  void initState() {
    super.initState();
    _connectionStatus = widget.initialStatus;
    _connectionRepository = ConnectionRepository(serverUrl: Config.serverUrl);
  }

  Future<void> _sendConnectionRequest() async {
    final success = await _connectionRepository.sendConnectionRequest(widget.userId, widget.token);
    if (success) {
      setState(() {
        _connectionStatus = 'request_sent';
      });
    } else {
      // Handle error
    }
  }

  Future<void> _cancelConnectionRequest() async {
    // Assuming you have a way to get the connectionId
    final success = await _connectionRepository.cancelConnectionRequest('connectionId', widget.token);
    if (success) {
      setState(() {
        _connectionStatus = 'none';
      });
    } else {
      // Handle error
    }
  }

  Future<void> _acceptConnectionRequest() async {
    // Assuming you have a way to get the connectionId
    final success = await _connectionRepository.acceptConnectionRequest('connectionId', widget.token);
    if (success) {
      setState(() {
        _connectionStatus = 'connected';
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    String buttonText;
    VoidCallback? onPressed;

    switch (_connectionStatus) {
      case 'connected':
        buttonText = 'Connected';
        // open a pop up window saying: 'Do you want to remove your connection?"
        onPressed = null;
        break;
      case 'request_sent':
        buttonText = 'Cancel Request';
        onPressed = _cancelConnectionRequest;
        break;
      case 'awaiting_acceptance':
        buttonText = 'Accept Request';
        onPressed = _acceptConnectionRequest;
        break;
      default:
        buttonText = 'Connection Request Sent';
        onPressed = _sendConnectionRequest;
        break;
    }

    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
      
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.divMedsColorBlueScaffoldBackground,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.divMedsColorBlueScaffoldAccent,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
