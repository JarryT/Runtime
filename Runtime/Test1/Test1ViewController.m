//
//  Test1ViewController.m
//  Runtime
//
//  Created by 汤军 on 2019/4/11.
//  Copyright © 2019年 汤军. All rights reserved.
//

#import "Test1ViewController.h"

@interface Person1 : NSObject

//属性的地址是怎么分配的?
//1、如果当前Person1对象的创建使用alloc正常分配地址, 那么所有的属性默认地址为0x0;
//2、使用 id cls = [Person1 class]; void *obj = &cls; 创建的对象、只是语法上满足了person实例的概念、并没有有效地分配内存;
//3、void *obj = &cls, obj Class定义多个属性时、访问其较后面的属性、会触发bad address crash.(注释控制器中的 test、number即可f触发);
//4、void *obj = &cls 生成的对象, 内部使用self.button不会处罚getter方法;
//5、void *obj = &cls , 属性寻址超过 0x108287078(Test1ViewController Class)地址时、触发bad address crash;
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)UIButton *button1;
@property (nonatomic, strong)UIButton *button2;
@property (nonatomic, strong)UIButton *button3;

+ (void)say;
- (void)print;
@end

@implementation Person1
+ (void)say{
    NSLog(@"[Class class] 类的地址: -- :%p",[self class]);
    //self -- :0x1032a5090
    //该内存地址位于字符常量区、与字符串控制器中test、test1内存地址相近
}

- (void)print{
    NSLog(@"Person1 self:%p",self);
    //Person1 self:0x7ffeec73a438
    
    NSLog(@"self.button = %p",self.button);
    NSLog(@"self.button = %@",self.button);
    
    NSLog(@"self.button1 = %p",self.button1);
    NSLog(@"self.button1 = %@",self.button1);
    
    NSLog(@"self.button2 = %p",self.button2);
    NSLog(@"self.button2 = %@",self.button2);
    
    NSLog(@"self.button3 = %p",self.button3);
    NSLog(@"self.button3 = %@",self.button3);
}
@end


@interface Test1ViewController ()
@end

@implementation Test1ViewController

- (id)init {
    self = [super init];
    if (self) {
        [self quest1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self quest2];
    
    [self quest3];
}

- (void)quest1{
    
    //Calling class method will returns the class object for the receiver’s class.
    NSLog(@"%@", NSStringFromClass([self class]));
    NSLog(@"%@", NSStringFromClass([super class]));
    
    //问题1:
    //Test1ViewController / Test1ViewController
    //因为super为编译器标示符，向super发送的消息被编译成objc_msgSendSuper，但仍以self作为reveiver
    //Returns the class object for the receiver’s class. 消息接收者是self
}

- (void)quest2{
    //问题2:
    //id cls = [Person1 class];
    //void *obj = &cls;
    //[(__bridge id))obj print];
    //结果是?
    
    
    //必须了解: 栈的内存分配是从高地址到低地址、连续的
    
    //记录某次运行中分配的地址
    NSString  *test = @"666";
    NSString  *test1 = @"777";
    NSString  *test2 = @"888";
    NSLog(@"\ntest:%p", test);
    //test:0x107f8f310
    
    NSNumber *number = [NSNumber numberWithInt:155];
    NSLog(@"\n number -- %p", number);
    //number -- 0xc18e662a38860116
    
    //cls is A Class that absolutely equals to class in "Class class = [Person1 class]"
    
    //1.obj is a Person1 object that was created without allocing it's inner memory, so its super small in memery costs, and it just looks like an Person1 object.
    //2.unlike we user [Class alloc], it takes some memery whenever we create an object.
    //3.there are three objects in a row:
    //obj    Person1 *    0x7ffee87cf430    0x00007ffee87cf430
    //btn    UIButton *    0x7ffee87cf420    0x00007ffee87cf420
    //btn1    UIButton *    0x7fa57d4026f0    0x00007fa57d4026f0
    
    id cls = [Person1 class];
    [cls say];
    void *obj = &cls;
    Person1 *person = (__bridge Person1*)obj;
    [person print] ;
    NSLog(@"\n person -- %p", person);
}
- (void)quest3{
    
    //下面代码的结果？
    //1、isKindOfClass:
    //Returns a Boolean value that indicates whether the receiver is an instance of given class or an instance of any class that inherits from that class.
    //2、isMemberOfClass:
    //Returns a Boolean value that indicates whether the receiver is an instance of a given class.
    Class cla1 = [NSObject class];
    Class cla2 = [Person1 class];
    
    //NSObject meta class 指向 NSObject class
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];//true
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];//false
    BOOL res3 = [(id)[Person1 class] isKindOfClass:[Person1 class]];//false
    BOOL res4 = [(id)[Person1 class] isMemberOfClass:[Person1 class]];//false
    BOOL res5 = [(id)[Person1 class] isKindOfClass:[NSObject class]];//true
    NSLog(@"%d%d%d%d%d",res1,res2,res3,res4,res5);
}

@end
