//
//  Foto.h
//  Instagrao
//
//  Created by Saulo Arruda on 9/26/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FotoDelegate <NSObject>

- (void)imagemTeveProgresso:(double)progresso;
- (void)imagemCarregadaComSucesso:(NSData*)imageBytes;

@end

@interface Foto : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSString* descricao;
@property (nonatomic, strong) NSDate* dataCriacao;
@property (nonatomic, strong) NSString* url;

+ (Foto*)fotoWithDescricao:(NSString*)descricao data:(NSDate*)data;

- (void)downloadImageWithDelegate:(id<FotoDelegate>)delegate;
- (void)cancelarDownload;

@end
