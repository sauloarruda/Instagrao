//
//  ViewController.m
//  Instagrao
//
//  Created by Saulo Arruda on 9/26/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "MuralViewController.h"
#import "FotoCell.h"
#import "Foto.h"

@interface MuralViewController ()

@property (nonatomic, strong) Timeline* timeline;
@property (nonatomic, strong) NSArray* fotosMural;

@end

@implementation MuralViewController

@synthesize timeline;
@synthesize fotosMural;

- (Timeline*)timeline
{
    if (!timeline) {
        timeline = [[Timeline alloc] init];
        timeline.delegate = self;
    }
    return timeline;
}

- (NSArray*)fotosMural
{
    if (!fotosMural) {
        fotosMural = [self.timeline todasFotos];
    }
    return fotosMural;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fotosMural count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FotoCell* cell = [tableView dequeueReusableCellWithIdentifier:@"fotoCell"];
    Foto* foto = [self.fotosMural objectAtIndex:indexPath.row];
    [cell configureWithFoto:foto];
    return cell;
}

#pragma mark - TimelineDelegate methods

- (void)novasFotosForamCarregadas:(NSArray*)novasFotosArray
{
    NSMutableArray* todasFotos = [NSMutableArray arrayWithArray:novasFotosArray];
    [todasFotos addObjectsFromArray:fotosMural];
    fotosMural = todasFotos;
    [self.tableView reloadData];
}

@end
