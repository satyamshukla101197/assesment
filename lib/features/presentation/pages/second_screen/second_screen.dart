import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supdup/core/common_widget/custom_spacer_widget.dart';
import 'package:supdup/core/config/navigation.dart';
import 'package:supdup/core/utils/constants.dart';
import 'package:supdup/core/utils/custom_extension.dart';
import 'package:supdup/features/domain/entities/data_entity.dart';
import 'package:supdup/features/presentation/pages/second_screen/second_screen_bloc.dart';
class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List image=["https://unsplash.com/photos/93Ep1dhTd2s",];
  DataEntity? dataEntity;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<SecondScreenBloc, SecondScreenState>(
          listener: (context, state) {
            if (state is SecondScreenErrorState) {
              widget.showErrorToast(
                  context: context, message: state.message ?? "");
              //Kill Loader
              Navigation.back(context);
            } else if (state is SecondScreenLoadingState) {

              widget.showProgressDialog(context);
            } else if (state is SecondScreenLoadedState) {
              //Kill Loader
              Navigation.back(context);
              if (state.dataEntity != null) {
                dataEntity=state.dataEntity;

              }
            }
          },
          builder: (context, state) {
            if (state is SecondScreenInitial) {
              BlocProvider.of<SecondScreenBloc>(context)
                  .add(SecondScreenListEvent());
            }
            return  SingleChildScrollView(
              child:  _getBoxdy(),
            );
          },
        ),
      ),
    );
  }

 Widget _getBoxdy() {
    return Container(
        child:  GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2 ,
          children: List.generate(20,(index){
            return Card(
              color: Colors.blue,
              child: Container(
                  child: Column(
                    children: <Widget>[
                      _getImage(index: index),
                      CustomSpacerWidget(height: 20.0,),
                      dataEntity==null?Text("lejandro Escamilla"):Text(dataEntity!.Result![index].author!)
                    ],
                  )
              ),
            );
          }),
        ),
    );
 }

  _getImage({required int index}) {
    return Container(
      child:dataEntity==null?Image.asset(ImageConstants.IMAGE): Image.asset(dataEntity!.Result![index].url!),
    );
  }
}
