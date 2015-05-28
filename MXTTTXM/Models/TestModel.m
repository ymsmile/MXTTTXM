//
//  TestModel.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (NSString *)description {
    return [NSString stringWithFormat:@"[speakerID=%@, speakerName=%@]", self.speakerID, self.speakerName];
}

- (BOOL)isEqualToSpeaker:(TestModel *)speaker {
    if (!speaker) {
        return NO;
    }
    
    BOOL haveEqualIDs = (!self.speakerID && !speaker.speakerID) || [self.speakerID isEqualToString:speaker.speakerID];
    BOOL haveEqualNames = (!self.speakerName && !speaker.speakerName) || [self.speakerName isEqualToString:speaker.speakerName];
    BOOL haveEqualGroupID = (!self.belongGroupID && !speaker.belongGroupID) || [self.belongGroupID isEqualToString:speaker.belongGroupID];
    BOOL haveEqualGroupIP = (!self.belongGroupIP && !speaker.belongGroupIP) || [self.belongGroupIP isEqualToString:speaker.belongGroupIP];
    
    return haveEqualIDs && haveEqualNames && haveEqualGroupID && haveEqualGroupIP;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[TestModel class]]) {
        return NO;
    }
    
    return [self isEqualToSpeaker:(TestModel *)object];
}

- (NSUInteger)hash {
    NSUInteger hash = 0;
    hash += [[self speakerID] hash];
    hash += [[self speakerName] hash];
    hash += [[self belongGroupID] hash];
    hash += [[self belongGroupIP] hash];
    return hash;
}

@end
