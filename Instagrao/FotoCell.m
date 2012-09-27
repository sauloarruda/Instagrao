//
//  FotoCell.m
//  Instagrao
//
//  Created by Saulo Arruda on 9/26/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "FotoCell.h"

@interface FotoCell ()

@property (weak, nonatomic) Foto* foto;

@property (weak, nonatomic) IBOutlet UIImageView *fotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *descricaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (strong, nonatomic) NSDateFormatter* dateFormatter;

@end

@implementation FotoCell

@synthesize dateFormatter;

- (NSDateFormatter*)dateFormatter
{
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    }
    return dateFormatter;
}

- (void)configureWithFoto:(Foto*)foto
{
    if (self.foto) {
        [self.foto cancelarDownload];
        self.fotoImageView.image = nil;
        [self.progressView setProgress:0];
    }
    self.foto = foto;
    self.descricaoLabel.text = self.foto.descricao;
    [self.foto downloadImageWithDelegate:self];
    self.dataLabel.text = [self.dateFormatter stringFromDate:self.foto.dataCriacao];
    
    [UIView animateWithDuration:0.5 animations:^(){
        [self.fotoImageView setAlpha:0];
    }];
}

#pragma mark - FotoDelegate methods

- (void)imagemCarregadaComSucesso:(NSData*)imageBytes
{
    [self.progressView setHidden:YES];

    [UIView animateWithDuration:0.5 animations:^(){
        [self.fotoImageView setAlpha:1];
    }];
    self.fotoImageView.image = [UIImage imageWithData:imageBytes];
}

- (void)imagemTeveProgresso:(double)progresso
{
    if ([self.progressView isHidden])
        [self.progressView setHidden:NO];
    [self.progressView setProgress:progresso];
}

@end
