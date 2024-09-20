import 'package:flutter/material.dart';
import 'package:divmeds/designs/app_colors.dart';



class ArticleDetailScreen extends StatelessWidget {
  final Map<String, String> article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title']!, 
        style: TextStyle(color: Colors.black)),
        backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article['title']!,
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10.0),
            Divider(
              thickness: 2.0,
              color: AppColors.divMedsColorBabyBlue,
            ),
            const SizedBox(height: 10.0),
            Text(
              article['content']!,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
                height: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
