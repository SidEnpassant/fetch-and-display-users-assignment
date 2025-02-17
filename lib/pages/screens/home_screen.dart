import 'package:assignment/pages/screens/add_user_screen.dart';
import 'package:assignment/pages/screens/user_detail_screen.dart';
import 'package:assignment/services/models/user.dart';
import 'package:assignment/services/providers/user_provider.dart';
import 'package:assignment/theme/app_theme.dart';
import 'package:assignment/widgets/global/glassmorphic_container.dart';
import 'package:assignment/widgets/global/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _backgroundController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    )..repeat();
    Future.microtask(
        () => Provider.of<UserProvider>(context, listen: false).fetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1a1a1a),
                      Color(0xFF2d3436),
                    ],
                    begin: Alignment(_backgroundController.value, 0),
                    end: Alignment(-1 + _backgroundController.value, 1),
                  ),
                ),
              );
            },
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                _buildSearchBar(),
                Expanded(
                  child: _buildUsersList(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: GlassmorphicContainer(
        borderRadius: 30,
        padding: EdgeInsets.zero,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AddUserScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
              ),
            );
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return GlassmorphicContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tech Directory',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              // background: Paint()
              //   ..shader = AppTheme.primaryGradient.createShader(
              //     Rect.fromLTWH(0, 0, 200, 70),
              //   ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.dark_mode),
            onPressed: () {
              // Theme toggle functionality could be added here
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: GlassmorphicContainer(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search users...',
            hintStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.search, color: Colors.white70),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            Provider.of<UserProvider>(context, listen: false)
                .setSearchQuery(value);
          },
        ),
      ),
    );
  }

  Widget _buildUsersList() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (userProvider.isLoading) {
          return Center(
            child: LoadingAnimation(),
          );
        }

        if (userProvider.error.isNotEmpty) {
          return Center(
            child: GlassmorphicContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    userProvider.error,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => userProvider.fetchUsers(),
                    child: Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            return constraints.maxWidth > 600
                ? _buildUserGrid(userProvider)
                : _buildUserList(userProvider);
          },
        );
      },
    );
  }

  Widget _buildUserGrid(UserProvider userProvider) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: userProvider.users.length,
      itemBuilder: (context, index) {
        final user = userProvider.users[index];
        return GlassmorphicContainer(
          child: InkWell(
            onTap: () => _navigateToDetail(user),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFF6C72CB),
                      child: Text(
                        user.name[0],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            user.email,
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserList(UserProvider userProvider) {
    return ListView.builder(
      itemCount: userProvider.users.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final user = userProvider.users[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: GlassmorphicContainer(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFF6C72CB),
                child: Text(
                  user.name[0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                user.name,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                user.email,
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () => _navigateToDetail(user),
            ),
          ),
        );
      },
    );
  }

  void _navigateToDetail(User user) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            UserDetailScreen(user: user),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }
}
