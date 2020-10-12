import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class TextInputPage extends StatelessWidget {
  static final _bodyKey = GlobalKey<_BodyState>();

  final String title;
  final String initialValue;
  final String hintText;
  final int maxLength;
  final int maxLines;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final void Function({String value, Function() onSuccess, Function() onFailed})
      onSubmit;

  TextInputPage({
    this.title = '',
    this.initialValue = '',
    this.hintText = '',
    this.maxLength,
    this.maxLines = 1,
    this.obscureText = false,
    this.validator,
    @required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          FlatButton(
            onPressed: () => _bodyKey.currentState._submit(),
            child: Text(
              '完成',
              style: Theme.of(context).primaryTextTheme.subhead,
            ),
          ),
        ],
      ),
      body: _Body(
        key: _bodyKey,
        initialValue: initialValue,
        hintText: hintText,
        maxLength: maxLength,
        maxLines: maxLines,
        obscureText: obscureText,
        validator: validator,
        onSubmit: onSubmit,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final String initialValue;
  final String hintText;
  final int maxLength;
  final int maxLines;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final void Function({String value, Function() onSuccess, Function() onFailed})
      onSubmit;

  _Body({
    Key key,
    this.initialValue,
    this.hintText,
    this.maxLength,
    this.maxLines,
    this.obscureText,
    this.validator,
    @required this.onSubmit,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  static final _formKey = GlobalKey<FormState>();

  TextEditingController _textEditingController;
  String _value;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.onSubmit(
          value: _value,
          onSuccess: () {
            Navigator.of(context).pop();
          },
          onFailed: () {
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.cyanAccent,
              content: Text('提交失败'),
              duration: Duration(seconds: 1),
            ));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _textEditingController,
                    autofocus: true,
                    maxLength: widget.maxLength,
                    maxLengthEnforced: true,
                    maxLines: widget.maxLines,
                    obscureText: widget.obscureText,
                    validator: widget.validator,
                    onSaved: (value) => _value = value,
                    onFieldSubmitted: (value) => _submit(),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      suffixIcon: IconButton(
                        onPressed: () => _textEditingController.clear(),
                        icon: Icon(Icons.clear),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
