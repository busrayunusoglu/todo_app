// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/bloc/tap_bar/tap_bar_cubit.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/text_field_widget.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final TodoRepository repo = TodoRepository();

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [const Color(0xFF000000), const Color(0xFF8B0005)];

    List<Color> colors2 = [
      const Color(0xFF191A26).withOpacity(0.1),
      const Color(0xFF7E8CA0).withOpacity(0.8)
    ];
    List<double> stops = [0.0, 1.4];
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TapBarCubit()),
      ],
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: Adaptive.w(100),
                height: Adaptive.h(35),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  gradient: LinearGradient(
                    colors: colors,
                    stops: stops,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: Adaptive.h(8),
                    ),
                    SizedBox(
                      width: Adaptive.w(90),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/tasks.svg",
                            width: Adaptive.w(10),
                          ),
                          SizedBox(
                            width: Adaptive.w(3),
                          ),
                          const Text(
                            "TODO APP",
                            style: TextStyle(
                              fontFamily: "FontMedium",
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Adaptive.h(6),
                    ),
                    SizedBox(
                      width: Adaptive.w(88),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Adaptive.w(75),
                            child:
                                const TextFieldWidget(hintText: "Todo Giriniz"),
                          ),
                          SizedBox(
                            width: Adaptive.w(1),
                          ),
                          SvgPicture.asset(
                            "assets/icons/add.svg",
                            width: Adaptive.w(10),
                          )
                        ],
                      ),
                    ),
                  ],
                )),

            SizedBox(
              height: Adaptive.h(2),
            ),
            Padding(
              padding: EdgeInsets.only(left: Adaptive.w(7)),
              child: Row(
                children: [
                  const Text(
                    "TODOLAR",
                    style: TextStyle(
                      fontFamily: "FontMedium",
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Constants.cursorColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Adaptive.h(2),
            ),
            SizedBox(
              width: Adaptive.w(92),
              height: Adaptive.h(60),
              child: FutureBuilder<List<TodoModel?>?>(
                future: repo.todo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: Adaptive.h(100),
                      width: Adaptive.w(100),
                      child: ListView.builder(
                        itemCount: 20,
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (BuildContext c, int i) {
                          return Column(
                            children: [
                              Container(
                                width: Adaptive.w(100),
                                height: Adaptive.h(7),
                                decoration: BoxDecoration(
                                  color:
                                      Constants.textThreeColor.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: colors2,
                                    stops: stops,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Adaptive.w(80),
                                      child: ListTile(
                                        title: snapshot.data![i]!.userId == 1
                                            ? Text(
                                                "${snapshot.data![i]!.id}) ${snapshot.data![i]!.title}",
                                                style: const TextStyle(
                                                  fontFamily: "FontMedium",
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Constants.mainColor,
                                                ),
                                              )
                                            : null,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/remove.svg",
                                      width: Adaptive.w(8),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Adaptive.h(1),
                              )
                            ],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const CircularProgressIndicator();
                  } else {
                    return Container();
                  }
                },
              ),
            ),

            SizedBox(
              height: Adaptive.h(2),
            ),

            // BlocBuilder<TapBarCubit, TapBarState>(
            //   builder: (context, state) {
            //     return const Text("");
            //   },
            // ),
            // SizedBox(
            //   height: Adaptive.h(2),
            // ),
            // BlocBuilder<TapBarCubit, TapBarState>(
            //   builder: (context, state) {
            //     if (state is CompletedTask) {
            //       return FutureBuilder<List<TodoModel?>?>(
            //         future: repo.todo(),
            //         builder: (context, snapshot) {
            //           if (snapshot.hasData) {
            //             return SizedBox(
            //               height: Adaptive.h(100),
            //               width: Adaptive.w(100),
            //               child: ListView.builder(
            //                 itemCount: 20,
            //                 itemBuilder: (BuildContext c, int i) {
            //                   return ListTile(
            //                     title: snapshot.data![i]!.userId == 1
            //                         ? Text(
            //                             snapshot.data![i]!.title.toString(),
            //                           )
            //                         : null,
            //                   );
            //                 },
            //               ),
            //             );
            //           } else if (snapshot.hasError) {
            //             return const CircularProgressIndicator();
            //           } else {
            //             return Container();
            //           }
            //         },
            //       );
            //     }

            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}