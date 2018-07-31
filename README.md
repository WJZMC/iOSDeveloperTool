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
pod 'YYCache'
pod 'YYText'
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
## 2、weak，asign ，strong ，copy 等用法区别  

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
