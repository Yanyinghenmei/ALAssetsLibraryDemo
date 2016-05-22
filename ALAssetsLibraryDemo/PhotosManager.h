//
//  PhotosManager.h
//  ALAssetsLibraryDemo
//
//  Created by Daniel on 16/5/22.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotosManager : NSObject

@property (nonatomic, strong)ALAssetsLibrary *assetlibrary;
@property (nonatomic, strong)NSMutableArray *imageArray;

+ (instancetype)shareManager;
+ (instancetype)shareManagerWithloadedAImageBlock:(void(^)(NSArray *imageArr))block;
@end


// AssetsLibrary 代表整个设备中的资源库(照片库), 通过AssetLibrary可以获取设备中的照片和视频

// ALAssetsGroup 映射照片库中的一个相册, 通过AlAssetsGroup可以获取某个相册的信息, 相册下的资源, 同时也可以对某个相册添加资源

// ALAsset 映射照片库中的一个照片或视频, 通过ALAset可以获取某个照片或视频的详细信息, 或者保存照片和视频

// ALAssetRepresentation 是对ALAset的封装(但不是其子类), 可以更方便地获取ALAsset中的信息, 没个ALAset都有至少有一个ALAssetRepresentation对象, 可以通过defaultRepresentation获取. 而例如使用系统相机应用拍摄RAW+JPEG照片, 则会有两个ALAssetRepresentation, 一个封装了照片的RAW信息, 另外一个则封装了照片的JPEG信息.

/*图片选择器
 1. 获取照片库
 2. 展示所有相册
 3. 展示相册中的所有图片
 4. 预览图盘大图
 */