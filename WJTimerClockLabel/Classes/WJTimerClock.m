//
//  WJTimerClock.m
//  WJTimerLabel
//
//  Created by mac on 2021/3/1.
//

#import "WJTimerClock.h"

@interface WJTimerClock()
@property(strong,nonatomic) dispatch_source_t source_;
@property(assign,nonatomic) NSInteger secCount;
@property(assign,nonatomic) BOOL isSuspend;
@end


@implementation WJTimerClock
+ (instancetype) timerWithBlock:(timeCallBlock) block {
    WJTimerClock* clock = [[WJTimerClock alloc] init];
    [clock timeInitWithBlock:block];
    return clock;
}

- (void) timeStart {
    self.secCount = 0;
    // 启动任务，GCD计时器创建后需要手动启动
    if (self.isSuspend) {
        dispatch_resume(self.source_);
    }
    self.isSuspend = NO;
}

- (void) timeInitWithBlock:(timeCallBlock)block {
    
     dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(source, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(source, ^{
        self.secCount++;
        block(self.secCount);
    });
    
    self.source_ = source;
    self.isSuspend = YES;
}


- (void) timeStop {
    
    if(!self.isSuspend) {
        dispatch_suspend(self.source_);
    }
    self.isSuspend = YES;
}

- (NSInteger) secCountValue {
    return self.secCount;
}

- (void)  timeEnd {
   
    if (self.source_) {
        if (!self.isSuspend) {
            dispatch_source_cancel(self.source_);
        }
    }
}



@end
