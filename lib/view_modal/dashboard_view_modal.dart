import 'package:movie_browser_task/modal/http_response_modal.dart';
import 'package:movie_browser_task/modal/most_popular_modal.dart';
import 'package:movie_browser_task/modal/movie_details_modal.dart';
import 'package:movie_browser_task/service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:movie_browser_task/util/text.dart';
import 'package:movie_browser_task/view/movie_details_view.dart';

class DashboardViewModal extends ChangeNotifier {
  DashboardViewModal() {
    loadMostPopularPosters();
  }

  int _pageNo = 1;
  bool _isAPILoading = false;
  bool _isDefaultAPI = true;
  int _sortVal = 1;
  PaginatedModal? _mostPopular;
  TextEditingController _searchController = TextEditingController(text: "");
  String? _searchControllerErrorText;

  int get pageNo => _pageNo;
  bool get isAPILoading => _isAPILoading;
  bool get isDefaultAPI => _isDefaultAPI;
  int get sortVal => _sortVal;
  PaginatedModal? get mostPopular => _mostPopular;

  TextEditingController get searchController => _searchController;
  String? get searchControllerErrorText => _searchControllerErrorText;

  void sortingOnChangeEvent(int index) {
    _sortVal = index;

    sortlist();
    notifyListeners();
  }

  void sortlist() {
    if (_sortVal == 2) {
      _mostPopular?.results.sort((b, a) => a.voteAverage!.compareTo(b.voteAverage!));
    } else {
      _mostPopular?.results.sort((a, b) => a.popularity!.compareTo(b.popularity!));
    }
  }

  void searchOnPressEvent(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Container()));
  }

  void nextOnPressEvent() {
    _pageNo = _pageNo + 1;
    _isAPILoading = true;
    notifyListeners();
    (_isDefaultAPI) ? loadMostPopularPosters() : searchMovie(_pageNo);
  }

  void prevOnPressEvent() {
    _pageNo = _pageNo - 1;
    _isAPILoading = true;
    notifyListeners();
    (_isDefaultAPI) ? loadMostPopularPosters() : searchMovie(_pageNo);
  }

  void gridOnPressEvent() {
    _pageNo = 1;
    _isAPILoading = true;
    _isDefaultAPI = true;
    _searchController.text = "";
    _searchControllerErrorText = null;
    loadMostPopularPosters();
    notifyListeners();
  }

  Future<void> loadMostPopularPosters() async {
    HttpResponseModal responseModal = await UTILHttpService.getCallWithAuth(
        "https://api.themoviedb.org/3/movie/popular?api_key=ec03f5ddd9c9cf6d45d7b580f447494a&language=en-US&page=$_pageNo");

    if (responseModal.status == 200) {
      _mostPopular = PaginatedModal.fromJson(responseModal.message);
      sortlist();
    }
    _isDefaultAPI = true;

    _isAPILoading = false;

    notifyListeners();
  }

  Future<void> searchMovie(int page) async {
    _pageNo = page;
    _isAPILoading = true;
    _mostPopular = null;

    notifyListeners();

    HttpResponseModal responseModal = await UTILHttpService.getCallWithAuth(
        "https://api.themoviedb.org/3/search/movie?api_key=ec03f5ddd9c9cf6d45d7b580f447494a&language=en-US&query=${_searchController.text.trim()}&page=$_pageNo&include_adult=false");

    if (responseModal.status == 200) {
      _mostPopular = PaginatedModal.fromJson(responseModal.message);
      if (_mostPopular!.results.isEmpty) {
        _searchControllerErrorText = "No movies for '${_searchController.text}'";
      }
      _isDefaultAPI = false;
      sortlist();
    } else {
      _searchControllerErrorText = responseModal.message;
      _isDefaultAPI = true;
    }

    _isAPILoading = false;
    notifyListeners();
  }

  Future<void> searchMovieById(int id, BuildContext context) async {
    _isAPILoading = true;

    notifyListeners();

    HttpResponseModal responseModal =
        await UTILHttpService.getCallWithAuth("https://api.themoviedb.org/3/movie/$id?api_key=ec03f5ddd9c9cf6d45d7b580f447494a&language=en-US");

    if (responseModal.status == 200) {
      MovieDetailsModal modal = MovieDetailsModal.fromJson(responseModal.message);

      _isDefaultAPI = false;

      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailedView(movie: modal)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: UTILText(responseModal.message)));
    }

    _isAPILoading = false;
    notifyListeners();
  }

  void searchFieldOnChangeEvent(String text) {
    _searchControllerErrorText = null;
    notifyListeners();
  }
}
