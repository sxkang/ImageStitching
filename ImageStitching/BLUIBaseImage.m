//
//  BLUIBaseImage.m
//  ImageStitching
//
//  Created by 孙晓康 on 2017/8/19.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BLUIBaseImage.h"

#define DEVIDINGLINE 2.0

#define AVATARIMAGEWIDTH 40.0

@interface BLUIBaseImage ()

@property (nonatomic ,strong) UIImage *avatarImage;
@end

@implementation BLUIBaseImage


- (void)BuildWithImages:(NSArray<UIImage *>*)images {
    
    _avatarImage = [self createBaseImageWithImageArr:images];
}

- (bool *)SaveIntoPath:(NSString *)path OutError:(NSString *__autoreleasing *)error {
    
    bool isSuccess = false;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (_avatarImage != nil) {
        
        NSData *imageData = UIImagePNGRepresentation(_avatarImage);
        
       isSuccess = [fileManager createFileAtPath:path contents:imageData attributes:nil];
        
        NSLog(@"%@",path);
    }else {
        
       *error = @"image不能为空";
    }
    
    
    bool *bl = &isSuccess;
    
    return bl;
}

- (UIImage *)createBaseImageWithImageArr:(NSArray *)imageArr{
    
    NSAssert(imageArr.count >= 2 && imageArr.count <= 6, @"imageArrCountIllegal");
    
    NSArray *imageRectArr = [self generateImagePositionWithImageArr:imageArr];
    
    UIImage *finalImage = [self StitchingImageWithImageArr:imageArr imageRectArr:imageRectArr];
    
    return finalImage;
}

- (NSArray *)generateImagePositionWithImageArr:(NSArray *)imageArr {
    
    CGFloat largeImageWidth = (AVATARIMAGEWIDTH - DEVIDINGLINE)/3.0*2.0;
    CGFloat smallImageWidth = (AVATARIMAGEWIDTH - DEVIDINGLINE*2)/3.0;
    
    NSArray *imagePointArr = [self generatePointWithCount:imageArr.count largeImageWidth:largeImageWidth smallImageWidth:smallImageWidth];
    
    NSMutableArray *imageRectArr = [[NSMutableArray alloc] init];
    
    int i = 0;
    for (NSString *pointStr in imagePointArr) {
        
        CGPoint imagePoint = CGPointFromString(pointStr);
        
        if (i == 0) {
            
            CGRect largeRect = [self generateLargeImageWithLargeImageWidth:largeImageWidth largePoint:imagePoint];
            [imageRectArr addObject:NSStringFromCGRect(largeRect)];
        }else {
            
            CGRect smallRect = [self generateSmallImageWithSmallImageWidth:smallImageWidth smallPoint:imagePoint];
            [imageRectArr addObject:NSStringFromCGRect(smallRect)];
        }
        
        i++;
    }
    
    return imageRectArr;
}

- (NSArray *)generatePointWithCount:(NSInteger)count largeImageWidth:(CGFloat)largeImageWidth smallImageWidth:(CGFloat)smallImageWidth {
    
    NSMutableArray *pointArr = [[NSMutableArray alloc] init];
    
    if (count == 2) {
        
        CGPoint largePoint = CGPointMake(0, 0);
        
        CGPoint smallPoint = CGPointMake(largeImageWidth + DEVIDINGLINE, largeImageWidth + DEVIDINGLINE);
        [pointArr addObject:NSStringFromCGPoint(largePoint)];
        [pointArr addObject:NSStringFromCGPoint(smallPoint)];
    }else if (count == 3) {
        
    }else if (count == 4) {
        
        CGPoint largePoint = CGPointMake((AVATARIMAGEWIDTH - largeImageWidth)/2.0, 0);
        
        [pointArr addObject:NSStringFromCGPoint(largePoint)];
        
        for (int i = 0; i< 3; i++) {
            
            CGPoint smallPoint = CGPointMake(i*(smallImageWidth + DEVIDINGLINE), largeImageWidth + DEVIDINGLINE);
            
            [pointArr addObject:NSStringFromCGPoint(smallPoint)];
        }
    }else if (count == 5 || count == 6) {
        
        CGPoint largePoint = CGPointMake(0, 0);
        [pointArr addObject:NSStringFromCGPoint(largePoint)];
        
        for (int i=1; i>=0; i--) {
            
            for (int j=0; j<2; j++) {
                
                if (i == 1) {
                    
                CGPoint smallPoint = CGPointMake(largeImageWidth+DEVIDINGLINE, j*(smallImageWidth + DEVIDINGLINE));
                [pointArr addObject:NSStringFromCGPoint(smallPoint)];
                    
                }else if (i == 0) {
                    
                    CGPoint smallPoint = CGPointMake(j*(smallImageWidth + DEVIDINGLINE),largeImageWidth + DEVIDINGLINE);
                    [pointArr addObject:NSStringFromCGPoint(smallPoint)];
                }
            }
        }
        
        if (count == 6) {
            
            CGPoint smallPoint = CGPointMake(largeImageWidth + DEVIDINGLINE, largeImageWidth +DEVIDINGLINE);
            [pointArr addObject:NSStringFromCGPoint(smallPoint)];
        }
    }
    
    return pointArr;
}


- (CGRect)generateLargeImageWithLargeImageWidth:(CGFloat)largeWidth largePoint:(CGPoint)point{
    
    CGRect largeRect = CGRectMake(point.x, point.y, largeWidth, largeWidth);
    
    return largeRect;
}

- (CGRect)generateSmallImageWithSmallImageWidth:(CGFloat)smallWidth smallPoint:(CGPoint)point {
    
    CGRect smallRect = CGRectMake(point.x, point.y, smallWidth, smallWidth);
    
    return smallRect;
}

- (UIImage *)StitchingImageWithImageArr:(NSArray *)imageArr imageRectArr:(NSArray *)imageRectArr {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(AVATARIMAGEWIDTH, AVATARIMAGEWIDTH), NO, [UIScreen mainScreen].scale);
    
    int i = 0;
    for (UIImage *image in imageArr) {
        
        CGRect imageRect = CGRectFromString(imageRectArr[i]);
        [image drawInRect:imageRect];
        
        i++;
    }
    
    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imagez;
}

@end
