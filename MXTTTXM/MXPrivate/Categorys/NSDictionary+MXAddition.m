//
//  NSDictionary+MXAddition.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "NSDictionary+MXAddition.h"

#import "NSObject+MXAddition.h"

@implementation NSDictionary (MXAddition)

#pragma mark - 取值

- (BOOL)mx_isKindOfClass:(Class)aClass forKey:(NSString *)key {
    id value = [self objectForKey:key];
    return [value isKindOfClass:aClass];
}

- (BOOL)mx_isMemberOfClass:(Class)aClass forKey:(NSString *)key {
    id value = [self objectForKey:key];
    return [value isMemberOfClass:aClass];
}

- (BOOL)mx_isArrayForKey:(NSString *)key {
    return [self mx_isKindOfClass:[NSArray class] forKey:key];
}

- (BOOL)mx_isDictionaryForKey:(NSString *)key {
    return [self mx_isKindOfClass:[NSDictionary class] forKey:key];
}

- (BOOL)mx_isStringForKey:(NSString *)key {
    return [self mx_isKindOfClass:[NSString class] forKey:key];
}

- (BOOL)mx_isNumberForKey:(NSString *)key {
    return [self mx_isKindOfClass:[NSNumber class] forKey:key];
}

- (NSArray *)mx_arrayForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)mx_dictionaryForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSString *)mx_stringForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else if ([value respondsToSelector:@selector(description)]) {
        return [value description];
    }
    return nil;
}

- (NSNumber *)mx_numberForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        return [nf numberFromString:value];
    }
    return nil;
}

- (double)mx_doubleForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value doubleValue];
    }
    return 0;
}

- (float)mx_floatForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value floatValue];
    }
    return 0;
}

- (int)mx_intForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value intValue];
    }
    return 0;
}

- (unsigned int)mx_unsignedIntForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntValue];
    }
    return 0;
}

- (NSInteger)mx_integerForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)mx_unsignedIntegerForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (long long)mx_longLongForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (unsigned long long)mx_unsignedLongLongForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    return 0;
}

- (BOOL)mx_boolForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    return NO;
}

#pragma mark - 其他

- (NSString *)dictToJSONStirng {
    
    if (!self) {
        return @"";
    }
    
    if (![self isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:&parseError];
    
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return str;
}

- (BOOL)isEmpty {
    if (self == nil)
        return YES;
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([self count] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

- (BOOL)hasEmptyValue {
    for (NSString *key in self.allKeys) {
        id value = self[key];
        NSString *str = [NSString stringWithFormat:@"%@", value];
        if ([str isEmptyObject]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isValidValueWithKey:(NSString *)key {
    if (self == nil) {
        return NO;
    }
    
    if (!key) {
        return NO;
    }
    
    id value = self[key];
    if (value) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Swizzling

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self mx_swizzleMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(mx_initWithObjects:forKeys:count:)];
        [self mx_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) withMethod:@selector(mx_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)mx_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            //            continue;
#if DEBUG
            NSLog(@"%s: Init WARING——object is nil for key:(%@), will replace it with NSNull", __FUNCTION__, key);
#endif
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self mx_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)mx_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            //            continue;
#if DEBUG
            NSLog(@"%s: Init WARING——object is nil for key:(%@), will replace it with NSNull", __FUNCTION__, key);
#endif
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self mx_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end


@implementation NSMutableDictionary (MXNSDictionary)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if !DEBUG
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class mx_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(mx_setObject:forKey:)];
        //        [class mx_swizzleMethod:@selector(setObject:forKeyedSubscript:) withMethod:@selector(mx_setObject:forKeyedSubscript:)];
        [class mx_swizzleMethod:@selector(removeObjectForKey:) withMethod:@selector(mx_removeObjectForKey:)];
#endif
    });
}

- (void)mx_setObject:(id)anObject forKey:(id<NSCopying>)key {
    if (!key) {
#if DEBUG
        NSLog(@"%s: key can't be nil", __FUNCTION__);
#endif
        return;
    }
    if (!anObject) {
#if DEBUG
        NSLog(@"%s: setObject WARING——object is nil for key:(%@), will replace it with NSNull", __FUNCTION__, key);
#endif
        anObject = [NSNull null];
    }
    [self mx_setObject:anObject forKey:key];
}

- (void)mx_setObject:(id)anObject forKeyedSubscript:(id<NSCopying>)key {
    if (!key) {
#if DEBUG
        NSLog(@"%s: key can't be nil", __FUNCTION__);
#endif
        return;
    }
    if (!anObject) {
#if DEBUG
        NSLog(@"%s: setObject WARING——object is nil for key:(%@), will replace it with NSNull", __FUNCTION__, key);
#endif
        anObject = [NSNull null];
    }
    [self mx_setObject:anObject forKeyedSubscript:key];
}

- (void)mx_removeObjectForKey:(id<NSCopying>)aKey {
    if (!aKey) {
#if DEBUG
        NSLog(@"%s: key can't be nil", __FUNCTION__);
#endif
        return;
    }
    [self mx_removeObjectForKey:aKey];
}

@end

@implementation NSNull (MXNSDictionary)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self mx_swizzleMethod:@selector(methodSignatureForSelector:) withMethod:@selector(mx_methodSignatureForSelector:)];
        [self mx_swizzleMethod:@selector(forwardInvocation:) withMethod:@selector(mx_forwardInvocation:)];
    });
}

- (NSMethodSignature *)mx_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [self mx_methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:@encode(void)];
}

- (void)mx_forwardInvocation:(NSInvocation *)anInvocation {
    NSUInteger returnLength = [[anInvocation methodSignature] methodReturnLength];
    if (!returnLength) {
        // nothing to do
        return;
    }
    
    // set return value to all zero bits
    char buffer[returnLength];
    memset(buffer, 0, returnLength);
    
    [anInvocation setReturnValue:buffer];
}

@end
