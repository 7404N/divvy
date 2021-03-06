//
//  DivvyTSNE.m
//  Divvy
//
//  Created by Laurens van der Maaten on 8/18/11.
//  Copyright 2011 Delft University of Technology. All rights reserved.
//

#import "DivvyIsomap.h"
#import "DivvyDataset.h"

#include "isomap.h"

struct IsomapImpl {};

@implementation DivvyIsomap

@dynamic reducerID;
@dynamic name;

@dynamic helpURL;

@dynamic d;
@dynamic k;


- (void) awakeFromInsert {
	[super awakeFromInsert];
	
	self.name = @"Isomap";
	self.reducerID = [[NSProcessInfo processInfo] globallyUniqueString];
}

- (void) calculateD:(DivvyDataset *)dataset {
    // Isomap always stays with its default of 10
}

- (void) reduceDataset:(DivvyDataset *)dataset
           reducedData:(NSData *)reducedData {
	
	float *newReducedData = (float*) [reducedData bytes];
    int cur_k = [[self k] intValue];
    if(cur_k == 0) cur_k = 12;          // cannot be zero!
    run_isomap([dataset floatData], 
               [[dataset n] unsignedIntValue], 
               [[dataset d] unsignedIntValue], 
               newReducedData, [self.d unsignedIntValue], cur_k);     // this code is in C++    
    
//	// Print out reduced data
//	for(int i = 0; i < [[dataset n] unsignedIntValue]; i++) {
//        for(int j = 0; j < [self.d unsignedIntValue]; j++) {
//            printf("%f,", newReducedData[j * [[dataset n] unsignedIntValue] + i]);
//        }
//        printf("\n");
//    }
}


@end
