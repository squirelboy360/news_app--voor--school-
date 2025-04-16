import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sekai_news/model/news.dart';
import 'package:sekai_news/screens/widgets/details.dart';
import 'package:sekai_news/util/color.dart';
import 'package:sekai_news/util/endpoints.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  List<NewsArticle> _news = [];
  bool _isLoading = true;
  String _errorMessage = '';

  Future<void> fetchBusinessNews() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http.get(Uri.parse(businessUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (mounted) {
          setState(() {
            _news = List<Map<String, dynamic>>.from(data['articles'])
                .map((e) => NewsArticle.fromJson(e))
                .toList();
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to load news: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    fetchBusinessNews();
    super.initState();
  }

  Future<void> _refresh() async {
    await fetchBusinessNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text('Business News',
                style: GoogleFonts.albertSans(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70)),
            expandedHeight: 210,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/2.png',
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  colorBlendMode: BlendMode.colorBurn),
            ),
            floating: true,
            pinned: true,
            elevation: 0,
          ),
        ],
        body: _isLoading
            ? const Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                ),
              )
            : _errorMessage.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(_errorMessage),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _refresh,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    color: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    onRefresh: _refresh,
                    child: ListView.builder(
                      addAutomaticKeepAlives: true,
                      itemCount: _news.length,
                      itemBuilder: (context, index) {
                        final news = _news[index];
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailedScreen(
                                  content:
                                      news.content ?? 'No content available',
                                  imageUrl: news.urlToImage ??
                                      'https://via.placeholder.com/300',
                                  title: news.title ?? 'No title',
                                  date:
                                      news.publishedAt ?? 'Unknown date',
                                  author: news.author ?? 'Unknown author',
                                ),
                              ));
                            },
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Hero(
                                      tag: news.urlToImage ?? '',
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: news.urlToImage != null
                                            ? Image.network(
                                                news.urlToImage!,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    const CupertinoActivityIndicator(),
                                              )
                                            : Image.asset(
                                                'assets/placeholder.png'),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    news.title ?? 'No title',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              subtitle:
                                  Text(news.description ?? 'No description'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
