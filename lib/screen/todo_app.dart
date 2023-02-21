// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:checkbox_formfield/checkbox_icon_formfield.dart';
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

  TextEditingController _todoController = TextEditingController();
  List todoList = [];

  void addTodo() {
    setState(() {
      todoList.add(_todoController.text);
      _todoController.clear();
    });
  }

  void deleteTodo() {
    setState(() {
      todoList.remove(_todoController.text);
      _todoController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [const Color(0xFF000000), const Color(0xFF8B0005)];

    List<Color> colors2 = [
      const Color(0xFF191A26).withOpacity(0.1),
      const Color(0xFF7E8CA0).withOpacity(0.8)
    ];
    List<double> stops = [0.0, 1.4];

    final formKey = GlobalKey<FormState>();
    bool? checkboxIconFormFieldValue = false;

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
                            child: TextFieldWidget(
                              controller: _todoController,
                              hintText: "Todo Giriniz",
                            ),
                          ),
                          SizedBox(
                            width: Adaptive.w(1),
                          ),
                          InkWell(
                            onTap: () {
                              addTodo();
                              print(todoList);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/add.svg",
                              width: Adaptive.w(10),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: Adaptive.h(2),
            ),
            BlocBuilder<TapBarCubit, TapBarState>(
              builder: (context, state) {
                return Container(
                  width: Adaptive.w(92),
                  height: Adaptive.h(7),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: colors2,
                        stops: stops,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      List<String> listName = [
                        "Tümü",
                        "Tamamlanmış",
                        "Tamamlanmamış",
                      ];

                      if (index == 0) {
                        return InkWell(
                          onTap: () {
                            context.read<TapBarCubit>().changeTabbar(index);
                          },
                          child: SizedBox(
                              width: Adaptive.w(12),
                              height: Adaptive.h(6),
                              child: Center(
                                child: Text(
                                  listName[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: context
                                                .read<TapBarCubit>()
                                                .currentIndex ==
                                            index
                                        ? Constants.cursorColor
                                        : Constants.mainColor,
                                    fontFamily: 'FontBold',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          if (context.read<TapBarCubit>().currentIndex !=
                              index) {
                            context.read<TapBarCubit>().changeTabbar(index);
                          }
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: Adaptive.w(2),
                            ),
                            SizedBox(
                              width: Adaptive.w(38),
                              height: Adaptive.h(6),
                              child: Center(
                                child: Text(
                                  listName[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: context
                                                .read<TapBarCubit>()
                                                .currentIndex ==
                                            index
                                        ? Constants.cursorColor
                                        : Constants.mainColor,
                                    fontFamily: 'FontBold',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: Adaptive.h(2),
            ),
            BlocBuilder<TapBarCubit, TapBarState>(
              builder: (context, state) {
                if (state is AllTasks) {
                  return Column(
                    children: [
                      SizedBox(
                        width: Adaptive.w(92),
                        height: Adaptive.h(100),
                        child: FutureBuilder<List<TodoModel?>?>(
                          future: repo.todo(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var userOne = snapshot.data!
                                  .where((e) => e!.userId == 1)
                                  .toList();
                              return SizedBox(
                                height: Adaptive.h(60),
                                width: Adaptive.w(100),
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: userOne.length,
                                  padding: const EdgeInsets.all(0),
                                  itemBuilder: (BuildContext c, int i) {
                                    return Column(
                                      children: [
                                        Container(
                                          width: Adaptive.w(100),
                                          height: Adaptive.h(7),
                                          decoration: BoxDecoration(
                                            color: Constants.textThreeColor
                                                .withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                              colors: colors2,
                                              stops: stops,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              CheckboxIconFormField(
                                                context: context,
                                                initialValue:
                                                    checkboxIconFormFieldValue!,
                                                trueIconColor:
                                                    Constants.mainColor,
                                                enabled: true,
                                                padding: 0,
                                                iconSize: 20,
                                                onSaved: (bool? value) {
                                                  checkboxIconFormFieldValue =
                                                      value;
                                                },
                                              ),
                                              SizedBox(
                                                width: Adaptive.w(70),
                                                child: ListTile(
                                                  title: Text(userOne[i]!
                                                      .title
                                                      .toString()),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  deleteTodo();
                                                  print(todoList);
                                                },
                                                child: SvgPicture.asset(
                                                  "assets/icons/remove.svg",
                                                  width: Adaptive.w(8),
                                                ),
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
                        height: Adaptive.h(30),
                        width: Adaptive.w(92),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: todoList.length,
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (BuildContext c, int i) {
                            return Column(
                              children: [
                                Container(
                                  width: Adaptive.w(100),
                                  height: Adaptive.h(7),
                                  decoration: BoxDecoration(
                                    color: Constants.textThreeColor
                                        .withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: colors2,
                                      stops: stops,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CheckboxIconFormField(
                                        context: context,
                                        initialValue:
                                            checkboxIconFormFieldValue!,
                                        trueIconColor: Constants.mainColor,
                                        enabled: true,
                                        padding: 0,
                                        iconSize: 20,
                                        onSaved: (bool? value) {
                                          checkboxIconFormFieldValue = value;
                                        },
                                      ),
                                      SizedBox(
                                        width: Adaptive.w(70),
                                        child: ListTile(
                                          title: Text(todoList[i]),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          deleteTodo();
                                          print(todoList);
                                        },
                                        child: SvgPicture.asset(
                                          "assets/icons/remove.svg",
                                          width: Adaptive.w(8),
                                        ),
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
                      ),
                    ],
                  );
                }

                if (state is CompletedTask) {
                  return SizedBox(
                    width: Adaptive.w(92),
                    height: Adaptive.h(60),
                    child: FutureBuilder<List<TodoModel?>?>(
                      future: repo.todo(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var userOne = snapshot.data!
                              .where(
                                  (e) => e!.userId == 1 && e.completed == true)
                              .toList();
                          return SizedBox(
                            height: Adaptive.h(100),
                            width: Adaptive.w(100),
                            child: ListView.builder(
                              itemCount: userOne.length,
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (BuildContext c, int d) {
                                return Column(
                                  children: [
                                    Container(
                                      width: Adaptive.w(100),
                                      height: Adaptive.h(7),
                                      decoration: BoxDecoration(
                                        color: Constants.textThreeColor
                                            .withOpacity(0.4),
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
                                                title: Text(
                                              userOne[d]!.title.toString(),
                                              style: const TextStyle(
                                                fontFamily: "FontMedium",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Constants.mainColor,
                                              ),
                                            )),
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
                          return Container(
                            width: 25,
                            height: 25,
                            color: Colors.red,
                          );
                        }
                      },
                    ),
                  );
                }

                if (state is UncompletedTask) {
                  return SizedBox(
                    width: Adaptive.w(92),
                    height: Adaptive.h(60),
                    child: FutureBuilder<List<TodoModel?>?>(
                      future: repo.todo(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var userOne = snapshot.data!
                              .where(
                                  (e) => e!.userId == 1 && e.completed == false)
                              .toList();
                          return SizedBox(
                            height: Adaptive.h(100),
                            width: Adaptive.w(100),
                            child: ListView.builder(
                              itemCount: userOne.length,
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (BuildContext c, int d) {
                                return Column(
                                  children: [
                                    Container(
                                      width: Adaptive.w(100),
                                      height: Adaptive.h(7),
                                      decoration: BoxDecoration(
                                        color: Constants.textThreeColor
                                            .withOpacity(0.4),
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
                                                title: Text(
                                              userOne[d]!.title.toString(),
                                              style: const TextStyle(
                                                fontFamily: "FontMedium",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Constants.mainColor,
                                              ),
                                            )),
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
                          return Container(
                            width: 25,
                            height: 25,
                            color: Colors.red,
                          );
                        }
                      },
                    ),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
