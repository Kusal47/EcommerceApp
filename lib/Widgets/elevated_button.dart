// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../Dimension/height_width.dart';
import '../Screen Page/Payment Page/esewa.dart';
import '../Screen Page/Payment Page/khaltipay.dart';
import 'large_font.dart';

class ButtonElevated extends StatefulWidget {
  const ButtonElevated({
    Key? key,
    this.text1,
    this.text2,
    this.text3,
    this.text4,
    this.text5,
    this.text6,
    this.bgColor,
    required this.onPressed1,
    this.onPressed2,
    this.quantity,
    this.isCancel,
    this.isPayment = false,  this.price,  this.productId,this.isTotalAmt=false,
  }) : super(key: key);

  final String? text1;
  final String? text2;
  final String? text3;
  final String? text4;
  final String? text5;
  final String? text6;
  final Color? bgColor;
  final Function onPressed1;
  final Function? onPressed2;
  final int? quantity;
  final bool? isCancel;
  final bool isPayment;
  final double? price;
  final int? productId;
  final bool isTotalAmt;

  @override
  State<ButtonElevated> createState() => _ButtonElevatedState();
}

class _ButtonElevatedState extends State<ButtonElevated> {
  // Future<void> _playSound(String soundPath) async {
  //   final player = AudioPlayer();
  //   await player.play(AssetSource(soundPath));
  // }

  @override
  Widget build(BuildContext context) {
    return widget.isPayment
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.heightFor10 / 2),
              ),
            ),
            onPressed: () async {
              // await _playSound('audio_tones/thunk.wav');
              setState(() {
                if (widget.quantity != 0) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.heightFor10),
                        ),
                        title: Text(widget.text2!),
                        content: Container(
                          height: Dimensions.heightFor80 * 1.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EsewaApp(
                                    price: widget.price,
                                    productId: widget.productId,
                                  ),
                                  KhaltiApp(
                                    price: widget.price,
                                    productId: widget.productId,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.heightFor10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Close',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: Dimensions.font20)),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(widget.text6!),
                      content: Text(widget.text4!),
                      actions: [
                        TextButton(
                          onPressed: () {
                            widget.onPressed1();
                          },
                          child: Text(widget.text5!),
                        ),
                      ],
                    ),
                  );
                }
              });
            },
            child: TextSize(
              text: widget.text1!,
              size: Dimensions.font20,
              color: Colors.white,
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.bgColor!,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () async {
              // await _playSound('audio_tones/boing2.wav');

              setState(() {
                if (widget.quantity != 0) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(widget.text1!),
                      content: Text(widget.text2!),
                      actions: [
                        TextButton(
                          onPressed: () {
                            widget.onPressed1();
                          },
                          child: Text(widget.text3!),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.onPressed2!();
                          },
                          child: Text(widget.text4!),
                        ),
                      ],
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(widget.text1!),
                      content: Text(widget.text5!),
                      actions: [
                        TextButton(
                          onPressed: () {
                            widget.onPressed2!();
                          },
                          child: Text(widget.text6!),
                        ),
                      ],
                    ),
                  );
                }
              });
            },
            child: TextSize(
              text: widget.text1!,
              size: Dimensions.font20,
              color: Colors.white,
            ),
          );
  }
}
