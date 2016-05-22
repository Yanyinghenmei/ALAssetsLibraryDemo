//
//  CollectionViewCell.h
//  ALAssetsLibraryDemo
//
//  Created by Daniel on 16/5/22.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
+ (UINib *)nib;
@end
