import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/explore/ui/articles/articles_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:share_plus/share_plus.dart';

class ArticleListScreen extends StatelessWidget {
  final List<Map<String, String>> articles;

  const ArticleListScreen({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles',
         style: TextStyle(color: Colors.black)),
        backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                          colors: [Colors.blue[50]!, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        title: Text(
                          article['title']!,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            article['content']!,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[800],
                              height: 1.5,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: AppColors.divMedsColorBlue1),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleDetailScreen(article: article),
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: _ArticleActions(
                        onLikeToggle: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Like action will be implemented!')),
                          );
                        },
                        onShare: () {
                          final articleUrl = 'https://example.com/articles/${article['title']}';
                          Share.share('Check out this article: $articleUrl');
                        },
                      ),
                    ),
                   
                    _ArticleLikes(likes: 10), // Assume 10 likes for demo purposes
                    const SizedBox(height: 1),
                    _ArticleComments(comments: 5), // Assume 5 comments for demo purposes
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ArticleActions extends StatelessWidget {
  final VoidCallback onLikeToggle;
  final VoidCallback onShare;

  const _ArticleActions({
    required this.onLikeToggle,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.thumb_up_alt_outlined),
          color: Colors.grey,
          onPressed: onLikeToggle,
        ),
        IconButton(
          icon: const Icon(Icons.comment_outlined),
          color: Colors.grey,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Comment action will be implemented!')),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.share),
          color: Colors.grey,
          onPressed: onShare,
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.bookmark_border),
          color: Colors.grey,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bookmark action will be implemented!')),
            );
          },
        ),
      ],
    );
  }
}

class _ArticleLikes extends StatelessWidget {
  final int likes;

  const _ArticleLikes({required this.likes});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$likes ${likes == 1 ? 'like' : 'likes'}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      ),
    );
  }
}

class _ArticleComments extends StatelessWidget {
  final int comments;

  const _ArticleComments({required this.comments});

  @override
  Widget build(BuildContext context) {
    return Text(
      'View all $comments comments',
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }
}

