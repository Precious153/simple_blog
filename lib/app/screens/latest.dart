import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:simple_blog/app/screens/craete_blog.dart';
import 'package:simple_blog/app/utils/components/app_route.dart';
import 'package:simple_blog/app/utils/size_config.dart';

import '../core/model/response/all_blog.dart';
import '../db/document.dart';
import '../service/home/repository.dart';
import '../utils/constants.dart';
import '../utils/reusables.dart';

class Latest extends StatefulWidget {
  const Latest({super.key});

  @override
  State<Latest> createState() => _LatestState();
}

class _LatestState extends State<Latest> {
  var allBlogs = AllBlogs();

  final repo = HomeRepository();
  Future<void> deleteBlog(BuildContext context,{required String id}) async {
    final result = await repo.deleteBlog(blogId: id);
    result.fold((l) => kToastMsgPopUp(context, message: l),
            (r) => kToastMsgPopUp(context,success: true, message: "Deleted successfully"));
  }
  String searchQuery = '';

  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CupertinoSearchTextField(
            padding: EdgeInsets.only(
              left: getScreenWidth(10),
              right: getScreenWidth(10),
              top: getScreenHeight(20),
              bottom: getScreenHeight(20),
            ),
            borderRadius: BorderRadius.circular(20),
            onChanged: (String value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          SizedBox(height: getScreenHeight(20)),

          Query(
            options: QueryOptions(
              document: gql(allBlogsDoc),
              pollInterval: const Duration(seconds: 1),
            ),
            builder: (
                QueryResult result, {
                  VoidCallback? refetch,
                  FetchMore? fetchMore,
                }) {
              if (result.hasException && (allBlogs.allBlogPosts!.isEmpty)) {
                return Column(
                  children: [
                    SizedBox(
                      height: getScreenHeight(25),
                    ),
                    const CustomText(
                        text: "Network Error",
                        color: Colors.black,
                        size: 20,
                        font: FontFamily.kSemiBold,
                        textAlign: TextAlign.center,
                        weight: FontWeight.w500),
                  ],
                );
              }

              if (result.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Palette.kPrimary,
                  ),
                );
              }
              allBlogs = AllBlogs.fromJson(result.data!);
              if (allBlogs.allBlogPosts!.isEmpty) {
                return const Column(
                  children: [
                    CustomText(
                        text: "Blogs is empty",
                        color: Colors.black,
                        size: 20,
                        font: FontFamily.kSemiBold,
                        textAlign: TextAlign.center,
                        weight: FontWeight.w500),
                  ],
                );
              }
              final filteredBlogPosts = allBlogs.allBlogPosts!.where((blog) {
                final title = blog.title!.toLowerCase();
                final subTitle = blog.subTitle!.toLowerCase();
                final query = searchQuery.toLowerCase();
                return title.contains(query) || subTitle.contains(query);
              }).toList();

              if (filteredBlogPosts.isEmpty) {
                return const Column(
                  children: [
                    CustomText(
                      text: "No results available",
                      color: Colors.black,
                      size: 16,
                      font: FontFamily.kSemiBold,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w500,
                    ),
                  ],
                );
              }
              return Expanded(
                child: ListView.builder(
                    itemCount: filteredBlogPosts.length > 4 ? 4 : filteredBlogPosts.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      AllBlogPost blogs = allBlogs.allBlogPosts![index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: getScreenHeight(20)),
                        child: Container(
                          // height: getScreenHeight(100),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(.3)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoute.createBlog,
                                  arguments: {
                                    "id": blogs.id,
                                    "title": blogs.title,
                                    "subTitle": blogs.subTitle,
                                    "body": blogs.body
                                  });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: getScreenHeight(10),
                                left: getScreenWidth(10),
                                right: getScreenWidth(10),
                                bottom: getScreenHeight(10),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: blogs.title!,
                                      color: Colors.black,
                                      size: 20,
                                      font: FontFamily.kSemiBold,
                                      textAlign: TextAlign.center,
                                      weight: FontWeight.w500),
                                  SizedBox(height: getScreenHeight(5),),
                                  CustomText(
                                      text: blogs.subTitle!,
                                      color: Colors.black,
                                      size: 12,
                                      font: FontFamily.kRegular,
                                      textAlign: TextAlign.start,
                                      weight: FontWeight.w300),
                                  SizedBox(height: getScreenHeight(5),),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                          text:  dateFormat.format(blogs.dateCreated as DateTime),
                                          color: Colors.black,
                                          size: 12,
                                          font: FontFamily.kRegular,
                                          textAlign: TextAlign.end,
                                          weight: FontWeight.w300),
                                      const Spacer(),
                                      GestureDetector(
                                          onTap: (){
                                            deleteBlog(context, id: blogs.id.toString());
                                          },
                                          child: const Icon(Icons.delete,color: Palette.kRed,))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
