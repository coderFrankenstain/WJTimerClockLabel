//
//  WJTimerClock.h
//  WJTimerLabel
//
//  Created by mac on 2021/3/1.
//

#import <Foundation/Foundation.h>
typedef void (^timeCallBlock)(NSInteger count);

NS_ASSUME_NONNULL_BEGIN

@interface WJTimerClock : NSObject
+ (instancetype) timerWithBlock:(timeCallBlock) block;
- (void) timeStart;
- (void) timeStop;
- (void) timeEnd;
- (NSInteger) secCountValue;
@end

NS_ASSUME_NONNULL_END
