import "package:flutter/material.dart";

import "package:divmeds/designs/app_colors.dart";

class ComingSoonScreen extends StatelessWidget {

 final Color backGroundColor;

  const ComingSoonScreen({
    super.key,
    required this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
      backgroundColor: backGroundColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.divMedsColorBlueScaffoldAccent,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.divMedsColorBabyBlue,
                size: 48.0,
              ),
              SizedBox(height: 16.0),
              Text(
                'Feature Unavailable',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'As DivMeds is in the MVP stage, this feature is currently not available. Help us in reaching more healthcare peers to make DivMeds even better!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton.icon(
                icon: Icon(Icons.share),
                label: Text('Share'),
                onPressed: () {
                //  DivMeds share url
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
