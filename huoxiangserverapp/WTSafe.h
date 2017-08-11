//
//  WTSafe.h
//  huoxiangserverapp
//
//  Created by mc on 17/7/20.
//  Copyright © 2017年 huoxiangTongWang. All rights reserved.
//

#import <Foundation/Foundation.h>

//AES
@interface WTSafe : NSObject
/**< 加密方法 */
- (NSString*)aci_encryptWithAES:(NSString *)wtstring;

/**< 解密方法 */
- (NSString*)aci_decryptWithAES:(NSString *)wtstring;

@end
