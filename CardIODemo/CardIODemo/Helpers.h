//
//  Helpers.h
//  CardIODemo
//
//  Created by mike.tihonchik on 4/2/14.
//  Copyright (c) 2014 mike.tihonchik. All rights reserved.
//

#ifndef CardIODemo_Helpers_h
#define CardIODemo_Helpers_h

#define HELVETICA_BOLD(x) [UIFont fontWithName:@"HelveticaNeue-Bold" size:x]
#define EFFRA_MEDIUM(x) [UIFont fontWithName:@"Effra-Medium" size:x]
#define EFFRA_LIGHT(x) [UIFont fontWithName:@"Effra-Light" size:x]

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0f green:((c>>16)&0xFF)/255.0f blue:((c>>8)&0xFF)/255.0f alpha:((c)&0xFF)/255.0f];

#endif
