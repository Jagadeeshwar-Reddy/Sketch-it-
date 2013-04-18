//
//  MJRMainMenuVC.m
//  Paint it!
//
//  Created by Giriprasad Reddy on 17/04/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import "MJRMainMenuVC.h"
#import "MJRMenuCell.h"

#define kMenuItems [NSArray arrayWithObjects:@"Board Stack",@"Gallery",@"Shapes", nil]
@interface MJRMainMenuVC ()

@end

@implementation MJRMainMenuVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Each view can dynamically specify the min/max width that can be revealed.
    [self.revealController setMinimumWidth:200.0f maximumWidth:250.0f forViewController:self];
    
    self.view.backgroundColor=_menu_tableview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern_bg"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [kMenuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MJRMenuCell";

    
    MJRMenuCell *cell = (MJRMenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (MJRMenuCell *)[nib objectAtIndex:0];
        
        
        UIView *selection_view=[[UIView alloc] initWithFrame:CGRectInset(cell.frame, 0, 1)];
        selection_view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        cell.selectedBackgroundView=selection_view;
    }
    
    cell.text_label.text=[kMenuItems objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
