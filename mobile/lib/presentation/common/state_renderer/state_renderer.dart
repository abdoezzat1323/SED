import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sed/presentation/resources/assets_manager.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/fonts_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/styles_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

import '../../main_screen/utils/utils.dart';

enum StateRendererType {
  // PopUp state
  popUpLoadingState,
  popUpErrorState,
  popUpSuccessState,
  popUpSuccessStateAndNavigate,
  popUpConfirmationState,

  // Full screen state
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  // general
  contentState,
}

// ignore: must_be_immutable
class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer(
      {super.key,
      required this.stateRendererType,
      this.message = AppStrings.loading,
      this.title = "",
      required this.retryActionFunction});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popUpLoadingState:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonAssets.loading)]);

      case StateRendererType.popUpErrorState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.ok.tr(), context)
        ]);

      case StateRendererType.popUpSuccessState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.success),
          _getTitle(title),
          _getMessage(message),
          _getRetryButton(AppStrings.ok.tr(), context),
        ]);

      case StateRendererType.popUpSuccessStateAndNavigate:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.success),
          _getTitle(title),
          _getMessage(message),
          _getRetryButton(AppStrings.ok.tr(), context),
        ]);

      case StateRendererType.popUpConfirmationState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.success),
          _getTitle(title),
          _getMessage(message),
          _getConfirmationRetryButton(AppStrings.ok.tr(), context)
        ]);

      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn(
            [_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);

      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain.tr(), context)
        ]);

      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn(
            [_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);

      case StateRendererType.contentState:
        return Container();

      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    Utils.isDialogShown = true;

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorsManager.background,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: [BoxShadow(color: ColorsManager.primaryText)]),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: getRegularStyle(
              color: ColorsManager.primaryText, fontSize: FontSize.s18),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (stateRendererType ==
                      StateRendererType.fullScreenErrorState) {
                    retryActionFunction.call();
                  } else {
                    Navigator.of(context).pop();

                    if (stateRendererType ==
                        StateRendererType.popUpSuccessStateAndNavigate) {
                      Navigator.of(context).pop();

                      Navigator.pushNamed(context, Routes.mainScreenRoute);
                    }
                  }
                },
                child: Text(buttonTitle))),
      ),
    );
  }

  Widget _getConfirmationRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        retryActionFunction.call();
                      },
                      child: Text(buttonTitle)),
                ),
                const SizedBox(
                  width: AppSize.s10,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppStrings.cancel.tr())),
                ),
              ],
            )),
      ),
    );
  }

  Widget _getTitle(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          title,
          style: getRegularStyle(
              color: ColorsManager.primaryText, fontSize: FontSize.s18),
        ),
      ),
    );
  }
}
