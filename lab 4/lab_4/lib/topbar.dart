import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/controllers/recipe_controller.dart';
import 'utils/image_helper.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RecipeController controller = Get.find<RecipeController>();
    
    return Obx(() {
      final user = controller.user;
      
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user != null ? 'Hello ${user.name}' : 'Hello',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                user?.greeting ?? 'What are you cooking today?',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFE4B5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: user?.profileImage != null
                  ? ImageHelper.loadImage(
                      user!.profileImage,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/icons/avatar.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ],
      );
    });
  }
}