// lib/screens/add_user_screen.dart
import 'package:assignment/services/models/user.dart';
import 'package:assignment/services/providers/user_provider.dart';
import 'package:assignment/widgets/global/glassmorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _animationController.dispose();
    super.dispose();
  }

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
                        'Add New User',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Form Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Avatar Preview
                            GlassmorphicContainer(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Color(0xFF6C72CB),
                                    child: Icon(
                                      Icons.person_add,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'New User Profile',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24),
                            // Form Fields
                            GlassmorphicContainer(
                              child: Column(
                                children: [
                                  _buildTextField(
                                    controller: _nameController,
                                    label: 'Full Name',
                                    icon: Icons.person_outline,
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return 'Please enter a name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _emailController,
                                    label: 'Email Address',
                                    icon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return 'Please enter an email';
                                      }
                                      if (!RegExp(
                                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                          .hasMatch(value!)) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _phoneController,
                                    label: 'Phone Number',
                                    icon: Icons.phone_outlined,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return 'Please enter a phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24),
                            // Submit Button
                            GlassmorphicContainer(
                              padding: EdgeInsets.zero,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: _submitForm,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.save_outlined,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Save User',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white70),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          errorStyle: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final newUser = User(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: GlassmorphicContainer(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Saving user...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Simulate network delay
      await Future.delayed(Duration(seconds: 1));

      // Add user and pop loading dialog
      Provider.of<UserProvider>(context, listen: false).addUser(newUser);
      Navigator.pop(context); // Pop loading dialog

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User added successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Navigate back
      Navigator.pop(context);
    }
  }
}
