#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BIP39.h"
#import "carduino-support.h"
#import "cbc-bip39.h"
#import "cbip39.h"
#import "cindex_char.h"
#import "cprefix1.h"
#import "cprefix2.h"
#import "csuffix_array.h"
#import "bc-crypto-base.h"
#import "hmac.h"
#import "memzero.h"
#import "options.h"
#import "pbkdf2.h"
#import "sha2.h"

FOUNDATION_EXPORT double BIP39VersionNumber;
FOUNDATION_EXPORT const unsigned char BIP39VersionString[];

