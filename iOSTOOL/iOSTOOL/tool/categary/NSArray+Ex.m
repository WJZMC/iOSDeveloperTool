
#import "NSArray+Ex.h"
#import <objc/runtime.h>
@implementation NSArray (Ex)
//返回当前类的所有属性
+ (instancetype)getProperties:(Class)cls{
    //    return @[@"title",@"imgsrc"];
    
    //获取当前类的所有属性
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    //遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        //获取属性的名称
        const char *cName = property_getName(property);
        //
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    
    return mArray.copy;
}
@end
