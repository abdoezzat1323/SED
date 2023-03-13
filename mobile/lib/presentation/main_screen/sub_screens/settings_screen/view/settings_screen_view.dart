import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/common/animation_manager/animation_manager.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/sub_screens/settings_screen/viewmodel/settings_screen_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../resources/strings_manager.dart';

class SettingsScreenView extends StatefulWidget {
  const SettingsScreenView({super.key});

  @override
  State<SettingsScreenView> createState() => _SettingsScreenViewState();
}

class _SettingsScreenViewState extends State<SettingsScreenView> {
  final SettingsScreenViewModel _viewModel = SettingsScreenViewModel();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _viewModel.start();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GetMyProfileData>(
        stream: _viewModel.contentOutput,
        builder: (context, snapshot) {
          return _buildWidget(snapshot.data);
        });
  }

  @override
  void dispose() {
    _viewModel.dispose();

    super.dispose();
  }

  Widget _buildWidget(GetMyProfileData? getMyProfileData) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 135,
        title: _getProfileInformation(getMyProfileData),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
              context, _getBody(), () => (){}) ??
              _getBody();
        },
      ),
    );
  }

  Widget _getInkwell(
      IconData inkwellIcon, String inkwellTitle, Function() inkwellFunction) {
    return InkWell(
      onTap: () {
        inkwellFunction();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s10)),
            color: ColorsManager.secondaryBackground,
          ),
          height: AppSize.s40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Icon(
                      inkwellIcon,
                      size: AppSize.s30,
                      color: ColorsManager.secondaryText,
                    ),
                  ),
                  Text(
                    inkwellTitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorsManager.secondaryText,
                          fontSize: AppSize.s14,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Icon(
                  IconsManager.rightRoundedArrow,
                  color: ColorsManager.secondaryText,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getProfileInformation(GetMyProfileData? getMyProfileData) {
    if (getMyProfileData == null) {
      return Container();
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: AppSize.s14, left: AppSize.s5, right: AppSize.s18),
            child: CircleAvatar(
              radius: AppSize.s38,
              backgroundImage: NetworkImage(getMyProfileData.user.image),
            ).animateOnPageLoad(
                msDelay: 150, dx: 0.0, dy: -70.0, showDelay: 600),
          ),
          const SizedBox(
            height: AppSize.s12,
          ),
          Column(
            children: [
              Text(
                getMyProfileData.user.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorsManager.primaryText,
                      fontSize: AppSize.s18,
                    ),
              ).animateOnPageLoad(
                  msDelay: 150, dx: -70.0, dy: 0.0, showDelay: 600),
              Text(
                getMyProfileData.user.address,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorsManager.secondaryText,
                      fontSize: AppSize.s14,
                    ),
              ).animateOnPageLoad(
                  msDelay: 150, dx: 70.0, dy: 0.0, showDelay: 600),
            ],
          ),
          Divider(
            height: 15,
            color: ColorManager.grey2,
          ).animateOnPageLoad(msDelay: 150, dx: 0.0, dy: 0.0, showDelay: 600),
        ],
      );
    }
  }

  Widget _getBody(){
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            _getInkwell(IconsManager.account, AppStrings.account, () {})
                .animateOnPageLoad(
                msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
            const SizedBox(
              height: AppSize.s5,
            ),
            _getInkwell(IconsManager.myAds, AppStrings.myAds, () {
              Navigator.pushNamed(context, Routes.myAdsScreenRoute);
            }).animateOnPageLoad(
                msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
            Padding(
              padding: const EdgeInsets.only(
                  top: AppPadding.p25,
                  left: AppPadding.p8,
                  right: AppPadding.p5,
                  bottom: AppPadding.p5),
              child: Text(
                textAlign: TextAlign.start,
                AppStrings.settings,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: ColorsManager.grey,
                ),
              ),
            ).animateOnPageLoad(
                msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
            _getInkwell(IconsManager.languageController,
                AppStrings.language, () {})
                .animateOnPageLoad(
                msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
            const SizedBox(
              height: AppSize.s5,
            ),
            _getInkwell(
                IconsManager.themeController, AppStrings.theme, () {})
                .animateOnPageLoad(
                msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
            const SizedBox(
              height: AppSize.s5,
            ),
            _getInkwell(IconsManager.notification, AppStrings.notifications,
                    () {})
                .animateOnPageLoad(
                msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
            Padding(
              padding: const EdgeInsets.only(
                  top: AppPadding.p25,
                  left: AppPadding.p8,
                  right: AppPadding.p5,
                  bottom: AppPadding.p5),
              child: Text(
                textAlign: TextAlign.start,
                AppStrings.general,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: ColorsManager.grey,
                ),
              ),
            ).animateOnPageLoad(
                msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
            _getInkwell(IconsManager.share, AppStrings.share, () {
              Share.share(
                  'https://instagram.com/mohamed_shehata7920?igshid=ZDdkNTZiNTM=');
            }).animateOnPageLoad(
                msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
            const SizedBox(
              height: AppSize.s5,
            ),
            _getInkwell(IconsManager.help, AppStrings.help, () {})
                .animateOnPageLoad(
                msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
            const SizedBox(
              height: AppSize.s5,
            ),
            _getInkwell(
                IconsManager.questionMark, AppStrings.aboutUs, () {})
                .animateOnPageLoad(
                msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
          ],
        ),
      ],
    );
  }
}
