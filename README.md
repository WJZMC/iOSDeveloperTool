# 简介    

  这个项目是对iOS开发的总结，项目中列出了项目必备工具的集合，包含：请求的封装、加密、错误处理、逻辑解耦、业务拆分、数据解析、以及一些常用工具类的封装和一些开发过程中常见问题的解决方案
  
# 常用第三方工具库     

```
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
pod "Qiniu"
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
```
# 常见分类、自定义工具类   

基本满足开发需求的
>tool目录
>>文件管理： 文件操作

>>项目工具类：项目级应用类

>>categary
>>>uikit：UIButton、UIview、UIimage、barbutton、label、color等扩展

>>>nsobject：array、objectRuntime、string等扩展

>>Thirds：键盘、输入框、表刷新、轮播图、环形动画、新闻首页二级联动、照片选择器、弹出框、网页加载等



# 开发过程中的常见问题及解决方法   

## 1、tableview性能优化     
### 出现问题的原因：   
1、频繁创建控件  
2、cell结构复杂，过多使用AutoLayout，大量布局运算使CPU过载    
3、 控件大量重叠并且大量透明通道、圆角、阴影、遮罩，clip或mask会导致offscreen rendering 使GPU过载

```
 引发离屏渲染的用法：
    为图层设置遮罩（layer.mask）
    将图层的layer.masksToBounds / view.clipsToBounds属性设置为true
    将图层layer.allowsGroupOpacity属性设置为YES和layer.opacity小于1.0
    为图层设置阴影（layer.shadow *）。
    为图层设置layer.shouldRasterize=true
    具有layer.cornerRadius，layer.edgeAntialiasingMask，layer.allowsEdgeAntialiasing的图层
    文本（任何种类，包括UILabel，CATextLayer，Core Text等）。
    使用CGContext在drawRect :方法中绘制大部分情况下会导致离屏渲染，甚至仅仅是一个空的实现
```
                    
### 优化目的：    

   平衡CPU和GPU的压力
### 解决方法：   
   1、运用cell重用机制   
   2、减少AutoLayout使用，在model中提前计算好布局，避免加载过程中计算  
   3、在视图复杂的cell中，重载drawRect:方法，直接在主线程中绘制视图，来将部分GPU的压力转给CPU   
   4、减少offscreen rendering相关操作的使用    
   
   ```
 (1)圆角优化
    UIBezierPath和Core Graphics或者CAShapeLayer配合来做等操作 
    
	CAShapeLayer继承于CALayer,可以使用CALayer的所有属性值；  
	CAShapeLayer需要贝塞尔曲线配合使用才有意义（也就是说才有效果）  
	使用CAShapeLayer(属于CoreAnimation)与贝塞尔曲线可以实现不在view的     	drawRect（继承于CoreGraphics走的是CPU,消耗的性能较大）方法中画出一些想要的图形   
	CAShapeLayer动画渲染直接提交到手机的GPU当中，相较于view的drawRect方法使用CPU渲染而言，其效率极高，能大大优化内存使用情况。
                
	总的来说就是用CAShapeLayer的内存消耗少，渲染速度快，建议使用
（2）其他优化
                  
    当我们需要圆角效果时，可以使用一张中间透明图片蒙上去
    使用ShadowPath指定layer阴影效果路径
    使用异步进行layer渲染（Facebook开源的异步绘制框架AsyncDisplayKit）
    设置layer的opaque值为YES，减少复杂图层合成
    尽量使用不包含透明（alpha）通道的图片资源
    尽量设置layer的大小值为整形值
    直接让美工把图片切成圆角进行显示，这是效率最高的一种方案
    很多情况下用户上传图片进行显示，可以让服务端处理圆角
    使用代码手动生成圆角Image设置到要显示的View上，利用UIBezierPath（CoreGraphics框架）画出来圆角图片
     
   ```
   
### 检测工具：  
Core Animation检测离屏渲染
Core Animation每个选项的功能：   
***Color Blended Layers***：这个选项如果勾选，你能看到哪个layer是透明的，GPU正在做混合计算。显示红色的就是透明的，绿色就是不透明的。

***Color Hits Green and Misses Red***：如果勾选这个选项，且当我们代码中有设置shouldRasterize为YES，那么红色代表没有复用离屏渲染的缓存，绿色则表示复用了缓存。我们当然希望能够复用。

***Color Copied Images***：按照官方的说法，当图片的颜色格式GPU不支持的时候，Core Animation会
拷贝一份数据让CPU进行转化。例如从网络上下载了TIFF格式的图片，则需要CPU进行转化，这个区域会显示成蓝色。还有一种情况会触发Core Animation的copy方法，就是字节不对齐的时候。

