//
//  PageDisplayViewController.m
//  DynamicCollectionview
//
//  Created by Tringapps on 07/03/16.
//  Copyright © 2016 Tringapps. All rights reserved.
//

#import "PageDisplayViewController.h"

@interface PageDisplayViewController ()

@end

@implementation PageDisplayViewController
@synthesize pageImages;
@synthesize intexValue;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Create page view controller
    
    
    NSLog(@"integer value %ld",(long)intexValue);
    NSLog(@"ARRAY %@",pageImages);
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:intexValue];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    //[self.pageViewController didMoveToParentViewController:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageImages count] == 0) || (index >= [self.pageImages count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = [[self.pageImages objectAtIndex:intexValue ] objectForKey:@"imageUrl"];
    pageContentViewController.titleText = [[self.pageImages objectAtIndex:intexValue ]objectForKey:@"name"];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    if (index > 0 || index <= ([pageImages count] - 1))
    {
        
        
        if (index > [pageImages count] - 1 ) {
            // //NSLog(@"Reached the end, swipe in opposite direction");
            return nil;
        }else{
            intexValue = index;
            return [self viewControllerAtIndex:index];
        }
    }

    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index > 0 || index <= ([pageImages count] - 1))
    {
        
        
        if (index > [pageImages count] - 1 ) {
            // //NSLog(@"Reached the end, swipe in opposite direction");
            return nil;
        }else{
            intexValue = index;
            return [self viewControllerAtIndex:index];
        }
    }

    
    return nil;

    
//    if (index == [self.pageImages count]) {
//        return nil;
//    }
//    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
