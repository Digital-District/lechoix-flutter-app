import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lechoix/core/base/base_state.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/base/dummy_bloc.dart';

class GalleryViewScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const GalleryViewScreen(
      {super.key, required this.images, this.initialIndex = 0});

  @override
  _GalleryViewScreenState createState() => _GalleryViewScreenState();
}

class _GalleryViewScreenState extends BaseState<GalleryViewScreen, DummyBloc> {
  int _index = 0;

  @override
  void initBloc() {
    bloc = DummyBloc(this);
    _index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('value'),
      direction: DismissDirection.vertical,
      onDismissed: (_) => Navigator.pop(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: Row(
            children: <Widget>[
              IconButton(
                alignment: AlignmentDirectional.centerStart,
                icon: const Icon(Icons.close, color: UIConstants.blackColor),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            CarouselSlider(
              items: widget.images.map((e) {
                return PhotoView(
                  imageProvider: NetworkImage(e),
                );
              }).toList(),
              options: CarouselOptions(
                height: double.infinity,
                autoPlay: false,
                viewportFraction: 1,
                initialPage: widget.initialIndex,
                onPageChanged: (int index, CarouselPageChangedReason reason) {
                  setState(() {
                    _index = index;
                  });
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(32),
                child: AnimatedSmoothIndicator(
                  activeIndex: _index,
                  count: widget.images.length,
                  effect: WormEffect(
                    activeDotColor: Theme.of(context).colorScheme.secondary,
                    dotWidth: 12,
                    dotHeight: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
