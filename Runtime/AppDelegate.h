//
//  AppDelegate.h
//  Runtime
//
//  Created by 汤军 on 2019/4/11.
//  Copyright © 2019年 汤军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

