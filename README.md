# flutter_demo
flutter 学习德莫

控制背景
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
