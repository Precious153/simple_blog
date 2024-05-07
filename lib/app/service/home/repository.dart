import 'package:dartz/dartz.dart';

import '../exception.dart';
import 'datasource.dart';

class HomeRepository {

   final _datasource = HomeDatasource();
   Future<Either<String, dynamic>> createBlog({
     required String title,
     required String subtitle,
     required String body,

   })async{
     final output = await _datasource.createBlog(body: body,subtitle: subtitle,title: title);
     if(output.hasException){
       final error = ErrorException.exception(output.exception).toString();
       return Left(error);
     }else{
       return Right(output);
     }
   }
   Future<Either<String, dynamic>> updateBlog({
     required String title,
     required String subtitle,
     required String body,
     required String bodyId,

   })async{
     final output = await _datasource.updateBlog(body: body,subtitle: subtitle,title: title, bodyId:bodyId);
     if(output.hasException){
       final error = ErrorException.exception(output.exception).toString();
       return Left(error);
     }else{
       return Right(output);
     }
   }
   Future<Either<String, dynamic>> deleteBlog({

     required String blogId,

   })async{
     final output = await _datasource.deleteBlog(blogId:blogId);
     if(output.hasException){
       final error = ErrorException.exception(output.exception).toString();
       return Left(error);
     }else{
       return Right(output);
     }
   }
 }