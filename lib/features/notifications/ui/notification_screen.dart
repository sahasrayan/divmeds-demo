import 'package:divmeds/features/auth/models/dummy_user.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/comment_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/post_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/single_post_viewer.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/outsider_profile_section.dart';
import 'package:divmeds/features/notifications/models/notification_model.dart';
import 'package:divmeds/features/notifications/repositories/notification_repo.dart';

class NotificationScreen extends StatefulWidget {
  final String token;
  final String serverUrl;
  final User user;

  const NotificationScreen({super.key, required this.token, required this.serverUrl, required this.user});

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  late NotificationRepository _repository;
  late PostRepository _postRepository;
  late CommentRepository _commentRepository;
  List<NotificationModel>? _notifications;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _repository = NotificationRepository(serverUrl: widget.serverUrl);
    _postRepository = PostRepository(serverUrl: widget.serverUrl);
    _commentRepository = CommentRepository(serverUrl: widget.serverUrl);
    _fetchNotifications();
  }

  void _fetchNotifications() async {
    // Simulating fetching notifications with dummy data
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    setState(() {
      _notifications = [
        NotificationModel(
          id: '1',
          sender: User(
            id: '2',
            firstName: 'Alice',
            lastName: 'Smith',
            userId: 'alice_smith',
            email: 'alice.smith@example.com',
            password: 'password123',
            phone: '+1234567890',
            dob: '1985-01-01',
            gender: 'Female',
            profilePicture: 'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg',
            location: 'New York, USA',
            isHealthcare: true,
            isNonHealthcare: false,
            isVerified: true,
            verificationDocuments: [],
            education: [],
            professionalDetails: [],
            connections: [],
            follow: [],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            role: 'user',
            tagline: 'Healthcare professional',
            aboutSection: 'Dr. Alice Smith, a healthcare professional.',
            links: [],
            userTags: ['doctor', 'healthcare'],
          ),
          message: 'Alice Smith sent you a connection request',
          read: false,
          type: 'connection_request',
          postId: null,
        ),
        NotificationModel(
          id: '2',
          sender: User(
            id: '3',
            firstName: 'Bob',
            lastName: 'Johnson',
            userId: 'bob_johnson',
            email: 'bob.johnson@example.com',
            password: 'password123',
            phone: '+1234567890',
            dob: '1990-02-02',
            gender: 'Male',
            profilePicture: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ55xNIciu8yA_9IqA9TB3oPwEheZmo_gKWsg&s',
            location: 'Los Angeles, USA',
            isHealthcare: true,
            isNonHealthcare: false,
            isVerified: true,
            verificationDocuments: [],
            education: [],
            professionalDetails: [],
            connections: [],
            follow: [],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            role: 'user',
            tagline: 'Healthcare professional',
            aboutSection: 'Dr. Bob Johnson, a healthcare professional.',
            links: [],
            userTags: ['doctor', 'healthcare'],
          ),
          message: 'Bob Johnson liked your post',
          read: false,
          type: 'like',
          postId: '1',
        ),
      ];
      _loading = false;
    });
  }

  void _markAsRead(String notificationId) async {
    setState(() {
      _notifications = _notifications!.map((notification) {
        if (notification.id == notificationId) {
          notification.read = true;
        }
        return notification;
      }).toList();
    });
  }

  void _handleNotificationTap(NotificationModel notification) async {
    _markAsRead(notification.id);

    switch (notification.type) {
      case 'comment':
      case 'like':
        // Fetch the post details
        final post = await _postRepository.getPostById(notification.postId!, widget.token);
        if (post != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SinglePostViewer(
                post: post,
                user: user,
              ),
            ),
          );
        }
        break;

      case 'connection_request':
      case 'connection_accept':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileSectionOutsider(
              userId: notification.sender.userId,
              loggedInUserId: widget.user.userId,
              token: widget.token,
            ),
          ),
        );
        break;

      case 'verification':
      case 'admin_message':
      default:
        // Display the message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Notification'),
            content: Text(notification.message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _notifications == null || _notifications!.isEmpty
              ? Center(child: Text('No notifications'))
              : ListView.builder(
                  itemCount: _notifications!.length,
                  itemBuilder: (context, index) {
                    final notification = _notifications![index];
                    return Card(
                      color: notification.read ? Colors.white : Colors.grey[200],
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(notification.sender.profilePicture),
                        ),
                        title: Text('${notification.sender.firstName} ${notification.sender.lastName}'),
                        subtitle: Text(notification.message),
                        trailing: notification.read
                            ? null
                            : IconButton(
                                icon: Icon(Icons.mark_email_read),
                                onPressed: () => _markAsRead(notification.id),
                              ),
                        onTap: () => _handleNotificationTap(notification),
                      ),
                    );
                  },
                ),
    );
  }
}

class NotificationModel {
  final String id;
  final User sender;
  final String message;
  bool read;
  final String type;
  final String? postId;

  NotificationModel({
    required this.id,
    required this.sender,
    required this.message,
    required this.read,
    required this.type,
    this.postId,
  });
}

