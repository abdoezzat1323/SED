import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/sub_screens/home_screen/viewmodel/home_screen_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/styles_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final CarouselController _controller = CarouselController();

  final HomeScreenViewModel _viewModel = instance<HomeScreenViewModel>();

  void _bind() {
    _viewModel.start();

    _viewModel.getHomeData();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bind();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(
                context, _getContentWidget(), () => _viewModel.getHomeData()) ??
            _getContentWidget();
      },
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<void>(
        stream: _viewModel.carouselOutput,
        builder: (context, snapshot) {
          return SingleChildScrollView(

            child: Column(
              children: [
                const SizedBox(height: AppSize.s20),
                CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                      aspectRatio: 2.0,
                      height: AppSize.s200,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      onPageChanged: (index, reason) {
                        _viewModel.onPageChanged(index);
                      }),
                  items: _viewModel.carouselImages.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(image ?? AppStrings.empty),
                                fit: BoxFit.cover),
                            color: Colors.blue,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(AppSize.s16)),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      _viewModel.carouselImages.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: AppSize.s10,
                        height: AppSize.s10,
                        margin: const EdgeInsets.symmetric(
                            vertical: AppPadding.p8, horizontal: AppPadding.p4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ColorManager.white
                                    : ColorManager.lightPrimary)
                                .withOpacity(
                                    _viewModel.carouselCurrentIndex == entry.key
                                        ? AppSize.s0_9
                                        : AppSize.s0_4)),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSize.s10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: getBoldStyle(
                            color: ColorManager.lightPrimary, fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "Show All",
                                ),
                                Icon(Icons.keyboard_arrow_right_outlined)
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // crossAxisCount is the number of columns
                    crossAxisCount: 3,
                    // This creates two columns with two items in each column
                    children:
                        List.generate(_viewModel.categories.length, (index) {
                      return Center(
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image(
                                    image: NetworkImage(
                                        _viewModel.categories[index]!.image),
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(_viewModel.categories[index]!.name),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          );
        });
  }
}
