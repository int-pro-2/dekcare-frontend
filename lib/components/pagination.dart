import 'package:flutter/material.dart';
import 'package:flutter_vant_kit/theme/style.dart';
import 'package:dekcare_frontend/components/constants.dart';

class Pagination extends StatefulWidget {
  final int current;

  final int totalItems;

  final int itemsPerPage;

  final String mode;

  final String prevText;

  final String nextText;

  final int showPageSize;

  final Function(int? page)? onChange;

  Pagination({
    Key? key,
    this.current: 1,
    this.totalItems: 0,
    this.itemsPerPage: 3,
    this.mode: "simple",
    this.prevText: "ย้อนกลับ",
    this.nextText: "ต่อไป",
    this.showPageSize: 5,
    this.onChange,
  }) : super(key: key);

  @override
  _Pagination createState() => _Pagination();
}

class _Pagination extends State<Pagination> {
  int? pagesLength;
  int? pageLength;
  List<int> pages = [];
  GlobalKey _key = GlobalKey();
  double? _width;
  int? _current;

  @override
  void initState() {
    _current = widget.current;
    WidgetsBinding.instance!.addPostFrameCallback(_onLayoutDone);
    super.initState();
  }

  _onLayoutDone(_) {
    RenderBox badge = _key.currentContext!.findRenderObject() as RenderBox;
    double badgeWidth = badge.size.width;
    setState(() {
      _width = badgeWidth / pageLength!;
    });
  }

  Widget buildItem(int index) {
    bool isFirstButton = index == 0;
    bool isLastButton = index == pagesLength! + 1;
    String text = isFirstButton
        ? widget.prevText
        : isLastButton
            ? widget.nextText
            : "$index";
    bool isActive = index == _current;
    bool disabled = (isFirstButton && _current == 1) ||
        (isLastButton && _current == pagesLength);
    bool isSimple = widget.mode == 'simple';
    //TODO:点击反馈
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: isActive ? yellowPrimary : whitePrimary,
                width: Style.borderWidthBase),
            left: BorderSide(
                color: isActive ? yellowPrimary : whitePrimary,
                width: (isFirstButton || isLastButton && isSimple)
                    ? Style.borderWidthBase
                    : Style.borderWidthHair),
            right: BorderSide(
                color: isActive ? yellowPrimary : whitePrimary,
                width: (isLastButton || isFirstButton && isSimple)
                    ? Style.borderWidthBase
                    : Style.borderWidthHair),
            bottom: BorderSide(
                color: isActive ? yellowPrimary : whitePrimary,
                width: Style.borderWidthBase),
          ),
          color: isActive ? yellowPrimary : whitePrimary),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          focusColor: disabled ? whitePrimary : Theme.of(context).focusColor,
          highlightColor:
              disabled ? whitePrimary : Theme.of(context).highlightColor,
          hoverColor: disabled ? whitePrimary : Theme.of(context).hoverColor,
          splashColor: disabled ? whitePrimary : Theme.of(context).splashColor,
          child: Opacity(
            opacity: disabled ? Style.paginationDisabledOpacity : 1,
            child: Container(
              alignment: Alignment.center,
              height: Style.paginationHeight,
              padding: EdgeInsets.symmetric(
                  horizontal: (isFirstButton || isLastButton)
                      ? Style.paginationButtonPadding
                      : Style.paginationItemPadding),
              child: Text(text,
                  style: TextStyle(
                      fontSize: Style.paginationFontSize,
                      color: isActive
                          ? Style.paginationActiveItemColor
                          : blackPrimaryFont)),
            ),
          ),
          onTap: () {
            if (disabled) return;
            if (isFirstButton) {
              setState(() {
                _current = (_current ?? 1) - 1;
              });
            } else if (isLastButton) {
              setState(() {
                _current = (_current ?? 1) + 1;
              });
            } else {
              setState(() {
                _current = index;
              });
            }
            if (widget.onChange != null) widget.onChange!(_current);
          },
          // ),
        ),
      ),
    );
  }

  Widget buildPages() {
    return Container(
        key: _key,
        child: Expanded(
            child: widget.mode == 'simple'
                ? Container(
                    alignment: Alignment.center,
                    child: Text("$_current/$pagesLength",
                        style: TextStyle(
                            fontSize: Style.paginationFontSize,
                            color: Style.paginationDescColor)),
                  )
                : Row(
                    children: List.generate(pageLength!, (i) {
                      return Container(
                        width: _width,
                        child: buildItem(i + 1),
                      );
                    }),
                  )));
  }

  @override
  Widget build(BuildContext context) {
    pagesLength = widget.totalItems ~/ widget.itemsPerPage;
    pagesLength = (widget.totalItems % widget.itemsPerPage) > 0
        ? pagesLength! + 1
        : pagesLength;
    pagesLength = pagesLength == 0 ? 1 : pagesLength;
    pageLength =
        pagesLength! > widget.showPageSize ? widget.showPageSize : pagesLength;
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildItem(0),
          buildPages(),
          buildItem(pagesLength! + 1)
        ],
      ),
    );
  }
}
