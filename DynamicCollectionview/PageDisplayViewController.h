//
//  PageDisplayViewController.h
//  DynamicCollectionview
//
//  Created by Tringapps on 07/03/16.
//  Copyright © 2016 Tringapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
@interface PageDisplayViewController : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@property NSInteger intexValue;

@end
