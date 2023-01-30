import 'package:flutter/material.dart';

import 'package:divina/shared/models/api_request_model.dart';
import 'package:divina/shared/models/api_response_model.dart';

import 'package:divina/shared/widgets/toolbar.dart';
import 'package:divina/shared/widgets/header.dart';
import 'package:divina/shared/widgets/list.dart';
import 'package:divina/shared/widgets/paginator.dart';

class DataViewWidget extends StatelessWidget {

  TextEditingController controller = TextEditingController();

  bool isLoading = false;
  bool isFetchError = false;

  ApiRequest apiRequest;
  ApiResponse apiResponse;

  List<dynamic> data;
  ImageProvider leading;

  String pageTitle;

  Function(int index) onTap;
  Function(int index) onPressed;
  Function(int index) onRefresh;
  Function(int index) title;
  Function(int index) subtitle;
  Function(int index)? row;

  Function backPage;
  Function nextPage;

  bool isSearching = false;
  Function(bool value) setSearching;
  Function(String value) search;

  DataViewWidget({ 
    super.key, 
    required this.pageTitle,
    required this.apiRequest,
    required this.apiResponse,
    required this.data, 
    required this.leading, 
    required this.isLoading, 
    required this.isFetchError, 
    required this.isSearching,
    required this.setSearching,
    required this.search,
    required this.onTap, 
    required this.onPressed,
    required this.onRefresh,
    required this.title, 
    required this.subtitle, 
    required this.backPage,
    required this.nextPage,
    this.row 
  });

  @override
  Widget build(BuildContext context) {
    controller.text = apiRequest.text;
    
    return Scaffold(
      appBar: ToolBar(
        title: pageTitle,
        isSearching: isSearching,
        setSearching: (value) => setSearching(value),
        search: (value) => search(value),
        controller: controller
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
    
            // HEADER
            HeaderWidget(
              from: apiResponse.from,
              to: apiResponse.to,
              total: apiResponse.total,
            ),
            
            const Divider(
              height: 2
            ),
    
            // BODY 
            ListWidget(
              data: data, 
              leading: leading, 
              isLoading: isLoading,
              isFetchError: isFetchError,
              onTap: onTap,
              onPressed: onPressed,
              onRefresh: onRefresh,
              title: title, 
              subtitle: subtitle,
              row: row
            ),
    
            // FOOTER
            PaginatorWidget(
              isLoading: isLoading, 
              currentPage: apiResponse.current_page, 
              lastPage: apiResponse.last_page, 
              backPage: () => backPage, 
              nextPage: () => nextPage
            ),
    
            const Divider(
              height: 2,
            )
          ],
        )
      ),
    );
  }
}