//
//  SDMLogsUI.h
//  SDMLogger
//
//  Created by Nyisztor Karoly on 6/2/11.
//  Copyright 2011 SAP AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "SDMLogger.h"

/**
 * Subclassing from UIViewController to be able to respond to shouldAutorotateToInterfaceOrientation delegate method
 */
@interface MAFAutorotatingLogViewController : UIViewController
@end


/**
 * Skinnable Logs UI
 */
@interface MAFLogViewer : MAFAutorotatingLogViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
{
	// array holding the log entries
	NSArray* m_LogEntries;
	
	// the view controller, which's view is on the top of the view hierarchy, so it will raise the ModalView
	UIViewController* m_ParentModalViewController;
    
    UINavigationController* m_NavController;
    
}

//-(id) initWithLogs:(NSArray*) logEntries_in;

@property (nonatomic, retain) NSArray* logEntries;
@property (nonatomic, retain) UIViewController* parentModalViewController;

//We need to check the presentingViewController, because if no UIViewController subclass is added to the view Hierarchy (for example in the case of showing a modalView with UIDropShadowView (grey background on iPad))
@property (nonatomic, assign) BOOL isOtherViewControllerAddedToWindow;

/**
 * Shows a table view with the provided logs, logs must contain LogMessage and LogLevel property.
 * @remark Default skin type applies (native iOS colors); consider using showLogsUIWithSkinType: to set a different skin
 * @throws SDMSupportabilityException
 */
+(void) showLogs:(NSArray*) logs_in;

/**
 * Shows a table view with the provided logs using the skin type passed as parameter
 * @remark If the default iPhone color scheme is all right for you, consider using showLogs rather
 * @param skinType one of the LogonSkinType values
 * @throws SDMSupportabilityException
 */
+(void) showLogs:(NSArray*)logs_in withSkinType:(LogSkinType) skinType_in;

+ (LogSkinType) skinType;

/**
 * Dismisses the LogonUI
 * @discussion Can be called by clients to dismiss the Logon UI programmatically. Usually you should not do that, but we provide the API for convenience.
 */
+ (void)dismiss;

/**
 * Regulates whether the view should respond to device oriantation changes
 */
+(void) setShouldAutoRotateView:(BOOL) isAutorotating_in;


/**
 * Set the email adrees where the logs are sent
 */
+(void) setToRecipients:(NSArray*)recipients;

/**
 * Sets the client delegate
 * @remark Protocol to be adapted by client classes in order to hook in for didSetCredentials, didCancelLogon and didFailEnteringCredentials delegates
 */
//+(void) setDelegate:(id<SDMLogsUIDelegate>)delegate_in;

#pragma mark -
#pragma mark Accessors
//@property (nonatomic, assign, readonly) LogonSkinType skinType;

/**
 * Sample Code
 * [SDMLogger enableLogging];
 * [MAFLogViewer setToRecipients:[NSArray arrayWithObject:@"Peter@SAPHungary.com"]];
 * [MAFLogViewer showLogs: [[SDMLogger instance] retrieveLogsWithLevel:MAFEmergencyLoggingLevel]];
*/
@end
