import 'dart:async';

import 'package:sed/app/di.dart';
import 'package:sed/domain/usecase/home_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';

class HomeScreenViewModel extends BaseViewModel
    with HomeScreenViewModelInputs, HomeScreenViewModelOutputs {
  List<String?> carouselImages = [];

  final HomeUseCase _homeUseCase = instance<HomeUseCase>();

  final StreamController _carouselStreamController =
      StreamController<void>.broadcast();

  int carouselCurrentIndex = 0;

  @override
  void start() async {
    var response = await _homeUseCase.execute(null);

    response.fold(
            (failure) => {
          // left -> failure
        }, (response) {
      // right -> success
      // navigate to main screen
      carouselImages = response.carouselImages;
    });
  }

  @override
  void dispose() {
    _carouselStreamController.close();
    super.dispose();
  }

  void onPageChanged(int index) {
    carouselCurrentIndex = index;

    carouselInput.add(null);
  }

  @override
  Sink get carouselInput => _carouselStreamController.sink;

  @override
  Stream<void> get carouselOutput =>
      _carouselStreamController.stream.map((index) => () {});
}

abstract class HomeScreenViewModelInputs {
  Sink get carouselInput;
}

abstract class HomeScreenViewModelOutputs {
  Stream<void> get carouselOutput;
}