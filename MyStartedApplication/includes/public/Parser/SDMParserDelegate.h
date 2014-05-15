//
//  SDMParserDelegate.h
//  SDMParser
//
//  Created by Farkas, Zoltan on 04/22/11.
//  Copyright 2011 SAP AG. All rights reserved.
//


#import <Foundation/Foundation.h>



/**
 * @deprecated
 */
__attribute((deprecated("Use ODataParserDelegate instead")))
@protocol SDMParserDelegate<NSObject>

@required

-(void) startDocument;
-(void) endDocument;
-(void) startElement:(NSString* const)elementName namespaceURI:(NSString* const)namespaceURI attributes:(NSDictionary* const)attributes;
-(void) endElement:(NSString* const)elementName namespaceURI:(NSString* const)namespaceURI;
-(void) characters:(NSString* const)string;

@end
