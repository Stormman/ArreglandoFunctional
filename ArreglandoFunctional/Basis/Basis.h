//
//  Basis.h
//  Basis
//
//  Created by Robert Widmann on 9/7/14.
//  Copyright (c) 2014 TypeLift. All rights reserved.
//  Released under the MIT license.
//

#import <Foundation/Foundation.h>
#import "BASERealWorld.h"
//! Project version number for Basis.
FOUNDATION_EXPORT double BasisVersionNumber;

//! Project version string for Basis.
FOUNDATION_EXPORT const unsigned char BasisVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Basis/PublicHeader.h>

extension Array {
            /// Concatenate an array of arrays.
            func concat(rel : [T] -> [[U]]) -> [U] {
                return foldr({ $0 + $1 })([])(rel(self))
            }
     }

