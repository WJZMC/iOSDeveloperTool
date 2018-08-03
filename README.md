-   [简介](#简介)
-   [常用第三方工具库](#常用第三方工具库)
-   [常见分类、自定义工具类](#常见分类自定义工具类)
-   [开发过程中的常见问题及解决方法](#开发过程中的常见问题及解决方法)
    -   [1、tableview性能优化](#tableview性能优化)
        -   [出现问题的原因：](#出现问题的原因)
        -   [优化目的：](#优化目的)
        -   [检测工具：](#检测工具)
    -   [2、property 、weak，asign ，strong ，copy
        等用法区别、以及强引用弱引用循环引用等所有相关](#property-weakasign-strong-copy-等用法区别以及强引用弱引用循环引用等所有相关)
    -   [3、内存管理机制](#内存管理机制)
    -   [4、深拷贝浅拷贝应用](#深拷贝浅拷贝应用)
        -   [概念](#概念)
        -   [用法](#用法)
        -   [property中的copy属性](#property中的copy属性)
    -   [5、kvo防止重复添加](#kvo防止重复添加)
    -   [6、runtime，run
        loop多线程相关问题高级用法](#runtimerun-loop多线程相关问题高级用法)
        -   [RunLoop:](#runloop)
        -   [runtime](#runtime)
    -   [7、存储模式，各种目录用法](#存储模式各种目录用法)
    -   [8、sdwebimage 实现流程](#sdwebimage-实现流程)
    -   [9、https、 http、 tcp、udp 、socket
        等应用](#https-http-tcpudp-socket-等应用)
        -   [前言](#前言)
        -   [TCP、UDP、HTTP、Socket](#tcpudphttpsocket)
        -   [HTTP 、HTTPS](#http-https)
        -   [Socket 、WebSocket](#socket-websocket)
        -   [TCP 、UDP](#tcp-udp)
    -   [10、sdk开发规范、设计注意](#sdk开发规范设计注意)
        -   [1、Sdk架构设计-模块化、组件化、插件化](#sdk架构设计-模块化组件化插件化)
        -   [2、Sdk接口Api设计统一、简单](#sdk接口api设计统一简单)
        -   [3、Sdk资源内容组成设计-接入和维护更新便利性](#sdk资源内容组成设计-接入和维护更新便利性)
        -   [4、Sdk接口回调设计](#sdk接口回调设计)
        -   [5、Sdk日志设计](#sdk日志设计)
        -   [6、Sdk运行稳定性捕获自身异常](#sdk运行稳定性捕获自身异常)
        -   [7、Sdk自身内容安全性](#sdk自身内容安全性)
        -   [8、Sdk性能高效](#sdk性能高效)
        -   [9、细节事项](#细节事项)
    -   [11、七大查找算法](#七大查找算法)
        -   [前言](#前言-1)
        -   [1. 顺序查找](#顺序查找)
        -   [2. 二分查找](#二分查找)
        -   [3. 插值查找](#插值查找)
        -   [4. 斐波那契查找](#斐波那契查找)
        -   [5. 树表查找](#树表查找)
        -   [6. 分块查找](#分块查找)
        -   [7. 哈希查找](#哈希查找)

简介
====

这个项目是对iOS开发的总结，项目中列出了项目必备工具的集合，包含：请求的封装、加密、错误处理、逻辑解耦、业务拆分、数据解析、以及一些常用工具类的封装和一些开发过程中常见问题的解决方案

常用第三方工具库
================

    pod 'AFNetworking'
    pod 'PPNetworkHelper',:git => 'https://github.com/jkpang/PPNetworkHelper.git'
    pod 'SDWebImage'
    pod 'MJRefresh'
    pod 'SVProgressHUD'
    pod 'TPKeyboardAvoiding'
    pod 'MJExtension'
    pod 'HMSegmentedControl'
    pod 'MBProgressHUD'
    pod 'STPickerView'
    pod 'SDCycleScrollView'
    pod 'ZYCornerRadius', '~> 1.0.2'
    pod 'UITableView+FDTemplateLayoutCell'
    pod 'Masonry'
    pod 'RSKImageCropper'
    pod 'TZImagePickerController'
    pod 'FMDB'
    pod 'PleaseBaoMe'
    pod 'ZFPlayer'
    pod 'ZFDownload'
    pod 'YYModel' # — 高性能的 iOS JSON 模型框架。https://github.com/ibireme/YYImage
    pod 'YYCache' # — 高性能的 iOS 缓存框架。https://github.com/ibireme/YYCache
    pod 'YYImage' # — 功能强大的 iOS 图像框架。https://github.com/ibireme/YYImage
    pod 'YYWebImage' # — 高性能的 iOS 异步图像加载框架。https://github.com/ibireme/YYWebImage
    pod 'YYText' # — 功能强大的 iOS 富文本框架。https://github.com/ibireme/YYText
    pod 'YYKeyboardManager' # — iOS 键盘监听管理工具。https://github.com/ibireme/YYKeyboardManager
    pod 'YYDispatchQueuePool' # — iOS 全局并发队列管理工具。https://github.com/ibireme/YYDispatchQueuePool
    pod 'YYAsyncLayer' # — iOS 异步绘制与显示的工具。https://github.com/ibireme/YYAsyncLayer
    pod 'YYCategories' # — 功能丰富的 Category 类型工具库。https://github.com/ibireme/YYCategories

常见分类、自定义工具类
======================

> tool目录 \>文件管理： 文件操作

> > 项目工具类：项目级应用类

> > categary
> > \>uikit：UIButton、UIview、UIimage、barbutton、label、color等扩展

> > > nsobject：array、objectRuntime、string等扩展

> > Thirds：键盘、输入框、表刷新、轮播图、环形动画、新闻首页二级联动、照片选择器、弹出框、网页加载等

开发过程中的常见问题及解决方法
==============================

1、tableview性能优化
--------------------

### 出现问题的原因：

1、频繁创建控件\
2、cell结构复杂，过多使用AutoLayout，大量布局运算使CPU过载\
3、
控件大量重叠并且大量透明通道、圆角、阴影、遮罩，clip或mask会导致offscreen
rendering 使GPU过载

     引发离屏渲染的用法：
        为图层设置遮罩（layer.mask）
        将图层的layer.masksToBounds / view.clipsToBounds属性设置为true
        将图层layer.allowsGroupOpacity属性设置为YES和layer.opacity小于1.0
        为图层设置阴影（layer.shadow *）。
        为图层设置layer.shouldRasterize=true
        具有layer.cornerRadius，layer.edgeAntialiasingMask，layer.allowsEdgeAntialiasing的图层
        文本（任何种类，包括UILabel，CATextLayer，Core Text等）。
        使用CGContext在drawRect :方法中绘制大部分情况下会导致离屏渲染，甚至仅仅是一个空的实现

### 优化目的：

平衡CPU和GPU的压力 \#\#\# 解决方法：\
1、运用cell重用机制\
2、减少AutoLayout使用，在model中提前计算好布局，避免加载过程中计算\
3、在视图复杂的cell中，重载drawRect:方法，直接在主线程中绘制视图，来将部分GPU的压力转给CPU\
4、减少offscreen rendering相关操作的使用

    1、圆角优化
     UIBezierPath和Core Graphics或者CAShapeLayer配合来做等操作 
     
     CAShapeLayer继承于CALayer,可以使用CALayer的所有属性值；  
     CAShapeLayer需要贝塞尔曲线配合使用才有意义（也就是说才有效果）  
     使用CAShapeLayer(属于CoreAnimation)与贝塞尔曲线可以实现不在view的        drawRect（继承于CoreGraphics走的是CPU,消耗的性能较大）方法中画出一些想要的图形   
     CAShapeLayer动画渲染直接提交到手机的GPU当中，相较于view的drawRect方法使用CPU渲染而言，其效率极高，能大大优化内存使用情况。
                 
     总的来说就是用CAShapeLayer的内存消耗少，渲染速度快，建议使用
    2、其他优化
                   
     当我们需要圆角效果时，可以使用一张中间透明图片蒙上去
     使用ShadowPath指定layer阴影效果路径
     使用异步进行layer渲染（Facebook开源的异步绘制框架AsyncDisplayKit）
     设置layer的opaque值为YES，减少复杂图层合成
     尽量使用不包含透明（alpha）通道的图片资源
     尽量设置layer的大小值为整形值
     直接让美工把图片切成圆角进行显示，这是效率最高的一种方案
     很多情况下用户上传图片进行显示，可以让服务端处理圆角
     使用代码手动生成圆角Image设置到要显示的View上，利用UIBezierPath（CoreGraphics框架）画出来圆角图片
      

### 检测工具：

Core Animation检测离屏渲染 Core Animation每个选项的功能：\
***Color Blended
Layers***：这个选项如果勾选，你能看到哪个layer是透明的，GPU正在做混合计算。显示红色的就是透明的，绿色就是不透明的。

***Color Hits Green and Misses
Red***：如果勾选这个选项，且当我们代码中有设置shouldRasterize为YES，那么红色代表没有复用离屏渲染的缓存，绿色则表示复用了缓存。我们当然希望能够复用。

***Color Copied
Images***：按照官方的说法，当图片的颜色格式GPU不支持的时候，Core
Animation会
拷贝一份数据让CPU进行转化。例如从网络上下载了TIFF格式的图片，则需要CPU进行转化，这个区域会显示成蓝色。还有一种情况会触发Core
Animation的copy方法，就是字节不对齐的时候。

***Color Immediately***：默认情况下Core
Animation工具以每毫秒10次的频率更新图层调试颜色，如果勾选这个选项则移除10ms的延迟。对某些情况需要这样，但是有可能影响正常帧数的测试。

***Color Misaligned
Images***：勾选此项，如果图片需要缩放则标记为黄色，如果没有像素对齐则标记为紫色。像素对齐我们已经在上面有所介绍。

***Color Offscreen-Rendered
Yellow***：用来检测离屏渲染的，如果显示黄色，表示有离屏渲染。当然还要结合Color
Hits Green and Misses Red来看，是否复用了缓存。

***Color OpenGL Fast Path
Blue***：这个选项对那些使用OpenGL的图层才有用，像是GLKView或者
CAEAGLLayer，如果不显示蓝色则表示使用了CPU渲染，绘制在了屏幕外，显示蓝色表示正常。

***Flash Updated
Regions***：当对图层重绘的时候回显示黄色，如果频繁发生则会影响性能。可以用增加缓存来增强性能。

2、property 、weak，asign ，strong ，copy 等用法区别、以及强引用弱引用循环引用等所有相关
----------------------------------------------------------------------------------------

***@property = ivar + getter + setter;***

***assign***：用于对基本数据类型进行赋值操作，不更改引用计数。也可以用来修饰对象，但是，被assign修饰的对象在释放后，指针的地址还是存在的，也就是说指针并没有被置为nil，成为野指针。如果后续在分配对象到堆上的某块内存时，正好分到这块地址，程序就会crash。之所以可以修饰基本数据类型，因为基本数据类型一般分配在栈上，栈的内存会由系统自动处理，不会造成野指针。

     栈：由操作系统自动分配释放 ，存放函数的参数值，局部变量的值等。其操作方式类似于数据结构中的栈。
     堆： 一般由程序员分配释放， 若程序员不释放，程序结束时可能由OS回收，分配方式倒是类似于链表。

***weak***：修饰Object类型，修饰的对象在释放后，指针地址会被置为nil，是一种弱引用。在ARC环境下，为避免循环引用，往往会把delegate属性用weak修饰；在MRC下使用assign修饰。weak和strong不同的是：当一个对象不再有strong类型的指针指向它的时候，它就会被释放，即使还有weak型指针指向它，那么这些weak型指针也将被清除。

***retain*** ARC下的strong等同于MRC下的retain都会把对象引用计数加1。

***copy***：会在内存里拷贝一份对象，两个指针指向不同的内存地址。一般用来修饰NSString等有对应可变类型的对象，因为他们有可能和对应的可变类型（NSMutableString）之间进行赋值操作，为确保对象中的字符串不被修改
，应该在设置属性是拷贝一份。而若用strong修饰，如果对象在外部被修改了，会影响到属性。

block属性为什么需要用copy来修饰？

因为在MRC下，block在创建的时候，它的内存是分配在栈(stack)上的，而不是在堆(heap)上，可能被随时回收。他本身的作于域是属于创建时候的作用域，一旦在创建时候的作用域外面调用block将导致程序崩溃。通过copy可以把block拷贝（copy）到堆，保证block的声明域外使用。在ARC下写不写都行，编译器会自动对block进行copy操作。

***\_ \_ block与\_ \_ weak的区别***

> \_ \_ block：在ARC和MRC下都可用，可修饰对象，也可以修饰基本数据类型。\
> \_ \_ block：对象可以在block被重新赋值，\_ \_ weak不可以。\
> \_ \_
> weak：只在ARC中使用，只能修饰对象，不能修饰基本数据类型（int、bool）。\
> \>同时，在ARC下，要避免block出现循环引用，经常会通过以下两种方法任选一种：\
> \>\>***\_ \_ weak***：\_ \_ weak typedof(self) weakSelf =
> self;实际定义了一个弱引用性质的替身.这个一般在使用block时会用到,因为block会copy它内部的变量,使用\_
> \_ weak性质的self替代self,可以切断block对self的引用.避免循环引用.

    typeof()是根据括号里的变量,自动识别变量类型并返回该类型

> > > ***重写block的set方法，定义弱引用***

        -(void)setBlock:(Block)block                       
        {
           _ _weak Block blockT =addCell;        
           _block = blockT;
        }

***不相互持有的block不需要weak self***

3、内存管理机制
---------------

***iOS内存管理机制***
的原理是引用计数，引用计数简单来说就是统计一块内存的所有权，当这块内存被创建出来的时候，它的引用计数从0增加到1，表示有一个对象或指针持有这块内存，拥有这块内存的所有权，如果这时候有另外一个对象或指针指向这块内存，那么为了表示这个后来的对象或指针对这块内存的所有权，引用计数加1变为2，之后若有一个对象或指针不再指向这块内存时，引用计数减1，表示这个对象或指针不再拥有这块内存的所有权，当一块内存的引用计数变为0，表示没有任何对象或指针持有这块内存，系统便会立刻释放掉这块内存。

其中在开发时引用计数又分为***ARC（自动内存管理）***和***MRC（手动内存管理）***。ARC的本质其实就是MRC，只不过是系统帮助开发者管理已创建的对象或内存空间，自动在系统认为合适的时间和地点释放掉已经失去作用的内存空间，原理是一样的。虽然ARC操作起来很方便，不但减少了代码量，而且降低了内存出错的概率，但因为ARC不一定会及时释放，所以程序有时候可能会占用内存较大。而MRC若做得好，通过手动管理，及时释放掉不需要的内存空间，便可保证程序长时间运行在良好状态上。

在MRC中会引起引用计数变化的关键字有：***alloc，retain，copy，release，autorelease。（strong关键字只用于ARC，作用等同于retain）***

> ***alloc***：当一个类的对象创建，需要开辟内存空间的时候，会使用alloc，alloc是一个类方法，只能用类调用，它的作用是开辟一块新的内存空间，并使这块内存的引用计数从0增加到1，注意，是新的内存空间，每次用类alloc出来的都是一块新的内存空间，与上一次alloc出来的内存空间没有必然联系，而且上一次alloc出来的内存空间仍然存在，不会被释放。

> ***retain***：retain是一个实例方法，只能由对象调用，它的作用是使这个对象的内存空间的引用计数加1，并不会新开辟一块内存空间，通常于赋值是调用.

> > 如： 对象2=\[对象1
> > retain\]；表示对象2同样拥有这块内存的所有权。若只是简单地赋值，如：对象2=对象1；那么当对象1的内存空间被释放的时候，对象2便会成为野指针，再对对象2进行操作便会造成内存错误。

> ***copy***：copy同样是一个实例方法，只能由对象调用，返回一个新的对象，它的作用是复制一个对象到一块新的内存空间上，旧内存空间的引用计数不会变化，新的内存空间的引用计数从0增加到1，也就是说，虽然内容一样，但实质上是两块内存，相当于克隆，一个变成两个。其中copy又分为浅拷贝、深拷贝和真正的深拷贝，浅拷贝只是拷贝地址与retain等同；深拷贝是拷贝内容，会新开辟新内存，与retain不一样；真正的深拷贝是对于容器类来说的，如数组类、字典类和集合类（包括可变和不可变），假设有一个数组类对象，普通的深拷贝会开辟一块新内存存放这个对象，但这个数组对象里面的各个元素的地址却没有改变也就是说数组元素只是进行了retain或者浅拷贝而已，并没有创建新的内存空间，而真正的深拷贝，不但数组对象本身进行了深拷贝，连数组元素都进行了深拷贝，即为各个数组元素开辟了新的内存空间。

> ***release***：release是一个实例方法，同样只能由对象调用，它的作用是使对象的内存空间的引用计数减1，若引用计数变为0则系统会立刻释放掉这块内存。如果引用计数为0的基础上再调用release，便会造成过度释放，使内存崩溃；

> ***autorelease***：autorelease是一个实例方法，同样只能由对象调用，它的作用于release类似，但不是立刻减1，相当于一个延迟的release，通常用于方法返回值的释放，如便利构造器。autorelease会在程序走出自动释放池时执行，通常系统会自动生成自动释放池（即使是MRC下），也可以自己设定自动释放池.

      @autoreleasepool{
            obj= [[NSObject alloc]init];
            [obj autorelease];
      }
      当程序走出 } 时obj的引用计数就会减1.     

> 除了以上所述的关键字，还有一些方法会引起引用计数的变化，如UI中父视图添加、移除子视图，导航控制器或视图控制器推出新的视图控制器以及返回，容器类（数组、字典和集合）添加和移除元素。

> > 当子视图添加到父视图上时，子视图的引用计数加1，移除时引用计数减1，若父视图引用计数变为0内存被释放，其所有的子视图都会被release一次，即引用计数减1，原则上只有这三种情况子视图的引用计数会发生变化，其他如父视图引用计数的加减都不会影响到子视图。

> > 容器类的情况与视图类似，添加元素，该元素引用计数加1，移除元素，该元素引用计数减1，容器引用计数变为0所占用内存被释放，容器所有元素release，引用计数减1，其他情况下容器本身的引用计数变化不会影响到容器内元素的引用计数变化。

> > > 如：导航控制器或视图控制器推出新的视图控制器会使被推出的视图控制器的引用计数加1，该视图控制器返回的时候引用计数减1

***应注意***：当一个对象的引用计数变为0占用内存被释放时，会调用-
(void)dealloc方法，所以如果在MRC下自定义类，必须在该方法里将该类中属性关键字设置为retain或copy的属性release一次，以免造成内存泄露，重写方法不要忘记在第一行添加\[super
dealloc\]；ARC不需要\[super dealloc\]。

4、深拷贝浅拷贝应用
-------------------

### 概念

***浅拷贝*** 拷贝出来一个指向同一个内存地址的指针

***深拷贝***
内容拷贝，创造新的指针指向**存放拷贝之前内容**的新的内存地址

### 用法

***copy*** 拷贝出来的对象类型总是不可变类型(例如, NSString,
NSDictionary, NSArray等等)

***mutableCopy*** 拷贝出来的对象类型总是可变类型(例如, NSMutableString,
NSMutableDictionary, NSMutableArray等等)

***在非集合类对象中***：对 immutable 对象进行 copy
操作，是指针复制【浅拷贝】，mutableCopy 操作时内容复制【深拷贝】；对
mutable 对象进行 copy 和 mutableCopy 都是内容复制。

***在集合类对象中***：对 immutable 对象进行 copy，是指针复制【浅拷贝】，
mutableCopy 是内容复制【深拷贝】；对 mutable 对象进行 copy 和
mutableCopy
都是内容复制。但是：集合对象的内容复制仅限于对象本身，对象元素仍然是指针复制

***注意***：ios中并不是所有的对象都支持copy，mutableCopy，遵守NSCopying
协议的类可以发送copy消息，遵守NSMutableCopying
协议的类才可以发送mutableCopy消息。假如发送了一个没有遵守上诉两协议而发送
copy或者
mutableCopy,那么就会发生异常。但是默认的ios类并没有遵守这两个协议。如果想自定义一下copy
那么就必须遵守NSCopying,并且实现 copyWithZone:
方法，如果想自定义一下mutableCopy
那么就必须遵守NSMutableCopying,并且实现 mutableCopyWithZone: 方法。如：

    @interface MyObj : NSObject<NSCopying,NSMutableCopying>
    {
             NSMutableString *name;
             NSString *imutableStr;
             int age;
    }
    @property (nonatomic, retain) NSMutableString *name;
    @property (nonatomic, retain) NSString *imutableStr;
    @property (nonatomic) int age;
    @end
    @implementation MyObj
    @synthesize name;
    @synthesize age;
    @synthesize imutableStr;
    - (id)init
    {
             if (self = [super init])
             {
                       self.name = [[NSMutableString alloc]init];
                       self.imutableStr = [[NSString alloc]init];
                       age = -1;
             }
             return self;
    }
    - (void)dealloc
    {
             [name release];
             [imutableStr release];
             [super dealloc];
    }
    - (id)copyWithZone:(NSZone *)zone
    {
             MyObj *copy = [[[self class] allocWithZone:zone] init];
             copy->name = [name copy];
             copy->imutableStr = [imutableStr copy];
    //       copy->name = [name copyWithZone:zone];;
    //       copy->imutableStr = [name copyWithZone:zone];//
             copy->age = age;
             return copy;
    }
    - (id)mutableCopyWithZone:(NSZone *)zone
    {
             MyObj *copy = NSCopyObject(self, 0, zone);
             copy->name = [self.name mutableCopy];
             copy->age = age;
             return copy;
    }

### property中的copy属性

    @property (copy, nonatomic) NSString *someString;

    - (void)setSomeString:(NSString *)someString
    {
      //没有写copy属性时
      _someString = someString;
      //写了copy属性时
      _someString = [someString copy];
    }

> 因为父类指针可以指向子类对象,使用 copy
> 的目的是为了让本对象的属性不受外界影响,使用 copy
> 无论给我传入是一个可变对象还是不可对象,我本身持有的就是一个不可变的副本.
> 如果我们使用是 strong
> ,那么这个属性就有可能指向一个可变对象,如果这个可变对象在外部被修改了,那么会影响该属性.

    @property (nonatomic ,strong) NSArray *array;
    NSArray *array = @[ @1, @2, @3, @4 ];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:array];
    self.array = mutableArray;
    [mutableArray removeAllObjects];  

    (lldb) po self.array
    <__NSArrayM 0x60800025a9d0>(
    )

5、kvo防止重复添加
------------------

> ***问题***：
> \>有时候我们会忘记添加多次KVO监听或者，不小心删除如果KVO监听，如果添加多次KVO监听这个时候我们就会接受到多次监听。如果删除多次kvo程序就会造成catch

> ***解决方法***：
> \>利用runtime实现方法交换，进行拦截add和remove进行操作。\
> \>

    '#import "NSObject+DSKVO.h"
    '#import <objc/runtime.h>
    @implementation NSObject (DSKVO)
    + (void)load
    {
        [self switchMethod];
    }
    // 交换后的方法
    - (void)removeDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath
    {
     if ([self observerKeyPath:keyPath observer:observer]) {
            [self removeDasen:observer forKeyPath:keyPath];
        }
    }
    // 交换后的方法
    - (void)addDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
    {
      if (![self observerKeyPath:keyPath observer:observer]) {
            [self addDasen:observer forKeyPath:keyPath options:options context:context];
        }
    }
    // 进行检索获取Key
    - (BOOL)observerKeyPath:(NSString *)key observer:(id )observer
    {
        id info = self.observationInfo;
        NSArray *array = [info valueForKey:@"_observances"];
        for (id objc in array) {
            id Properties = [objc valueForKeyPath:@"_property"];
            id newObserver = [objc valueForKeyPath:@"_observer"];    
            NSString *keyPath = [Properties valueForKeyPath:@"_keyPath"];
            if ([key isEqualToString:keyPath] && [newObserver isEqual:observer]) {
                return YES;
            }
        }
        return NO;
    }
    + (void)switchMethod
    {
        SEL removeSel = @selector(removeObserver:forKeyPath:);
        SEL myRemoveSel = @selector(removeDasen:forKeyPath:);
        SEL addSel = @selector(addObserver:forKeyPath:options:context:);
        SEL myaddSel = @selector(addDasen:forKeyPath:options:context:);
        Method systemRemoveMethod = class_getClassMethod([self class],removeSel);
        Method DasenRemoveMethod = class_getClassMethod([self class], myRemoveSel);
        Method systemAddMethod = class_getClassMethod([self class],addSel);
        Method DasenAddMethod = class_getClassMethod([self class], myaddSel);
        method_exchangeImplementations(systemRemoveMethod, DasenRemoveMethod);
        method_exchangeImplementations(systemAddMethod, DasenAddMethod);
    }

6、runtime，run loop多线程相关问题高级用法
------------------------------------------

### RunLoop:

Runloop是事件接收和分发机制的一个实现。

Runloop提供了一种异步执行代码的机制，不能并行执行任务。

在主队列中，Main
RunLoop直接配合任务的执行，负责处理UI事件、定时器以及其他内核相关事件。

***RunLoop的主要目的***：保证程序执行的线程不会被系统终止。

***什么时候使用Runloop ？***
当需要和该线程进行交互的时候才会使用Runloop.\
每一个线程都有其对应的RunLoop，但是默认非主线程的RunLoop是没有运行的，需要为RunLoop添加至少一个事件源，然后去run它。\
\>一般情况下我们是没有必要去启用线程的RunLoop的，除非你在一个单独的线程中需要长久的检测某个事件。\
\>\
\>主线程默认有Runloop。当自己启动一个线程，如果只是用于处理单一的事件，则该线程在执行完之后就退出了。所以当我们需要让该线程监听某项事务时，就得让线程一直不退出，runloop就是这么一个循环，没有事件的时候，一直卡着，有事件来临了，执行其对应的函数。
\>
\>RunLoop,正如其名所示,是线程进入和被线程用来相应事件以及调用事件处理函数的地方.需要在代码中使用控制语句实现RunLoop的循环,也就是说,需要代码提供while或者for循环来驱动RunLoop.

> 在这个循环中,使用一个runLoop对象\[NSRunloop
> currentRunloop\]执行接收消息,调用对应的处理函数.

> Runloop接收两种源事件:input sources和timer sources。

> > input sources 传递异步事件，通常是来自其他线程和不同的程序中的消息；

> > timer sources(定时器) 传递同步事件（重复执行或者在特定时间上触发）。

> > 除了处理input sources，Runloop
> > 也会产生一些关于本身行为的notificaiton。注册成为Runloop的observer，可以接收到这些notification，做一些额外的处理。（使用CoreFoundation来成为runloop的observer）。

***Runloop工作的特点***:
\>当有时间发生时,Runloop会根据具体的事件类型通知应用程序作出响应;

> 当没有事件发生时,Runloop会进入休眠状态,从而达到省电的目的;

> 当事件再次发生时,Runloop会被重新唤醒,处理事件.

***提示***:一般在开发中很少会主动创建Runloop,而通常会把事件添加到Runloop中.

### runtime

#### 概念

> Objective-C语言是一门动态语言，它将很多静态语言在编译和链接时期做的事放到了运行时来处理。这种动态语言的优势在于：我们写代码时更具灵活性，如我们可以把消息转发给我们想要的对象，或者随意交换一个方法的实现等。
>
> 这种特性意味着Objective-C不仅需要一个编译器，还需要一个运行时系统来执行编译的代码。对于Objective-C来说，这个运行时系统就像一个操作系统一样：它让所有的工作可以正常的运行。这个运行时系统即***Objc
> Runtime***。Objc
> Runtime其实是一个Runtime库，它基本上是用C和汇编写的，这个库使得C语言有了面向对象的能力。
>
> 对于C语言，函数的调用在编译的时候会决定调用哪个函数。对于OC的函数，属于动态调用过程，在编译的时候并不能决定真正调用哪个函数，只有在真正运行的时候才会根据函数的名称找到对应的函数来调用。
> 在编译阶段，OC可以调用任何函数，即使这个函数并未实现，只要声明过就不会报错。
> 在编译阶段，C语言调用未实现的函数就会报错。

#### 作用

> 能获得某个类的所有成员变量\
> 能获得某个类的所有属性\
> 能获得某个类的所有方法\
> 交换方法实现\
> 能动态添加一个成员变量\
> 能动态添加一个属性\
> 字典转模型\
> runtime归档/反归档

    #import<objc/runtime.h> : //成员变量,类,方法
    class_copyIvarList : 获得某个类内部的所有成员变量
    class_copyMethodList : 获得某个类内部的所有方法
    class_getInstanceMethod : 获得某个具体的实例方法 (对象方法,减号-开头)
    class_getClassMethod : 获得某个具体的类方法 (加号+开头)
    method_exchangeImplementations : 交换两个方法的实现
    class_addMethod :动态添加方法
    objc_getAssociatedObject 动态添加属性
    #import<objc/message.h> : //消息机制
    objc_msgSend(...)       

7、存储模式，各种目录用法
-------------------------

应用沙盒一般包括以下几个文件目录：***应用程序包、Document、Library(下面有Caches和Preferences
)、tmp文件***

***应用程序包***：包含所有的资源文件和可执行文件

***Document***：保存应用运行时生成的需要持久化的数据，iTunes会自动备份该目录，苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录。

***tmp***：保存应用运行时所需的临时数据，使用完毕后再将相应的文件从该目录删除。应用没有运行时，系统也有可能会清除该目录下的文件，iTunes不会同步该目录，iPhone重启时，该目录下的文件会丢失。

***Library***：存储程序的默认设置和其他状态信息，iTunes会自动备份该目录。

> ***Library/Caches***：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除。一般存放体积比较大，不是特别重要的资源。

> ***Library/Preferences***：保存应用的所有偏好设置，iOS的Settings（设置）应用会在该目录中查找应用的设置信息，iTunes会自动备份该目录。

8、sdwebimage 实现流程
----------------------

> 采用二级缓存: \>1.在显示图片之前,先检查内存缓存中时候有该图片\
> \>2.如果内存缓存中有图片,那么就直接使用,不下载\
> \>3.如果内存缓存中无图片,那么再检查是否有磁盘缓存\
> \>4.如果磁盘缓存中有图片,那么直接使用,还需要保存一份到内存缓存中(方便下一次使用)\
> \>5.如果磁盘缓存中无图片,那么再去下载,并且把下载完的图片保存到内存缓存和磁盘缓存

9、https、 http、 tcp、udp 、socket 等应用
------------------------------------------

### 前言

***OSI（Open System Interconnection）参考模型***
上面4层（应用层、表示层、会话层、传输层）为高层，定义了程序的功能；下面3层（网络层、数据链路层、物理层）为低层，主要是处理面向网络的端到端数据流。
\>***应用层***
是最靠近用户的OSI层。这一层为用户的应用程序（例如电子邮件、文件传输和终端仿真）提供网络服务。。
协议有：HTTP FTP TFTP SMTP SNMP DNS TELNET HTTPS POP3 DHCP等。
常见：Telnet、FTP、HTTP、SNMP、DNS等

> ***表示层***
> 数据的表示、安全、压缩。可确保一个系统的应用层所发送的信息可以被另一个系统的应用层读取。
> 格式有：JPEG、ASCll、DECOIC、加密格式等。
> 常见：URL加密、口令加密、图片编码解码

> ***会话层***
> 建立、管理、终止会话，对应主机进程，指本地主机与远程主机正在进行的会话。
> 通过传输层（端口号：传输端口与接收端口）建立数据传输的通路。主要在你的系统之间发起会话或者接受会话请求（设备之间需要互相认识可以是IP也可以是MAC或者是主机名）。常见：服务器验证登录、断点续传等

> ***传输层*** 定义传输数据的协议端口号，以及流控和差错校验。协议有：TCP
> UDP等，数据包一旦离开网卡即进入网络传输层。常见：TCP、UDP、SPX、进程、端口

> > 定义了一些传输数据的协议和端口号（WWW端口80等），如：TCP（传输控制协议，传输
> > 效率低，可靠性强，用于传输可靠性要求高，数据量大的数据），UDP（用户数据报协议，与TCP特性恰恰相反，用于传输可靠性要求不高，数据量小的数据，如QQ聊天数据就是通过这种方式传输的）。
> > 主要是将从下层接收的数据进行分段和传输，到达目的地址后再进行重组。常常把这一层数据叫做段。

> ***网络层*** 进行逻辑地址寻址，实现不同网络之间的路径选择。
> 协议有：ICMP IGMP IP（IPV4 IPV6） ARP
> RARP等。常见：路由器、多层交换机、防火墙、IP、IPX、RIP、OSPF等
> \>在位于不同地理位置的网络中的两个主机系统之间提供连接和路径选择。Internet的发展使得从世界各站点访问信息的用户数大大增加，而网络层正是管理这种连接的层。

> ***数据链路层***
> 建立逻辑连接、进行硬件地址寻址、差错校验等功能。（由底层网络定义协议）
> 将比特组合成字节进而组合成帧，用MAC地址访问介质，错误发现但不能纠正。数据链路层协议的代表包括：SDLC、HDLC、PPP、STP、帧中继等。常见：网卡、网桥、二层交换机等

> ***物理层***
> 建立、维护、断开物理连接。（由底层网络定义协议）。常见：中继器、集线器、网线、HUB等

![avatar](./OSI.jpg)

### TCP、UDP、HTTP、Socket

***IP*** 网络层协议；（高速公路）

***TCP、UDP*** 传输层协议；（卡车）

***HTTP***
应用层协议；（货物）。HTTP(超文本传输协议)是利用TCP在两台电脑(通常是Web服务器和客户端)之间传输信息的协议。客户端使用Web浏览器发起HTTP请求给Web服务器，Web服务器发送被请求的信息给客户端。

***TCP/IP*** 代表传输控制协议/网际协议，指的是一系列协议，TCP/IP 模型在
OSI
模型的基础上进行了简化，变成了四层，从下到上分别为：链路层、网络层、传输层、应用层。
\>![avatar](./TCP_IP.jpg)

***Socket***
套接字，TCP/IP网络的API。(港口码头/车站)Socket是应用层与TCP/IP协议族通信的中间软件抽象层，它是一组接口。socket是在应用层和传输层之间的一个抽象层，它把TCP/IP层复杂的操作抽象为几个简单的接口供应用层调用已实现进程在网络中通信。

### HTTP 、HTTPS

***HTTP***
是互联网上应用最为广泛的一种网络协议，是一个客户端和服务器端请求和应答的标准（TCP），用于从WWW服务器传输超文本到本地浏览器的传输协议，它可以使浏览器更加高效，使网络传输减少。

***HTTPS***
是以安全为目标的HTTP通道，简单讲是HTTP的安全版，即HTTP下加入SSL层，HTTPS的安全基础是SSL，因此加密的详细内容就需要SSL。\
HTTPS协议的主要作用可以分为两种：一种是建立一个信息安全通道，来保证数据传输的安全；另一种就是确认网站的真实性。

***区别***
\>1、https协议需要到ca申请证书，一般免费证书较少，因而需要一定费用。

> 2、http是超文本传输协议，信息是明文传输，https则是具有安全性的ssl加密传输协议。

> 3、http和https使用的是完全不同的连接方式，用的端口也不一样，前者是80，后者是443。

> 4、http的连接很简单，是无状态的；HTTPS协议是由SSL+HTTP协议构建的可进行加密传输、身份认证的网络协议，比http协议安全。

### Socket 、WebSocket

***WebSocket*** Websocket协议解决了服务器与客户端全双工通信的问题。
\>注:什么是单工、半双工、全工通信？\
\>信息只能单向传送为单工；\
\>信息能双向传送但不能同时双向传送称为半双工；\
\>信息能够同时双向传送则称为全双工。\
\>websocket协议解析
\>wensocket协议包含两部分:一部分是"握手"，一部分是"数据传输"。

***Socket和WebSocket区别***\
\>1、可以把WebSocket想象成HTTP(应用层)，HTTP和Socket什么关系，WebSocket和Socket就是什么关系。\
\>2、HTTP
协议有一个缺陷：通信只能由客户端发起，做不到服务器主动向客户端推送信息。\
\>3、WebSocket
协议在2008年诞生，2011年成为国际标准。所有浏览器都已经支持了。
它的最大特点就是，服务器可以主动向客户端推送信息，客户端也可以主动向服务器发送信息，是真正的双向平等对话，属于服务器推送技术的一种。

### TCP 、UDP

***TCP*** （传输控制协议，Transmission Control Protocol）：(类似打电话)
面向连接、传输可靠（保证数据正确性）、有序（保证数据顺序）、传输大量数据（流模式）、速度慢、对系统资源的要求多，程序结构较复杂，
每一条TCP连接只能是点到点的， TCP首部开销20字节。
\>![avatar](./tcp_hand.png)
\>第一次握手：客户端发送syn包(seq=x)到服务器，并进入SYN\_SEND状态，等待服务器确认；\
\>第二次握手：服务器收到syn包，必须确认客户的SYN（ack=x+1），同时自己也发送一个SYN包（seq=y），即SYN+ACK包，此时服务器进入SYN\_RECV状态；\
\>第三次握手：客户端收到服务器的SYN＋ACK包，向服务器发送确认包ACK(ack=y+1)，此包发送完毕，客户端和服务器进入ESTABLISHED状态，完成三次握手。\
\>握手过程中传送的包里不包含数据，三次握手完毕后，客户端与服务器才正式开始传送数据。理想状态下，TCP连接一旦建立，在通信双方中的任何一方主动关闭连接之前，TCP
连接都将被一直保持下去。

***UDP*** (用户数据报协议，User Data Protocol)：（类似发短信）
面向非连接
、传输不可靠（可能丢包）、无序、传输少量数据（数据报模式）、速度快，对系统资源的要求少，程序结构较简单
， UDP支持一对一，一对多，多对一和多对多的交互通信，
UDP的首部开销小，只有8个字节。

***区别***

> 1、TCP面向连接（如打电话要先拨号建立连接）;UDP是无连接的，即发送数据之前不需要建立连接
> 2、TCP提供可靠的服务。也就是说，通过TCP连接传送的数据，无差错，不丢失，不重复，且按序到达;UDP尽最大努力交付，即不保证可靠交付,Tcp通过校验和，重传控制，序号标识，滑动窗口、确认应答实现可靠传输。如丢包时的重发控制，还可以对次序乱掉的分包进行顺序控制。

> 3、UDP具有较好的实时性，工作效率比TCP高，适用于对高速传输和实时性有较高的通信或广播通信。

> 4.每一条TCP连接只能是点到点的;UDP支持一对一，一对多，多对一和多对多的交互通信

> 5、TCP对系统资源要求较多，UDP对系统资源要求较少。

> > 为什么UDP有时比TCP更有优势?

> > > UDP以其简单、传输快的优势，在越来越多场景下取代了TCP,如实时游戏。

> > > > （1）网速的提升给UDP的稳定性提供可靠网络保障，丢包率很低，如果使用应用层重传，能够确保传输的可靠性。

> > > > （2）TCP为了实现网络通信的可靠性，使用了复杂的拥塞控制算法，建立了繁琐的握手过程，由于TCP内置的系统协议栈中，极难对其进行改进。

> > > > 采用TCP，一旦发生丢包，TCP会将后续的包缓存起来，等前面的包重传并接收到后再继续发送，延时会越来越大，基于UDP对实时性要求较为严格的情况下，采用自定义重传机制，能够把丢包产生的延迟降到最低，尽量减少网络问题对游戏性造成影响。

10、sdk开发规范、设计注意
-------------------------

### 1、Sdk架构设计-模块化、组件化、插件化

> 层次分清，避免代码臃肿，提高代码阅读性以及单元测试。顾及到各自的项目大小，可以先从抽离、独立各个业务层做起，尽量分清层次，来提高项目层次感，降低维护难度。

### 2、Sdk接口Api设计统一、简单

> 有统一接口设计避免使用继承方式来调用sdk的api，Api接口设计简单方便使用，命名让使用者一目了然。

> 参数设计要利于扩展，避免sdk升级时发生找不到方法的异常。

> 在需要调整SDK
> API时,优先选择添加新方法,而不是在原方法上修改.对于实现相同功能的新方法,尽可能的要兼容原始方法，这样避免升级时找到不方法或者使用者更新时候避免重新改写接口；

> 在需要废除某些方法时,需要在正式版发版前使用\@deprecated标识,并给出替代方案和废弃的时间(通常是SDK版本号)

> 迭代时接口不统一，往往是因为参数变化而需要拓展，当然还有需要新功能的时候，对应参数设计觉得很有必要统一起来，如用Map封装参数，就很容易扩展参数，需要什么就直接包装进来，而不用修改接口的参数列表，在调用的时候也方便统一管理。

### 3、Sdk资源内容组成设计-接入和维护更新便利性

> 设计sdk资源的命名规范

> 通过版本和资源包来管理资源

### 4、Sdk接口回调设计

> 要对任何情况下考虑到有回调响应，避免出现使用者调用之后阻塞没有反应情况，例如网络异常，超时处理，调用过快，异常等情况下要有回调。

> 同时必须提供明确的错误信息回馈给使用者，方便接入者自己就能解决接入中问题，而不是什么问题都需要开发者亲身去维护，回调错误中采用errorCode+errorMsg组合.

> 最好不宜使用通过调试日志形式显示错误信息，这样一旦忘记关了调试模式，泄漏了信息就止这样。

### 5、Sdk日志设计

> 日志：用户行为日志（埋点）、调试日志、运行异常日志

> 用户行为日志（埋点）\
> 作为开发者都希望了解自己的sdk使用中表现，运营都希望得到业务相关数据，这时开发一套完整数据统计就很必要，包括sdk运行稳定性，兼容性数据，异常数据，同时上传用户相关行为数据。做到这些的同时还要注意如下：
> \>1、日志服务能够记录有效的信息,在SDK要关键位置进行打点，避免浪费用户流量，减少上传不必要的数据。
> \>2、日志服务上传日志信息到服务器时,要保证最大的可靠性,不能发生上传失败后抛弃日志的情况，避免数据分析时数据不完整，缺乏可靠性。做到不论当前网络情况如何，都要保证数据完整性上传
> \>3、日志服务不能影响对正常的操作流程有过多的性能影响，SDK产生的日志信息往往是非常多的,因此必须考虑日志IO操作所带来的开销。

> 调试日志设计：在维护中分析问题，经常需要结合日志来分析问题，这时候如果Apk已经发布没有日志、或者如何避免使用者忘记了关掉日志而导致泄漏敏感数据。所以要设计可以不论是否发布状态都能强制打开（强制改成调试状态），发布之后统一关闭日志（服务端控制）

### 6、Sdk运行稳定性捕获自身异常

应该在接口内部进行统一的全局对未捕获异常进行捕获，并上报日志供分析改善Sdk，同时也帮助调试中分析问题

### 7、Sdk自身内容安全性

sdk的安全性用来对抗外界的反编译，保护内容不被窥探 \>Sdk调用入口鉴权\
\>实现方式用云实现 \>代码混淆和资源混淆

### 8、Sdk性能高效

> （1） 减少内存占用\
> 在不使用多进程的情况下,SDK服务和宿主程序运行在同一进程中,这种情况下必须要求限制SDK内存的占用,不能因为说因为我们SDK占用太多的内存资源,导致应用的存活时间变短，但是这种抢资源必然会总宿主内存使用造成影响，从而会影响apk运行性能。

> （2）减少内存抖动\
> 在占用更少内存的前提下,SDK设计者必须刻意的减少造成的内存抖动问题，避免同一时间创建和回收对象，做到正确时刻正确创建对象。

> （3）减少电量消耗\
> 尽管很多时候无法对电量消耗做一个很好的权衡,但是仍然有一些可以参考的做法,比如减少使用耗电模块的时间.比如在使用定位服务时,不要求非常高的精度下优先使用网络定位而不是GPS定位.

> （4）减少流量消耗\
> 这里就是对Sdk内部网络请求尽量规范，充分利用每一次网络请求发起，复用资源，多次发起都会带来消耗。对数据内容不宜原始数据，尽量能够做到压缩上传。同时要减少后台进程频繁唤醒，做到有效控制。

> （5）减少同步阻塞主线程操作\
> 这样提高程序运行效率，避免阻塞主线程，导致app启动变慢或交互响应不及时。尽量提高程序执行效率，使用更高效的方法或api，以及异步初始化.

### 9、细节事项

> 1）Sdk开发生成的体积不要过大，尽量能够压缩库或文件，在加载时候解压出来，避免增加使用者Apk的体积大小。

> 2）Sdk中的方法数不要过大，给Apk带来方法数超限额的问题尽量避免。同时结合运行高效来说以及安全性，过多的方法不安全且增加运行成本，影响应能。

> 3）Sdk接入帮助文档要详细清晰，要做到接入者看文档就可以成功接入，并且有问题可以根据文档接入，而不是总要联系维护人员。

11、七大查找算法
----------------

### 前言

***时间复杂度***
时间复杂度的计算并不是计算程序具体运行的时间，而是算法执行语句的次数。当我们面前有多个算法时，我们可以通过计算时间复杂度，判断出哪一个算法在具体执行时花费时间最多和最少。\
\>计算方法\
\>\>①选取相对增长最高的项\
\>\>②最高项系数是都化为1\
\>\>③若是常数的话用O（1）表示\
\>\>如f（n）=2\*n^3+2n+100则O（n）=n^3。

    常数阶O(1)                                     
    对数阶O(log2 n)            
    线性阶O(n)     
    线性对数阶O(n log2 n)
    平方阶O(n^2)
    立方阶O(n^3) 
    k次方阶O(n^K)
    指数阶O(2^n)

***空间复杂度***
空间复杂度是对一个算法在运行过程中临时占用存储空间大小的量度。\
\>计算方法：\
\>\>①忽略常数，用O(1)表示\
\>\>②递归算法的空间复杂度=递归深度N\*每次递归所要的辅助空间\
\>\>③对于单线程来说，递归有运行时堆栈，求的是递归最深的那一次压栈所耗费的空间的个数，因为递归最深的那一次所耗费的空间足以容纳它所有递归过程。

***查找***
是在大量的信息中寻找一个特定的信息元素，在计算机应用中，查找是常用的基本运算，例如编译程序中符号表的查找。本文简单概括性的介绍了常见的七种查找算法，说是七种，其实二分查找、插值查找以及斐波那契查找都可以归为一类------插值查找。插值查找和斐波那契查找是在二分查找的基础上的优化查找算法。树表查找和哈希查找会在后续的博文中进行详细介绍。

***查找定义***：根据给定的某个值，在查找表中确定一个其关键字等于给定值的数据元素（或记录）。

***查找算法分类***： \>1）静态查找和动态查找；\
　
注：静态或者动态都是针对查找表而言的。动态表指查找表中有删除和插入操作的表。\
\>2）无序查找和有序查找。\
\>\>无序查找：被查找数列有序无序均可；\
\>\>有序查找：被查找数列必须为有序数列。\
\>\>平均查找长度（Average Search
Length，ASL）：需和指定key进行比较的关键字的个数的期望值，称为查找算法在查找成功时的平均查找长度。\
　　对于含有n个数据元素的查找表，查找成功的平均查找长度为：ASL =
Pi\*Ci的和。\
　　Pi：查找表中第i个数据元素的概率。\
　　Ci：找到第i个数据元素时已经比较过的次数。

### 1. 顺序查找

***说明***：顺序查找适合于存储结构为顺序存储或链接存储的线性表。

***基本思想***：顺序查找也称为线形查找，属于无序查找算法。从数据结构线形表的一端开始，顺序扫描，依次将扫描到的结点关键字与给定值k相比较，若相等则表示查找成功；若扫描结束仍没有找到关键字等于k的结点，表示查找失败。

***复杂度分析***：　
查找成功时的平均查找长度为：（假设每个数据元素的概率相等） ASL =
1/n(1+2+3+...+n) = (n+1)/2
;当查找不成功时，需要n+1次比较，时间复杂度为O(n);
所以，顺序查找的时间复杂度为O(n)。

    int SequenceSearch(int a[], int value, int n)
    {
       int i;
       for(i=0; i<n; i++)
           if(a[i]==value)
               return i;
       return -1;
    }

### 2. 二分查找

***说明***：元素必须是有序的，如果是无序的则要先进行排序操作。

***基本思想***：也称为是折半查找，属于有序查找算法。用给定值k先与中间结点的关键字比较，中间结点把线形表分成两个子表，若相等则查找成功；若不相等，再根据k与该中间结点关键字的比较结果确定下一步查找哪个子表，这样递归进行，直到查找到或查找结束发现表中没有这样的结点。

***复杂度分析***：最坏情况下，关键词比较次数为log2(n+1)，且期望时间复杂度为O(log2n)；

***注***：折半查找的前提条件是需要有序表顺序存储，对于静态查找表，一次排序后不再变化，折半查找能得到不错的效率。但对于需要频繁执行插入或删除操作的数据集来说，维护有序的排序会带来不小的工作量，那就不建议使用。

    //二分查找（折半查找），非递归   空间复杂度O（1）
    int BinarySearch1(int a[], int value, int n)
    {
        int low, high, mid;
        low = 0;
        high = n-1;
        while(low<=high)
        {
            mid = (low+high)/2;
            if(a[mid]==value)
                return mid;
            if(a[mid]>value)
                high = mid-1;
            if(a[mid]<value)
                low = mid+1;
        }
        return -1;
    }
    //二分查找递归     空间复杂度O（log2n）
    int BinarySearch2(int a[], int value, int low, int high)
    {
        int mid = low+(high-low)/2;
        if(a[mid]==value)
            return mid;
        if(a[mid]>value)
            return BinarySearch2(a, value, low, mid-1);
        if(a[mid]<value)
            return BinarySearch2(a, value, mid+1, high);
    }

### 3. 插值查找

***引言***\
\>在介绍插值查找之前，首先考虑一个新问题，为什么上述算法一定要是折半，而不是折四分之一或者折更多呢？

> 打个比方，在英文字典里面查"apple"，你下意识翻开字典是翻前面的书页还是后面的书页呢？如果再让你查"zoo"，你又怎么查？很显然，这里你绝对不会是从中间开始查起，而是有一定目的的往前或往后翻。

> 同样的，比如要在取值范围1 \~ 10000 之间 100
> 个元素从小到大均匀分布的数组中查找5，
> 我们自然会考虑从数组下标较小的开始查找。

> 经过以上分析，折半查找这种查找方式，不是自适应的（也就是说是傻瓜式的）。二分查找中查找点计算如下：

> 　　mid=(low+high)/2, 即mid=low+1/2\*(high-low);
>
> 通过类比，我们可以将查找的点改进为如下： 　　\
> 　　mid=low+(key-a\[low\])/(a\[high\]-a\[low\])\*(high-low)，\
> 也就是将上述的比例参数1/2改进为自适应的，根据关键字在整个有序表中所处的位置，让mid值的变化更靠近关键字key，这样也就间接地减少了比较次数。

***基本思想***：基于二分查找算法，将查找点的选择改进为自适应选择，可以提高查找效率。当然，差值查找也属于有序查找。

***注***：对于表长较大，而关键字分布又比较均匀的查找表来说，插值查找算法的平均性能比折半查找要好的多。反之，数组中如果分布非常不均匀，那么插值查找未必是很合适的选择.

***复杂度分析***：查找成功或者失败的时间复杂度均为O(log2(log2n))。

    //插值查找
    int InsertionSearch(int a[], int value, int low, int high)
    {
        int mid = low+(value-a[low])/(a[high]-a[low])*(high-low);
        if(a[mid]==value)
            return mid;
        if(a[mid]>value)
            return InsertionSearch(a, value, low, mid-1);
        if(a[mid]<value)
            return InsertionSearch(a, value, mid+1, high);
    }

### 4. 斐波那契查找

> 在介绍斐波那契查找算法之前，我们先介绍一下很它紧密相连并且大家都熟知的一个概念------黄金分割。

> 黄金比例又称黄金分割，是指事物各部分间一定的数学比例关系，即将整体一分为二，较大部分与较小部分之比等于整体与较大部分之比，其比值约为1:0.618或1.618:1。

> 0.618被公认为最具有审美意义的比例数字，这个数值的作用不仅仅体现在诸如绘画、雕塑、音乐、建筑等艺术领域，而且在管理、工程设计等方面也有着不可忽视的作用。因此被称为黄金分割。

> 大家记不记得斐波那契数列：1, 1, 2, 3, 5, 8, 13, 21, 34, 55,
> 89.......（从第三个数开始，后边每一个数都是前两个数的和）。然后我们会发现，随着斐波那契数列的递增，前后两个数的比值会越来越接近0.618，利用这个特性，我们就可以将黄金比例运用到查找技术中。
> 　　

***基本思想***：也是二分查找的一种提升算法，通过运用黄金比例的概念在数列中选择查找点进行查找，提高查找效率。同样地，斐波那契查找也属于一种有序查找算法。
　　相对于折半查找，一般将待比较的key值与第mid=（low+high）/2位置的元素比较，比较结果分三种情况：
\>1）相等，mid位置的元素即为所求\
\>2）\>，low=mid+1;\
\>3）\<，high=mid-1。

　　斐波那契查找与折半查找很相似，他是根据斐波那契序列的特点对有序表进行分割的。他要求开始表中记录的个数为某个斐波那契数小1，及n=F(k)-1;开始将k值与第F(k-1)位置的记录进行比较(及mid=low+F(k-1)-1),比较结果也分为三种

> 1）相等，mid位置的元素即为所求

> 2）\>，low=mid+1,k-=2;

> > 说明：low=mid+1说明待查找的元素在\[mid+1,high\]范围内，k-=2
> > 说明范围\[mid+1,high\]内的元素个数为n-(F(k-1))=
> > Fk-1-F(k-1)=Fk-F(k-1)-1=F(k-2)-1个，所以可以递归的应用斐波那契查找。

> 3）\<，high=mid-1,k-=1。

> > 说明：low=mid+1说明待查找的元素在\[low,mid-1\]范围内，k-=1
> > 说明范围\[low,mid-1\]内的元素个数为F(k-1)-1个，所以可以递归
> > 的应用斐波那契查找。

***复杂度分析***：最坏情况下，时间复杂度为O(log2n)，且其期望复杂度也为O(log2n)。　

    const int max_size=20;//斐波那契数组的长度

    /*构造一个斐波那契数组*/ 
    void Fibonacci(int * F)
    {
        F[0]=0;
        F[1]=1;
        for(int i=2;i<max_size;++i)
            F[i]=F[i-1]+F[i-2];
    }

    /*定义斐波那契查找法*/  
    int FibonacciSearch(int *a, int n, int key)  //a为要查找的数组,n为要查找的数组长度,key为要查找的关键字
    {
      int low=0;
      int high=n-1;
      
      int F[max_size];
      Fibonacci(F);//构造一个斐波那契数组F 

      int k=0;
      while(n>F[k]-1)//计算n位于斐波那契数列的位置
          ++k;

      int  * temp;//将数组a扩展到F[k]-1的长度
      temp=new int [F[k]-1];
      memcpy(temp,a,n*sizeof(int));

      for(int i=n;i<F[k]-1;++i)
         temp[i]=a[n-1];
      
      while(low<=high)
      {
        int mid=low+F[k-1]-1;
        if(key<temp[mid])
        {
          high=mid-1;
          k-=1;
        }
        else if(key>temp[mid])
        {
         low=mid+1;
         k-=2;
        }
        else
        {
           if(mid<n)
               return mid; //若相等则说明mid即为查找到的位置
           else
               return n-1; //若mid>=n则说明是扩展的数值,返回n-1
        }
      }  
      delete [] temp;
      return -1;
    }

    int main()
    {
        int a[] = {0,16,24,35,47,59,62,73,88,99};
        int key=100;
        int index=FibonacciSearch(a,sizeof(a)/sizeof(int),key);
        cout<<key<<" is located at:"<<index;
        return 0;
    }

### 5. 树表查找

### 6. 分块查找

### 7. 哈希查找
