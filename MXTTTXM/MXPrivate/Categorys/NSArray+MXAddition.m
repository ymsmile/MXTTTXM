//
//  NSArray+MXAddtion.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "NSArray+MXAddition.h"

#import "NSObject+MXAddition.h"

@implementation NSArray (MXAddition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if !DEBUG
        Class class1 = NSClassFromString(@"__NSArrayI");
        Class class2 = NSClassFromString(@"__NSPlaceholderArray");
        [class2 mx_swizzleMethod:@selector(initWithObjects:count:) withMethod:@selector(mx_initWithObjects:count:)];
        [class1 mx_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(mx_objectAtIndex:)];
        
#endif
    });
}

- (instancetype)mx_initWithObjects:(const id [])objects count:(NSUInteger)cnt {
    
    BOOL hasNilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (objects[i] == nil) {
            hasNilObject = YES;
#if DEBUG
            NSLog(@"%s: object at index (%@) is nil", __FUNCTION__, @(i));
#endif
        }
    }
    
    // 因为有值为nil的元素，那么我们可以过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
        return [self mx_initWithObjects:newObjects count:index];
    }
    return [self mx_initWithObjects:objects count:cnt];
}

- (instancetype)mx_objectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
#if DEBUG
        NSLog(@"%s: can't get object from an empty array", __FUNCTION__);
#endif
        return nil;
    }
    if (index >= [self count]) {
#if DEBUG
        NSLog(@"%s: index out of bounds in array", __FUNCTION__);
#endif
        return nil;
    }
    return [self mx_objectAtIndex:index];
}

#pragma mark - Others

- (BOOL)isEmpty {
    if (self == nil) {
        return YES;
    }
    if ([self isKindOfClass:[NSArray class]]) {
        if ([self count] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

- (BOOL)hasSameContents:(NSArray *)array {
    if (self.count == 0 || array == nil) {
        return NO;
    }
    
    if (![array isKindOfClass:[NSArray class]] && [array count] == 0) {
        return NO;
    }
    
    NSSet *a = [NSSet setWithArray:self];
    NSSet *b = [NSSet setWithArray:array];
    
    return [a isEqualToSet:b];
}

- (BOOL)mx_containNSNumberObject:(NSNumber *)obj {
    if (!self || self.count < 1) {
        return NO;
    }
    if (!obj) {
        return NO;
    }
    for (NSNumber *num in self) {
        if ([num integerValue] == [obj integerValue]) {
            return YES;
        }
    }
    
    return NO;
}

@end

@implementation NSMutableArray (MXNSArray)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if !DEBUG
        Class class1 = NSClassFromString(@"__NSArrayM");
        [class1 mx_swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(mx_insertObject:atIndex:)];
        [class1 mx_swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(mx_removeObjectAtIndex:)];
        [class1 mx_swizzleMethod:@selector(addObject:) withMethod:@selector(mx_addObject:)];
        //        [class1 mx_swizzleMethod:@selector(removeObject:) withMethod:@selector(mx_removeObject:)];
#endif
    });
}

- (void)mx_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject) {
#if DEBUG
        NSLog(@"%s: can't insert nil object", __FUNCTION__);
#endif
        return;
    }
    else if (index > self.count) {// 不能有等于
#if DEBUG
        NSLog(@"%s: index out of bounds in array", __FUNCTION__);
#endif
        return;
    }
    else {
        [self mx_insertObject:anObject atIndex:index];
    }
}

- (void)mx_removeObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
#if DEBUG
        NSLog(@"%s: can't remove object from an empty array", __FUNCTION__);
#endif
        return;
    }
    if (index >= self.count) {
#if DEBUG
        NSLog(@"%s: index out of bounds in array", __FUNCTION__);
#endif
        return;
    }
    [self mx_removeObjectAtIndex:index];
}

- (void)mx_addObject:(id)anObject {
    if (!anObject) {
#if DEBUG
        NSLog(@"%s: object can't be nil", __FUNCTION__);
#endif
        return;
    }
    [self mx_addObject:anObject];
}

- (void)mx_removeObject:(id)anObject {
    if (!anObject) {
#if DEBUG
        NSLog(@"%s: object can't be nil", __FUNCTION__);
#endif
        return;
    }
    [self mx_removeObject:anObject];
}

@end
