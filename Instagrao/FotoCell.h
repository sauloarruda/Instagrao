//
//  FotoCell.h
//  Instagrao
//
//  Created by Saulo Arruda on 9/26/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foto.h"

@interface FotoCell : UITableViewCell<FotoDelegate>

- (void)configureWithFoto:(Foto*)foto;

@end
