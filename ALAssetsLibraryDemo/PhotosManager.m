//
//  PhotosManager.m
//  ALAssetsLibraryDemo
//
//  Created by Daniel on 16/5/22.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "PhotosManager.h"

@interface PhotosManager ()
@property (nonatomic, copy)typeof(void(^)(NSArray *imageArr))block;
@end

static PhotosManager *manager = nil;
@implementation PhotosManager

+ (instancetype)shareManagerWithloadedAImageBlock:(void(^)(NSArray *imageArr))block {
    manager = [self shareManager];
    manager.block = block;
    [manager loadingWithBlock:block];
    return [self shareManager];
}

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [PhotosManager new];
        manager.assetlibrary = [ALAssetsLibrary new];
        manager.imageArray = @[].mutableCopy;
    });
    return manager;
}

- (void)loadingWithBlock:(void(^)(NSArray *imageArr))block {
    self.block = block;
    [self loadAssetsGroups];
}

- (void)loadAssetsGroups {
    NSString *tipTextWhenNoPhotosAuthorization; //提示语
    ALAuthorizationStatus authorizationStatus = [ALAssetsLibrary authorizationStatus];
    
    if (authorizationStatus == ALAuthorizationStatusRestricted) {
        NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisPlayName"];
        tipTextWhenNoPhotosAuthorization = [NSString stringWithFormat:@"请在设备的\
                                            '设置-隐私-照片'选项中, 允许%@访问你的相册", appName];
    }
    
    // 2. 如果已经获取授权, 则可以获取相册列表
    __weak typeof(self) blockSelf = self;
    
    [_assetlibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            if (group.numberOfAssets > 0) {
                
                [self getImagesInGroupsWithGroup:group];
            }
        } else {
            if (blockSelf.imageArray.count > 0) {
                NSLog(@"所有相册保存完毕, 可以找事相册列表");
                
                if (blockSelf.block) {
                    blockSelf.block(blockSelf.imageArray);
                }
                
            } else {
                NSLog(@"没有任何有资源的相册, 输出提示");
            }
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"相册获取失败");
    }];
}



- (void)getImagesInGroupsWithGroup:(ALAssetsGroup *)group {
    __weak typeof(self) blockSelf = self;
    
    [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        // fullScreenImage 适应屏幕的缩略图
        // fullResolutionImage 原图 不包编辑功能处理后的信息
        ALAssetRepresentation *representation = [result defaultRepresentation];
        UIImage *image = [UIImage imageWithCGImage:representation.fullResolutionImage];
        
        if (image) {
            [blockSelf.imageArray addObject:image];
        }
    }];
}

@end
