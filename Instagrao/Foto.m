//
//  Foto.m
//  Instagrao
//
//  Created by Saulo Arruda on 9/26/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "Foto.h"

@interface Foto ()

@property (nonatomic, weak) id<FotoDelegate> delegate;

@end

@implementation Foto {
    NSMutableData* _data;
    NSURLConnection* _connection;
    long long _tamanhoEsperado;
}

@synthesize descricao;
@synthesize dataCriacao;
@synthesize url;
@synthesize delegate = _delegate;

+ (Foto*)fotoWithDescricao:(NSString*)descricao data:(NSDate*)data
{
    Foto* foto = [[Foto alloc] init];
    foto.descricao = descricao;
    foto.dataCriacao = data;
    return foto;
}

- (void)downloadImageWithDelegate:(id<FotoDelegate>)delegate
{
    self.delegate = delegate;

    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:300];
    _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (_connection) {
        _data = [[NSMutableData alloc] init];
        [_connection start];
    }
}

- (void)cancelarDownload
{
    self.delegate = nil;
    [_connection cancel];
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _tamanhoEsperado = [response expectedContentLength];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
    double progresso = (double)[_data length] / (double)_tamanhoEsperado;
    //NSLog(@"download %@ => %d bytes, totalBaixado=%d, progresso = %f", self.descricao,[_data length], [data length], progresso);
    [self.delegate imagemTeveProgresso:progresso];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.delegate imagemCarregadaComSucesso:_data];
    self.delegate = nil;
}

@end
