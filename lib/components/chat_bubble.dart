import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String? timestamp; // Optional timestamp

  ChatBubble({
    required this.message,
    required this.isCurrentUser,
    this.timestamp,
  });
@override
  Widget build(BuildContext context) {
    // Get theme colors
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: ChatBubbleClipper(isCurrentUser),
              child: Container(
                padding: EdgeInsets.all(12),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                decoration: BoxDecoration(
                  color: isCurrentUser
                      ? colorScheme.primary // Current user color
                      : colorScheme.secondary, // Other user color
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                        isCurrentUser ? Radius.circular(12) : Radius.zero,
                    bottomRight:
                        isCurrentUser ? Radius.zero : Radius.circular(12),
                  ),
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    color: colorScheme.onPrimary, // Ensures contrast
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ),
            if (timestamp != null) // Show timestamp if available
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  timestamp!,
                  style: TextStyle(fontSize: 12, color: colorScheme.onSurface),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Custom ClipPath for Chat Bubble Tail
class ChatBubbleClipper extends CustomClipper<Path> {
  final bool isCurrentUser;

  ChatBubbleClipper(this.isCurrentUser);

  @override
  Path getClip(Size size) {
    Path path = Path();
    double tailSize = 6;

    if (isCurrentUser) {
      path.moveTo(0, 0);
      path.lineTo(size.width - tailSize, 0);
      path.lineTo(size.width, tailSize);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
    } else {
      path.moveTo(tailSize, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, tailSize);
      path.close();
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
