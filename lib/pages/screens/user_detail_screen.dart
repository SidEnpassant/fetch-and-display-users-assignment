// lib/screens/user_detail_screen.dart
import 'package:assignment/services/models/user.dart';
import 'package:assignment/widgets/global/glassmorphic_container.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1a1a1a), Color(0xFF2d3436)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // App Bar
                GlassmorphicContainer(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'User Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Profile Card
                        GlassmorphicContainer(
                          child: Column(
                            children: [
                              // Profile Avatar
                              Hero(
                                tag: 'avatar_${user.id}',
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Color(0xFF6C72CB),
                                  child: Text(
                                    user.name[0].toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 24),
                              // User Name
                              Text(
                                user.name,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.3),
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        // Contact Information Card
                        GlassmorphicContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Contact Information',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 16),
                              _buildDetailRow(
                                context,
                                Icons.email_outlined,
                                'Email',
                                user.email,
                              ),
                              SizedBox(height: 16),
                              _buildDetailRow(
                                context,
                                Icons.phone_outlined,
                                'Phone',
                                user.phone,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        // Actions Card
                        // GlassmorphicContainer(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       // _buildActionButton(
                        //       //   context,
                        //       //   Icons.message_outlined,
                        //       //   'Message',
                        //       //   () {
                        //       //     // Add message functionality
                        //       //     ScaffoldMessenger.of(context).showSnackBar(
                        //       //       SnackBar(
                        //       //         content: Text('Messaging coming soon!'),
                        //       //         behavior: SnackBarBehavior.floating,
                        //       //       ),
                        //       //     );
                        //       //   },
                        //       // ),
                        //       // _buildActionButton(
                        //       //   context,
                        //       //   Icons.phone_outlined,
                        //       //   'Call',
                        //       //   () {
                        //       //     // Add call functionality
                        //       //     ScaffoldMessenger.of(context).showSnackBar(
                        //       //       SnackBar(
                        //       //         content: Text('Calling coming soon!'),
                        //       //         behavior: SnackBarBehavior.floating,
                        //       //       ),
                        //       //     );
                        //       //   },
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
