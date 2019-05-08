//
//  ALPinYinSortSectionView.h
//  ALPinYinSort
//
//  Created by admin on 2019/5/8.
//  Copyright © 2019年 AL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALPinYinSortSectionView : UIView
-(instancetype)initWithFrame:(CGRect)frame
                    titleArr:(NSArray*)titleArr
               selectedBlock:(void(^)(NSInteger selectedIndex))selectedBlock;
@end

NS_ASSUME_NONNULL_END