***Color Immediately***：默认情况下Core Animation工具以每毫秒10次的频率更新图层调试颜色，如果勾选这个选项则移除10ms的延迟。对某些情况需要这样，但是有可能影响正常帧数的测试。

***Color Misaligned Images***：勾选此项，如果图片需要缩放则标记为黄色，如果没有像素对齐则标记为紫色。像素对齐我们已经在上面有所介绍。

***Color Offscreen-Rendered Yellow***：用来检测离屏渲染的，如果显示黄色，表示有离屏渲染。当然还要结合Color Hits Green and Misses Red来看，是否复用了缓存。

***Color OpenGL Fast Path Blue***：这个选项对那些使用OpenGL的图层才有用，像是GLKView或者 CAEAGLLayer，如果不显示蓝色则表示使用了CPU渲染，绘制在了屏幕外，显示蓝色表示正常。

***Flash Updated Regions***：当对图层重绘的时候回显示黄色，如果频繁发生则会影响性能。可以用增加缓存来增强性能。


	
 
## 2、property 、weak，asign ，strong ，copy 等用法区别  
***@property = ivar + getter + setter;***

***assign***：用于对基本数据类型进行赋值操作，不更改引用计数。也可以用来修饰对象，但是，被assign修饰的对象在释放后，指针的地址还是存在的，也就是说指针并没有被置为nil，成为野指针。如果后续在分配对象到堆上的某块内存时，正好分到这块地址，程序就会crash。之所以可以修饰基本数据类型，因为基本数据类型一般分配在栈上，栈的内存会由系统自动处理，不会造成野指针。

```
 栈：由操作系统自动分配释放 ，存放函数的参数值，局部变量的值等。其操作方式类似于数据结构中的栈。
 堆： 一般由程序员分配释放， 若程序员不释放，程序结束时可能由OS回收，分配方式倒是类似于链表。
```


***weak***：修饰Object类型，修饰的对象在释放后，指针地址会被置为nil，是一种弱引用。在ARC环境下，为避免循环引用，往往会把delegate属性用weak修饰；在MRC下使用assign修饰。weak和strong不同的是：当一个对象不再有strong类型的指针指向它的时候，它就会被释放，即使还有weak型指针指向它，那么这些weak型指针也将被清除。



***retain*** ARC下的strong等同于MRC下的retain都会把对象引用计数加1。



***copy***：会在内存里拷贝一份对象，两个指针指向不同的内存地址。一般用来修饰NSString等有对应可变类型的对象，因为他们有可能和对应的可变类型（NSMutableString）之间进行赋值操作，为确保对象中的字符串不被修改 ，应该在设置属性是拷贝一份。而若用strong修饰，如果对象在外部被修改了，会影响到属性。


block属性为什么需要用copy来修饰？

因为在MRC下，block在创建的时候，它的内存是分配在栈(stack)上的，而不是在堆(heap)上，可能被随时回收。他本身的作于域是属于创建时候的作用域，一旦在创建时候的作用域外面调用block将导致程序崩溃。通过copy可以把block拷贝（copy）到堆，保证block的声明域外使用。在ARC下写不写都行，编译器会自动对block进行copy操作。


***_ _ block与_ _ weak的区别***

>>_ _ block：在ARC和MRC下都可用，可修饰对象，也可以修饰基本数据类型。

>>_ _ block：对象可以在block被重新赋值，_ _ weak不可以。

>>_ _ weak：只在ARC中使用，只能修饰对象，不能修饰基本数据类型（int、bool）。

>>>
同时，在ARC下，要避免block出现循环引用，经常会通过以下两种方法任选一种：
>>>>***_ _ weak***：_ _ weak typedof(self) weakSelf = self;实际定义了一个弱引用性质的替身.这个一般在使用block时会用到,因为block会copy它内部的变量,使用_ _ weak性质的self替代self,可以切断block对self的引用.避免循环引用.
```
typeof()是根据括号里的变量,自动识别变量类型并返回该类型
```

>>>>***重写block的set方法，定义弱引用***
>>>>
	```
	-(void)setBlock:(Block)block                       
	{
 	   _ _ weak Block blockT =addCell;        
 	   _block = blockT;
	}
	```
***不相互持有的block不需要weak self***


## 3、内存管理机制    


## 4、深拷贝浅拷贝  
## 5、kvo防止重复添加      
## 6、强引用弱引用循环信用等所有相关             
## 7、runtime，run loop多线程相关问题高级用法   
## 8、tcp，udp       
## 9、socket       
## 10、https http     
## 11、算法树形结构查找      
## 12、sdwebimage 实现流程，      
## 13、存储模式，各种目录用法     
## 14、sdk开发规范设计注意     
