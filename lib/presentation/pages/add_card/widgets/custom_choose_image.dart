import 'package:epay/application/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../application/main_cubit.dart';
import '../../../style/style.dart';

class CustomChooseImage extends StatefulWidget {
  const CustomChooseImage({Key? key}) : super(key: key);

  @override
  State<CustomChooseImage> createState() => _CustomChooseImageState();
}

class _CustomChooseImageState extends State<CustomChooseImage> {
  List listOfImage = [
    'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712__340.jpg',
    'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
    'https://cdn.pixabay.com/photo/2018/08/14/13/23/ocean-3605547__340.jpg',
    'https://static.vecteezy.com/system/resources/thumbnails/007/718/412/small/colorful-gradient-reflection-on-wave-background-free-vector.jpg',
    'https://virtuoart.com/public/uploads/preview/0b528dd5a822d5e16d143138534514aa-62021588164438plqnqqtuwg.jpg',
    'https://img4.goodfon.com/wallpaper/nbig/e/4b/volny-abstraktsiia-abstract-waves-colorful-waves.jpg',
    'https://www.stockvault.net/data/2021/01/29/282725/preview16.jpg',
    'https://media.istockphoto.com/id/1208305480/photo/beautiful-abstract-wave-technology-digital-network-background-with-blue-light-digital-effect.jpg?s=170667a&w=0&k=20&c=TjeuVJKpov4pJjSl0KP6plrILS9SW93pZng4IZ_5dZE=',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MainCubit>(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Image",
            style: Style.textStyleThin(),
          ),
          8.verticalSpace,
          BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return SizedBox(
                height: 50,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: listOfImage.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<MainCubit>()
                            ..getSelectedImageIndex(index)
                            ..getNewImage(listOfImage[index]);
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: index == state.selectedImageIndex
                                      ? Style.blackColor
                                      : Style.transparentColor),
                              image: DecorationImage(
                                  image: NetworkImage(listOfImage[index]),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle),
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
