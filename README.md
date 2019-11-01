### https://book.flutterchina.club/chapter4/alignment.html flutter 中文网
# flutter_demo  
flutter 学习德莫 

控制背景  https://blog.csdn.net/chenlove1/article/details/83627831
```  decoration /同级color 不能共存。
Container(
                height: 100,
                decoration: new BoxDecoration(
                  border: new Border.all(width: 2.0, color: Colors.red),
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                  image: new DecorationImage(
                    image: new NetworkImage(
                        'http://h.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=0d023672312ac65c67506e77cec29e27/9f2f070828381f30dea167bbad014c086e06f06c.jpg'),
                    centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 60),
                child: Row(
```

#### 控件圆角 https://juejin.im/post/5b519fb05188251b1b448ec5

### 裁剪  https://blog.csdn.net/qq_39969226/article/details/100836203
```
自定义裁剪，获取到的坐标是裁剪组建父布局的大小。

class TopPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print(" ---  ${size.width} --- ${size.height}");
    var path = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(100.0, 100.0)
      ..lineTo(200.0, 0.0)
      ..lineTo(0.0, 0.0)
      ..close();
    return path;
  }
```
#### [实现Tab顶部吸附固定效果]https://www.cnblogs.com/qiufang/p/11314473.html

#### https://pub.dev/packages/sticky_headers 类似通讯录首字母 悬停

#### https://github.com/xuelongqy/flutter_easyrefresh 刷新加载框架

```
Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('提交成功...'),
                  ));
```

#### 网络请求 及 数据解析  https://juejin.im/post/5c9f5963e51d451367658f78 
```
Future 未指定返回数据类型时，可以通过 is来判断

 if (smsBean is bool) {

      } else if (smsBean is SmsBean) {

      }
```
#### singlechildScroll 嵌套 listview时，竖向的需要设置设置   shrinkWrap: true,不然会报错
```
Vertical viewport was given unbounded height.

```
横向的需要给listview设置高度。 gridview 同

#### https://www.kikt.top/posts/flutter/dialog/dialog-2/ 带进场动画的dialog

#### textSpan用法 
```
Text.rich(TextSpan(
                children: [
                  TextSpan(
                      text: "1、"
                  ),
                  TextSpan(
                    text: "点击“立即绑定”",
                    style: TextStyle(
                        color: Colors.blue
                    ),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        print("----");
                      }
                    ,
                  ),
                ]
            ))
```



