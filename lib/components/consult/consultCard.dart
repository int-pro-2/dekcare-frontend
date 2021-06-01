import 'package:dekcare_frontend/components/constants.dart';
import 'package:dekcare_frontend/provider/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class consultCard extends StatefulWidget {
  final id, name, profile, hospital, press;
  bool isFavorite;

  consultCard(
      {this.id,
      this.name,
      this.profile,
      this.hospital,
      this.press,
      required this.isFavorite});

  @override
  _consultCardState createState() => _consultCardState();
}

class _consultCardState extends State<consultCard> {
  void updateFavorite(String doctorId, bool isFav) async {
    try {
      await Provider.of<ChatProvider>(context, listen: false)
          .onChangeFavorite(doctorId, isFav);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
          height: height * 0.15,
          width: width * 0.95,
          child: MaterialButton(
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: whitePrimary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 4,
                        offset: Offset(0, 4))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.profile),
                      backgroundColor: greyPrimary,
                      radius: 45,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(widget.hospital,
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: width * 0.06),
                  Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        child: MaterialButton(
                          child: Icon(
                            widget.isFavorite == true
                                ? Icons.star
                                : Icons.star_border_outlined,
                            color: yellowPrimary,
                            size: 20,
                          ),
                          splashColor: greySecondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          onPressed: () {
                            updateFavorite(widget.id, !widget.isFavorite);
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            onPressed: widget.press,
          )),
    );
  }
}
