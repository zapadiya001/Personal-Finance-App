import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onSearchPressed;

  const CustomAppBar({
    Key? key,
    this.title = 'MyMoney',
    this.showBackButton = false,
    this.actions,
    this.onMenuPressed,
    this.onSearchPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFF9F9F9), // Almost White Background
      elevation: 0,
      leading: showBackButton
          ? IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Color(0xFF4CAF50), // Primary Green
          size: 28,
        ),
        onPressed: () => Navigator.pop(context),
      )
          : IconButton(
        icon: Icon(
          Icons.menu,
          color: Color(0xFF4CAF50), // Primary Green
          size: 28,
        ),
        onPressed: onMenuPressed ?? () {
          // Default menu action - you can implement drawer or side menu
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFF4CAF50), // Primary Green
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      centerTitle: false,
      actions: actions ?? [
        IconButton(
          icon: Icon(
            Icons.search,
            color: Color(0xFF4CAF50), // Primary Green
            size: 28,
          ),
          onPressed: onSearchPressed ?? () {
            // Default search action
            _showSearchDialog(context);
          },
        ),
      ],
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Search',
            style: TextStyle(color: Color(0xFF212121)),
          ),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Search transactions...',
              hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFF9E9E9E)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFF4CAF50)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF9E9E9E)),
              ),
            ),
            TextButton(
              onPressed: () {
                // Implement search functionality
                Navigator.pop(context);
              },
              child: Text(
                'Search',
                style: TextStyle(color: Color(0xFF4CAF50)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// Usage Examples:

/*
// Basic usage with default MyMoney title
AppBar: CustomAppBar(),

// Custom title
AppBar: CustomAppBar(title: 'Expenses'),

// With back button (for detail screens)
AppBar: CustomAppBar(
  title: 'Add Transaction',
  showBackButton: true,
),

// Custom actions
AppBar: CustomAppBar(
  title: 'Reports',
  actions: [
    IconButton(
      icon: Icon(Icons.filter_list, color: Color(0xFF4CAF50)),
      onPressed: () {
        // Show filter options
      },
    ),
    IconButton(
      icon: Icon(Icons.more_vert, color: Color(0xFF4CAF50)),
      onPressed: () {
        // Show more options
      },
    ),
  ],
),

// Custom menu and search callbacks
AppBar: CustomAppBar(
  onMenuPressed: () {
    // Custom menu action
    print('Menu pressed');
  },
  onSearchPressed: () {
    // Custom search action
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchScreen()),
    );
  },
),
*/