import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rentware/models/Product.dart';
import 'package:rentware/models/firebase_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class AddToCart extends StatelessWidget {
  AddToCart({super.key, required this.product});

  final Product product;
  final FirebaseService? _firebaseService =
      GetIt.instance.get<FirebaseService>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              color: Color(product.bgColor),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Color(product.bgColor),
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () async {
                await _firebaseService!.addFavoriteItem(product.id);
              },
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                String? phoneNumber = product.contactNumber;
                if (phoneNumber != null) {
                  _launchDialPad(phoneNumber);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Phone number not found')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                backgroundColor: Color(product.bgColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Call Now".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchDialPad(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
