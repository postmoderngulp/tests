
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'holder.dart';
import '../../domain/usecases/usecase_local.dart';
import '../provider/onboard_notifier.dart';
import '../style/colors.dart';
import '../style/fonts.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final useCase = context.read<UseCaseLocalSource>();
    return ChangeNotifierProvider(create: (context) => OnBoardNotifier(caseLocalSource: useCase),child: const SubOnBoard(),);
  }
}

class SubOnBoard extends StatelessWidget {
  const SubOnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<OnBoardNotifier>();
    return model.isEmpty ? const Holder(key: ValueKey('HolderKey'),) : Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               model.item != null ? model.item?.title == 'Quick Delivery At Your Doorstep' ? SizedBox(
                  height: 66.h,
                ) : SizedBox(
                  height: 88.h,
                ) : SizedBox(
                  height: 88.h,
                ),
                    const Center(
                      child: BoardItem(
                    ),
                  ),
                 SizedBox(
                        height: 82.h,
                      ),
                const GroupButton(),
               model.isLast ? const SignInLabel() : const SizedBox(),
                model.isLast ? SizedBox(height: 64.h) : SizedBox(
                        height: 99.h,
                      ),
                      
              ],
            ),
          )),
      ),
    );
  }
}


class BoardItem extends StatelessWidget {
  const BoardItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<OnBoardNotifier>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        model.item != null ? 
        SvgPicture.asset(
          'assets/image/${model.item!.picture}.svg',
          width: model.item!.width.w,
          height: model.item!.height.h,
        ) : const SizedBox(),
        SizedBox(
          height: 48.h,
        ),
        SizedBox(
          width: 287.w,
          child: Text(
            model.item != null ?  model.item!.title : '',
            textAlign: TextAlign.center,
            style: Fonts.main,
          ),
        ),
        SizedBox(
          width: 271.w,
          child: Text(
           model.item != null ?  model.item!.label :  "",
            style: Fonts.labelBoard,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class SignInLabel extends StatelessWidget {
  const SignInLabel({super.key});

  @override
  Widget build(BuildContext context) {
     final model = context.watch<OnBoardNotifier>();
    return 
         Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                     onTap: () {
                                 model.next();
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Holder()), (route) => false);
                            },
                    child: RichText(text: TextSpan(
                      text: 'Already have an account?',
                      style: Fonts.labelGreyBoard,
                      children: [
                        TextSpan(
                          text: 'Sign in',
                           style: Fonts.skipBoard,
                        )
                      ]
                    )),
                  ),
                ],
              ),
        );
  }
}

class GroupButton extends StatelessWidget {
  const GroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<OnBoardNotifier>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child:
       model.isLast
              ? 
              SizedBox(
                  width: 342.w,
                  height: 46.h,
                  child: ElevatedButton(
                    onPressed: ()  {
                      model.next();
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Holder()), (route) => false);
                    },
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0),
                        backgroundColor: MaterialStatePropertyAll(colors.main),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.69))))),
                    child: Text(
                      'Sign Up',
                      style: Fonts.nextBoard,
                    ),
                  ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 100.w,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            model.load([]);
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Holder()), (route) => false);
                          },
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(0),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.transparent),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      side: BorderSide(color: colors.main),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.69))))),
                          child: Text(
                            'Skip',
                            style: Fonts.skipBoard,
                          ),
                        )),
                    const Spacer(),
                    SizedBox(
                        width: 100.w,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () => model.next(),
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(0),
                              backgroundColor:
                                  MaterialStatePropertyAll(colors.main),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.69))))),
                          child: Text(
                            'Next',
                            style: Fonts.nextBoard,
                          ),
                        )),
                  ],
                ),
    );
  }
}
