import 'package:flutter/material.dart';
import 'utils/image_helper.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key, required this.name, required this.address, this.profileImage});
  final String name;
  final String address;
  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserDescription(name: name, address: address, profileImage: profileImage),
        const Spacer(),
        InkWell(
          onTap: () => {},
          child: Container(
            width: 85, // square size
            height: 37,
            decoration: BoxDecoration(
              color: Color(0xFF129575), // background color
              borderRadius: BorderRadius.circular(12), // rounded corners
              boxShadow: [], // no shadow
            ),
            child: Center(
              child: Text(
                'Follow',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class UserDescription extends StatelessWidget {
  const UserDescription({
    super.key,
    required this.name,
    required this.address,
    this.profileImage,
  });

  final String name;
  final String address;
  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: profileImage != null
              ? ImageHelper.getImageProvider(profileImage!)
              : const AssetImage('assets/images/laura.png'),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.location_on, color: Color(0xFF129575), size: 14),
                const SizedBox(width: 2),
                Text(
                  address,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    color: Color(0xFFA9A9A9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

