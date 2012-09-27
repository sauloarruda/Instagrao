//
//  Timeline.m
//  Instagrao
//
//  Created by Saulo Arruda on 9/26/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import "Timeline.h"
#import "Foto.h"

@implementation Timeline {
    NSMutableData* _data;
}

- (NSArray*)todasFotos
{
    // Carrega fotos do banco de dados local...
    NSArray* fotos = nil;
//    [NSArray arrayWithObjects:
//                      [Foto fotoWithDescricao:@"Leozito rindo na balada!" data:[NSDate date]],
//                      [Foto fotoWithDescricao:@"Que fofura..." data:[NSDate date]]
//                      , nil];
    
    // Depois, manda buscar as fotos novas da web...
    [self carregarNovasFotos];
    
    return fotos;
}

- (void)carregarNovasFotos
{
    NSString* urlString = @"https://raw.github.com/sauloarruda/Instagram/master/timeline.json";
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    NSURLConnection* connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        _data = [[NSMutableData alloc] init];
        [connection start];
    }
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"json=%@", [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding]);
    
    NSError* error = nil;
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"Erro ao converter o JSON recebido pelo servidor: %@", error);
    }
    
    // TODO: parsear data corretamente
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dateFormatter setDateFormat:@"yyyy-dd-MM'T'HH:mm:ss'Z'"];
    
    NSMutableArray* fotos = [[NSMutableArray alloc] init];
    for (NSDictionary* jsonDictionary in jsonArray) {
        Foto* foto = [[Foto alloc] init];
        foto.descricao = [jsonDictionary objectForKey:@"description"];
        foto.dataCriacao = [dateFormatter dateFromString:[jsonDictionary objectForKey:@"created_at"]];
        foto.url = [jsonDictionary objectForKey:@"url"];
        [fotos addObject:foto];
    }

    [self.delegate novasFotosForamCarregadas:fotos];
}

@end
