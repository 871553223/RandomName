//
//  DJRandomMethodName.m
//  Test0801
//
//  Created by 曹敬贺 on 16/8/1.
//  Copyright © 2016年 北京无限点乐科技有限公司. All rights reserved.
//

#import "DJRandomMethodName.h"


typedef enum
{
    DJClassName,
    DJMethodName
}DJNameType;

@interface DJRandomMethodName ()
//内存中缓存数组
@property (nonatomic, strong) NSMutableArray * memoryArray;
//随机生成的名字组成的数组
@property (nonatomic, strong) NSMutableArray * namesArray;

@end


static dispatch_once_t dj_predicate;
static DJRandomMethodName * manager = nil;
@implementation DJRandomMethodName

#pragma mark - singleShare
+ (DJRandomMethodName *)share
{
    dispatch_once(&dj_predicate, ^{
        manager = [super allocWithZone:NULL];
        manager.memoryArray = [[NSMutableArray alloc]initWithArray:[manager getWordFromFile:[manager getFilePath]]];
        manager.namesArray = [NSMutableArray array];
    });
    return manager;
}
- (id)copy
{
    return [DJRandomMethodName share];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [DJRandomMethodName share];
}
#pragma mark - Methods
- (NSString *)getFilePath
{
    NSString * filePath = [[NSBundle mainBundle]pathForResource:@"CET4" ofType:nil];
    return filePath;
}
- (NSArray *)getWordFromFile:(NSString *)file
{
    NSError * error = nil;
    NSString * articleText = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        return nil;
    }else
    {
        NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@" \n"];
        NSArray * wordsArray = [articleText componentsSeparatedByCharactersInSet:set];
        return wordsArray;
    }
}

/** 用来随机生成一个合规字符串*/
- (NSString *)randomNameWithWordsMin:(NSInteger)min Max:(NSInteger)max WithType:(DJNameType)type
{
    NSMutableString * methodName = [[NSMutableString alloc]initWithString:@""];
    NSInteger wordCount = rand()%max + min;
    switch (type) {
        case DJClassName:
                for (int i = 0; i < wordCount; i++) {
                    int wordIndex = arc4random() % self.memoryArray.count;
                    [methodName appendFormat:@"%@",[self.memoryArray[wordIndex] capitalizedString]];
                }
            break;
        case DJMethodName:
                for (int i = 0; i < wordCount; i++) {
                    int wordIndex = arc4random() % self.memoryArray.count;
                    if (i == 0) {
                        [methodName appendFormat:@"%@",[self.memoryArray[wordIndex] lowercaseString]];
                    }else
                    {
                        [methodName appendFormat:@"%@",[self.memoryArray[wordIndex] capitalizedString]];
                    }
                }
            break;
        default:
            break;
    }
    return methodName;
}

+ (NSString *)randomMethodName
{
    DJRandomMethodName * myDj = [DJRandomMethodName share];
    NSString * name;
    do {
        name = [myDj randomNameWithWordsMin:2 Max:4 WithType:DJMethodName];
        if (![myDj.namesArray containsObject:name]) {
            break;
        }
    } while (1);
    return name;
}

+ (NSString *)randomClassName
{
    DJRandomMethodName * myDj = [DJRandomMethodName share];
    NSString * name;
    do {
        name = [myDj randomNameWithWordsMin:1 Max:3 WithType:DJClassName];
        if (![myDj.namesArray containsObject:name]) {
            break;
        }
    } while (1);
    return name;
}


@end
