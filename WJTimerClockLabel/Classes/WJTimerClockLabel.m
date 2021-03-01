//
//  WJTimerClockLabel.m
//  WJTimerLabel
//
//  Created by mac on 2021/3/1.
//

#import "WJTimerClockLabel.h"
#import "WJTimerClock.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface WJTimerClockLabel()
@property (strong,nonatomic) WJTimerClock* timmerClock;

@end


@implementation WJTimerClockLabel
- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initClock];
    }
    return self;
}

- (instancetype) init {
    if (self = [super init]) {
        [self initClock];
    }
    return self;
}

- (void) initClock {
    WS(weakSelf);
    self.text = @"00:00:00";
    self.textColor = [UIColor blackColor];
    
    WJTimerClock* clock = [WJTimerClock timerWithBlock:^(NSInteger count) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.text = [NSString stringWithFormat:@"%@",[self hhmmssWithCount:count]];
        });
    }];
    self.timmerClock = clock;
}

-(void)start {
    [self.timmerClock timeStart];
}

- (void)stop {
    [self.timmerClock timeStop];
}

- (void)end {
    [self.timmerClock timeEnd];
}

- (NSString*) hhmmssWithCount:(NSInteger) secCount {

    NSString *tmphh = [NSString stringWithFormat:@"%ld",secCount/3600];
    if ([tmphh length] == 1)
    {
        tmphh = [NSString stringWithFormat:@"0%@",tmphh];
    }
    
    NSString *tmpmm = [NSString stringWithFormat:@"%ld",(secCount/60)%60];
    if ([tmpmm length] == 1)
    {
        tmpmm = [NSString stringWithFormat:@"0%@",tmpmm];
    }
    NSString *tmpss = [NSString stringWithFormat:@"%ld",secCount%60];
    if ([tmpss length] == 1)
    {
        tmpss = [NSString stringWithFormat:@"0%@",tmpss];
    }
    NSString* timeString = [NSString stringWithFormat:@"%@:%@:%@",tmphh,tmpmm,tmpss];
    return timeString;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
