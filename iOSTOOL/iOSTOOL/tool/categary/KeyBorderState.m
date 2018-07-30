
//
//  KeyBorderState.m
//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
#import "KeyBorderState.h"

@interface KeyBorderState ()

/**保存传过来的block*/
@property (nonatomic, copy) void (^getKeyboardheight) (CGFloat keyboardHeight);

@property (nonatomic, copy) void (^keyboardWillHide) ();

@end

@implementation KeyBorderState

static KeyBorderState *manager = nil;

+ (KeyBorderState *)shareInstance {
    
    @synchronized ([KeyBorderState class]) {
        
        if (manager == nil) {
            
            manager = [[KeyBorderState alloc] init];
            
        }
        
        return manager;
    }
    
    return  nil;
}


- (void)addKeyboardNotificationOnSelf{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
//     UIKeyboardDidShowNotification UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)keyboardDidShow: (NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    if (self.getKeyboardheight) {
        self.getKeyboardheight (keyboardRect.size.height);
    }
    
}

- (void)keyboardWillHide: (NSNotification *)notification {
    
    if (self.keyboardWillHide) {
        self.keyboardWillHide();
    }
}

+ (void)getKeyboardHeighWith:(void (^)(CGFloat keyboardHeight))getKeyboardHeight {
    
    [KeyBorderState shareInstance].getKeyboardheight = getKeyboardHeight;
    
    [[KeyBorderState shareInstance] addKeyboardNotificationOnSelf];
    
}

+ (void)keyboardWillHide: (void (^) ())keyboardWillHide{
    
    [KeyBorderState shareInstance].keyboardWillHide = keyboardWillHide;
    [[KeyBorderState shareInstance] addKeyboardNotificationOnSelf];
    
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}



@end
