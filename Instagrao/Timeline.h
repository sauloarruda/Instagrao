//
//  Timeline.h
//  Instagrao
//
//  Created by Saulo Arruda on 9/26/12.
//  Copyright (c) 2012 Jera. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimelineDelegate <NSObject>

- (void)novasFotosForamCarregadas:(NSArray*)fotosArray;

@end

@interface Timeline : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) id<TimelineDelegate> delegate;

- (NSArray*)todasFotos;

@end
