import 'package:flutter/material.dart';
import 'package:movie_browser_task/util/image.dart';
import 'package:movie_browser_task/util/text.dart';
import 'package:movie_browser_task/util/text_field.dart';
import 'package:movie_browser_task/view_modal/dashboard_view_modal.dart';
import 'package:provider/provider.dart';
import '../modal/most_popular_modal.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardViewModal viewModal = context.watch<DashboardViewModal>();
    return Scaffold(
      appBar: AppBar(
        title: const UTILText("Movie Browser"),
        actions: [
          IconButton(
            onPressed: () {
              sorting(context, viewModal);
            },
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: (viewModal.isAPILoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(child: gridViewWidget(context, viewModal)),
    );
  }

  Widget gridViewWidget(BuildContext context, DashboardViewModal viewModal) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: UTILTextField(
                  controller: viewModal.searchController,
                  hintText: "Search movie",
                  errorText: viewModal.searchControllerErrorText,
                  suffixIcon: (viewModal.searchController.text.trim().length >= 3) ? Icons.search : null,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  suffixIconResponse: () => viewModal.searchMovie(1),
                  onChange: (text) => viewModal.searchFieldOnChangeEvent(text),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                viewModal.gridOnPressEvent();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(color: (viewModal.isDefaultAPI) ? Colors.blue : Colors.blue.shade200, borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.grid_view,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.center,
          children: List.generate(
              viewModal.mostPopular?.results.length ?? 0, (index) => moviePosterCard(context, (viewModal.mostPopular?.results.elementAt(index))!, viewModal)),
        ),
        const SizedBox(
          height: 30,
        ),
        if (viewModal.mostPopular?.results.isNotEmpty ?? false) paginatedCard(context, viewModal),
        if (viewModal.mostPopular?.results.isNotEmpty ?? false)
          const SizedBox(
            height: 10,
          ),
      ],
    );
  }

  Widget paginatedCard(BuildContext context, DashboardViewModal viewModal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: prevNextButtonBox(viewModal.pageNo == 1, false, context, viewModal)),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: UTILText("${(viewModal.pageNo).toString()} out of ${viewModal.mostPopular?.totalPages ?? 0}", fontWeight: FontWeight.bold)),
        Padding(
            padding: const EdgeInsets.only(left: 20), child: prevNextButtonBox(viewModal.pageNo == viewModal.mostPopular?.totalPages, true, context, viewModal))
      ],
    );
  }

  ///   pagination prev, next box UI
  Widget prevNextButtonBox(bool isDisable, bool isNext, BuildContext context, DashboardViewModal viewModal) {
    return InkWell(
        onTap: () => (isNext) ? viewModal.nextOnPressEvent() : viewModal.prevOnPressEvent(),
        child: Container(
          alignment: Alignment.center,
          padding: (!isNext) ? EdgeInsets.only(left: 8) : null,
          height: 40,
          width: 40,
          decoration: (isDisable)
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.grey.withOpacity(0.5), border: Border.all(color: Theme.of(context).primaryColorLight))
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                  border: Border.all(color: Theme.of(context).primaryColor)),
          child: Icon((isNext) ? Icons.arrow_forward_ios : Icons.arrow_back_ios, color: isDisable ? Colors.grey : Theme.of(context).primaryColor),
        ));
  }

  Widget moviePosterCard(BuildContext context, MostPopularModal poster, DashboardViewModal viewModal) {
    final width = MediaQuery.of(context).size.width;
    double rating = poster.voteAverage ?? 0;
    return InkWell(
      onTap: () => viewModal.searchMovieById(poster.id ?? 0, context),
      child: Container(
        width: (width / 2) - 5,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 2.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            border: Border.all(color: Colors.blue, width: 0.5),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                width: width / 2,
                child: UTILImage(
                  image: poster.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 6,
                          top: 7,
                          child: Center(
                            child: UTILText(
                              poster.voteAverage.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        CircularProgressIndicator(
                          value: (poster.voteAverage ?? 0) / 10,
                          color: (rating >= 8) ? Colors.green : ((rating < 8 && rating >= 6) ? Colors.orange : Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const UTILText(
                      "Rating",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///   change password alert dialog
  Future<bool?> sorting(BuildContext context, DashboardViewModal viewModal) async {
    return (await showGeneralDialog(
            context: context,
            pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const UTILText("Sort by", fontSize: 18, fontWeight: FontWeight.bold),
                          IconButton(
                              icon: Icon(Icons.cancel, color: Colors.black, size: (MediaQuery.of(context).size.width >= 600) ? 30 : null),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              })
                        ],
                      ),
                    ),
                    Container(height: 2, color: Colors.black)
                  ],
                ),
                titlePadding: EdgeInsets.zero,
                contentPadding: const EdgeInsets.all(10),
                content: StatefulBuilder(builder: (BuildContext context, StateSetter dialogSetState) {
                  return SingleChildScrollView(
                    child: SizedBox(
                      width: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile<int>(
                            title: const UTILText("Sort by popularity"),
                            value: 1,
                            groupValue: viewModal.sortVal,
                            onChanged: (int? val) {
                              Navigator.pop(context);
                              viewModal.sortingOnChangeEvent(val ?? 1);
                              dialogSetState(() {});
                            },
                          ),
                          RadioListTile<int>(
                            title: const UTILText("Sort by rating"),
                            value: 2,
                            groupValue: viewModal.sortVal,
                            onChanged: (int? val) {
                              Navigator.pop(context);
                              viewModal.sortingOnChangeEvent(val ?? 1);
                              dialogSetState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
            barrierDismissible: false,
            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
            transitionDuration: const Duration(milliseconds: 500))) ??
        false;
  }
}
