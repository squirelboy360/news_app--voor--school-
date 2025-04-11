import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sekai_news/model/news.dart';

import 'package:sekai_news/screens/main_screens/detailed_screens/tech/tech_detailed_screen.dart';

import 'package:http/http.dart' as http;
import 'package:sekai_news/util/color.dart';
import 'package:sekai_news/util/endpoints.dart';

class TechScreen extends StatefulWidget {
  const TechScreen({Key? key}) : super(key: key);

  @override
  State<TechScreen> createState() => _TechScreenState();
}

class _TechScreenState extends State<TechScreen> {
  List<NewsArticle> _tech = [];
  bool _isLoading = true;
  String _errorMessage = '';

  Future<void> fetchTechNews() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http.get(Uri.parse(techUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (mounted) {
          setState(() {
            _tech = List<Map<String, dynamic>>.from(data['articles'])
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
    fetchTechNews();
    super.initState();
  }

  Future<void> _refresh() async {
    await fetchTechNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text('Tech News',
                style: GoogleFonts.albertSans(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54)),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/4.png',
                  fit: BoxFit.fitWidth,
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
                    onRefresh: _refresh,
                    backgroundColor: Colors.blue,
                    color: Colors.white,
                    child: ListView.builder(
                      addAutomaticKeepAlives: true,
                      itemCount: _tech.length,
                      itemBuilder: (context, index) {
                        final tech = _tech[index];
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TechDetailedScreen(
                                  imageUrl: tech.urlToImage ??
                                      'https://via.placeholder.com/300',
                                  content:
                                      tech.content ?? 'No content available',
                                  title: tech.title ?? 'No title',
                                  date: tech.publishedAt ?? 'Unknown date',
                                  author: tech.author ?? 'Unknown author',
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
                                      tag: tech.urlToImage ?? '',
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: tech.urlToImage != null
                                            ? Image.network(
                                                tech.urlToImage!,
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
                                    tech.title ?? 'No title',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              subtitle:
                                  Text(tech.description ?? 'No description'),
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
