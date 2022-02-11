//
//  main.m
//  odtest
//
//  Created by Rishi Chawda on 27/01/22.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <OpenDirectory/OpenDirectory.h>

int main(int argc, const char * argv[]) {
//    @autoreleasepool {
        NSArray *args = [[NSProcessInfo processInfo] arguments];
//        NSLog(@"args: %@", args);
        
        NSError *error;
        ODSession *session = [ODSession defaultSession];
        NSLog(@"Node names: %@", [session nodeNamesAndReturnError:&error]);
        ODNode *node = [ODNode nodeWithSession:session type:kODNodeTypeLocalNodes error:&error];
        
//        wip password management code

//        NSArray *supportedRecordTypes = [node supportedRecordTypesAndReturnError:&error];
//        NSMutableArray *filteredRecords = [NSMutableArray arrayWithCapacity:[supportedRecordTypes count]];
//        [supportedRecordTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            NSError *error;
//            ODRecord *recordExists = [node recordWithRecordType:kODRecordTypeUsers name:args[1] attributes:nil error:&error];
//            if(recordExists) {
//                [filteredRecords addObject:obj];
////                NSLog(@"records of type: %@", [node recordWithRecordType:obj name:args[1] attributes:nil error:&error]);
                ODRecord *record = [node recordWithRecordType:kODRecordTypeUsers name:args[1] attributes:nil error:&error];
//                NSString *name = [record recordName];
                BOOL verified = [record verifyPassword:args[2] error:&error];
////                NSLog(@"value %@", obj);
                if (verified) {
                    NSLog(@"verified");
//                    BOOL success = [record changePassword:args[2] toPassword:args[3] error:&error];
//                    if (success) {
//                        NSLog(@"updated password to %@", args[3]);
//                    } else {
//                        NSLog(@"failed to update password: %@", error);
//                    }
                } else {
                    NSLog(@"not verified");
                }
//            }
//        }];
//        NSLog(@"record types checked: %@", filteredRecords);

//        wip user management code
        
        NSDictionary *attr = @{
//            kODAttributeTypePresetUserIsAdmin: @true,
            kODAttributeTypePassword: args[2]
        };
        ODRecord *newrecord = [node createRecordWithRecordType:kODRecordTypeUsers name:args[1] attributes:attr error:&error];

        NSLog(@"created record: %@", newrecord);
//    }
    return 0;
}
