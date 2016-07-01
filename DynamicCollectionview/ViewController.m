//
//  ViewController.m
//  DynamicCollectionview
//
//  Created by Tringapps on 03/03/16.
//  Copyright © 2016 Tringapps. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#import "PageDisplayViewController.h"
@interface ViewController ()
@property (nonatomic, strong) NSArray *images;
@end

@implementation ViewController
@synthesize listOfFeeds;
@synthesize collectionView;

#pragma mark -
#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
    NSString* path = [[NSBundle mainBundle] pathForResource: @"Contents" ofType: @"json"];
    NSString *newString = [[[NSString stringWithContentsOfFile:path encoding:4 error:nil] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "];
    NSData* jsonData = [newString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jsonError;
    NSDictionary *allKeys = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&jsonError];
    NSLog(@"ALL keys %@",allKeys);
    
  //  listOfFeeds=[allKeys objectForKey:@"list"];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    float cellWidth;
    float cellHeight;
    if (listOfFeeds.count == 1) {
        cellWidth = (self.collectionView.frame.size.width);
        cellHeight = self.collectionView.frame.size.height ;
    }else if (listOfFeeds.count >2 && listOfFeeds.count <= 4){
        cellWidth = (self.collectionView.frame.size.width/2);
        cellHeight = self.collectionView.frame.size.height/2 ;
       // return [[listOfFeeds objectAtIndex:indexPath.item] size];
        
    }else{
      

        cellWidth = self.collectionView.frame.size.width;
        cellHeight = self.collectionView.frame.size.height/4;
        
    }
    
   
    return CGSizeMake(cellWidth, cellHeight);
    
}



#pragma mark -
#pragma mark - CollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return listOfFeeds.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell *cell=[self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dict=[listOfFeeds objectAtIndex:indexPath.row];
    cell.titleLabel.text=[dict objectForKey:@"name"];
    cell.feedImageView.contentMode = UIViewContentModeScaleAspectFill;
   cell.feedImageView.clipsToBounds = YES;
    [ViewController downloadImageWithURL:[NSURL URLWithString:[dict objectForKey:@"imageUrl"]] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            // change the image in the cell
            
            cell.feedImageView.image=image;
            
            // cache the image for use later (when scrolling up)
            
        }else{
            
            //NSLog(@"not download");
        }
    }];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    PageDisplayViewController *displayVc=[self.storyboard instantiateViewControllerWithIdentifier:@"PageDisplayViewController"];
    displayVc.pageImages=listOfFeeds;
    displayVc.intexValue=indexPath.item ;
    [self.navigationController pushViewController:displayVc animated:YES];
    
}
#pragma mark -
#pragma mark - Download Image
+ (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
   // [UIColor]
}

@end
