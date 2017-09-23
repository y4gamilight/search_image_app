//
//  Constants.h
//  SearchImageApp
//
//  Created by DELL7447 on 9/21/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#ifndef ConstantsAPI_h
#define ConstantsAPI_h

// DEVELOP
#if DEVELOP == 1
#define GOOGLE_KEY_API_ENABLE           @"AIzaSyAUITrcUhziu7i1UCRWgRs3qPrzQ6YzLTI"
#define GOOGLE_KEY_API_ENABLE_2         @"AIzaSyDoAL4vsuPaztbrwxnCqd2nuAeu7JIt27A"
#define GOOGLE_KEY_API_ENABLE_3         @"AIzaSyCB0qtIJANi6F_aKFQpOlb-e_02BqgXSLU"
#define GOOGLE_KEY_API_ENABLE_4         @"AIzaSyAYRIdEjEFl3z56udhBr_B8EkvqCiAxS18"
#define GOOGLE_KEY_API_ENABLE_5         @"AIzaSyBxw4v-NqE5XQCB_VDvcUoGPTLmoESaTDU"


#define CX_USER                         @"003139732808011379870:7kfj3kj2cp8"

#define URL_DOMAIN_ROOT                 @"https://www.googleapis.com/"

//API
#define CUSTOM_SEARCH               @"customsearch/v1?key=%@&cx=%@"
#define CUSTOM_SEARCH_WITH_KEY(key)      [NSString stringWithFormat:CUSTOM_SEARCH,key,CX_USER]

#endif

// RELEASE

// CODE ERROR

#define CODE_ERROR_GOOGLE_API_403      -1011


#endif /* ConstantsAPI_h */
