//
//  RCTCalendarModule.m
//  RnBridgingIos
//
//  Created by Andika Andriana on 06/09/22.
//

#import <Foundation/Foundation.h>
// RCTCalendarModule.m
#import "RCTCalendarModule.h"
#import <React/RCTLog.h>
#import "UIView+Toast.h"


NSInteger const LRDRCTSimpleToastBottomOffset = 40;
double const LRDRCTSimpleToastShortDuration = 3.0;
double const LRDRCTSimpleToastLongDuration = 5.0;
NSInteger const LRDRCTSimpleToastGravityBottom = 1;
NSInteger const LRDRCTSimpleToastGravityCenter = 2;
NSInteger const LRDRCTSimpleToastGravityTop = 3;

@implementation RCTCalendarModule{
  CGFloat _keyOffset;
}

+ (BOOL)requiresMainQueueSetup
{
    return NO;
}

// To export a module named RCTCalendarModule
RCT_EXPORT_MODULE();

- (NSDictionary *)constantsToExport {
    return @{
             @"SHORT": [NSNumber numberWithDouble:LRDRCTSimpleToastShortDuration],
             @"LONG": [NSNumber numberWithDouble:LRDRCTSimpleToastLongDuration],
             @"BOTTOM": [NSNumber numberWithInteger:LRDRCTSimpleToastGravityBottom],
             @"CENTER": [NSNumber numberWithInteger:LRDRCTSimpleToastGravityCenter],
             @"TOP": [NSNumber numberWithInteger:LRDRCTSimpleToastGravityTop]
             };
}


RCT_EXPORT_METHOD(createCalendarEvent:(NSString *)message)
{
      
  [self _show:message duration: 0.5 gravity:LRDRCTSimpleToastGravityBottom];

}

- (void)_show:(NSString *)msg duration:(NSTimeInterval)duration gravity:(NSInteger)gravity {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *root = [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
        CGRect bound = root.bounds;
      bound.size.height -= self->_keyOffset;
        if (bound.size.height > LRDRCTSimpleToastBottomOffset*2) {
            bound.origin.y += LRDRCTSimpleToastBottomOffset;
            bound.size.height -= LRDRCTSimpleToastBottomOffset*2;
        }
        UIView *view = [[UIView alloc] initWithFrame:bound];
        view.userInteractionEnabled = NO;
        [root addSubview:view];
        UIView __weak *blockView = view;
        id position;
        if (gravity == LRDRCTSimpleToastGravityTop) {
            position = CSToastPositionTop;
        } else if (gravity == LRDRCTSimpleToastGravityCenter) {
            position = CSToastPositionCenter;
        } else {
            position = CSToastPositionBottom;
        }
        [view makeToast:msg
            duration:duration
            position:position
            title:nil
            image:nil
            style:nil
            completion:^(BOOL didTap) {
                [blockView removeFromSuperview];
            }];
    });
}

@end
