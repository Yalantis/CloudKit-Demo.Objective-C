
<p align="center" >
  <img src="https://github.com/Yalantis/CloudKit-Demo.Objective-C/blob/master/CloudKit-objc.png" alt="CloudKit" title="CloudKit">
</p>

CloudKit, Apple’s remote data storage service, provides a possibility to store app data using users’ iCloud accounts as a back-end storage service.

Here is the same demo on [Swift](https://github.com/Yalantis/CloudKit-Demo.Swift).

## Requirements
iOS 8.0

## How To Get Started

- Set up Cloud/CloudKit at iOS Developer Portal.
- Insert bundle identifier and choose a corresponding Team.
- Select the Capabilities tab in the target editor, and then switch ON the iCloud.

For more detailed information take a look at [our article](http://yalantis.com/blog/work-cloudkit/).

## Usage

### Retrieve existing records
```objective-c
NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
CKQuery *query = [[CKQuery alloc] initWithRecordType:@"RecordType" predicate:predicate];
    
[[CKContainer defaultContainer].publicCloudDatabase performQuery:query
                                                    inZoneWithID:nil
                                                completionHandler:^(NSArray *results, NSError *error) {
                                                  
}];
```
### Create a new record
```objective-c
CKRecord *record = [[CKRecord alloc] initWithRecordType:@"RecordType"];
record[@"key"] = @"Some data";
[[CKContainer defaultContainer].publicCloudDatabase saveRecord:record completionHandler:^(CKRecord *record, NSError *error) {

}];
```

### Updating the record
```objective-c
CKRecordID *recordID = [[CKRecordID alloc] initWithRecordName:@"recordId"];
[[CKContainer defaultContainer].publicCloudDatabase fetchRecordWithID:recordID completionHandler:^(CKRecord *record, NSError *error) {
        
  if (error) {
    return;
  }
        
  record[@"key"] = @"Some data";
  [[CKContainer defaultContainer].publicCloudDatabase saveRecord:record completionHandler:^(CKRecord *record, NSError *error) {

  }];
}];
```
### Remove the record
```objective-c
CKRecordID *recordID = [[CKRecordID alloc] initWithRecordName:@"recordId"];
[[CKContainer defaultContainer].publicCloudDatabase deleteRecordWithID:recordID completionHandler:^(CKRecordID *recordID, NSError *error) {

}];
```

## Contacts

[Yalantis](http://yalantis.com)

Follow Yalantis on Twitter ([@Yalantis](https://twitter.com/yalantis))

## License

    The MIT License (MIT)

    Copyright © 2015 Yalantis

    Permission is hereby granted free of charge to any person obtaining a copy of this software and associated documentation files (the "Software") to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
    
