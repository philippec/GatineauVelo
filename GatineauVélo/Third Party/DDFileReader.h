//
//  DDFileReader.h
//  PBX2OPML
//
//  Created by michael isbell on 11/6/11.
//  Copyright (c) 2011 BlueSwitch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDFileReader : NSObject
{
    NSString * filePath;

    NSFileHandle * fileHandle;
    unsigned long long currentOffset;
    unsigned long long totalFileLength;

    NSString * lineDelimiter;
    NSUInteger chunkSize;
}

@property (nonatomic, copy) NSString * lineDelimiter;
@property (nonatomic) NSUInteger chunkSize;

- (id)initWithFilePath:(NSString *)aPath;

- (NSString *)readLine;
- (NSString *)readTrimmedLine;

#if NS_BLOCKS_AVAILABLE
- (void)enumerateLinesUsingBlock:(void(^)(NSString *, BOOL *stop))block;
#endif

@end

