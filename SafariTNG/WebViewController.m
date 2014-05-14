//
//  ViewController.m
//  SafariTNG
//
//  Created by Ryan Tiltz on 5/14/14.
//  Copyright (c) 2014 Ryan Tiltz. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation WebViewController

- (void)viewDidLoad


{
    [super viewDidLoad];

     [self goToUrlString:@"http://www.mobilemakers.co"];


}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"loading failed :(";
    alert.message = error.localizedDescription;
    [alert addButtonWithTitle:@"That Sucks For You!"];
    [alert addButtonWithTitle:@"No Place Like Home."];
    alert.delegate = self;
    [alert show];
    [self.spinner stopAnimating];

}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self goToUrlString:@"http://www.mobilemakers.co"];
    }
}

-(void)goToUrlString: (NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
}
//The TextField checks if it has a delagate when ENTER is pressed within it
//The TextField's delegate is this ViewController instance (self)
//The TextField check if textFieldShouldReturn: is implemented on its delegate
//The TextField calls textFieldShould Return: if it is implemented


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
     [self goToUrlString: textField.text];


    //Dismisses Keyboard.
    [textField resignFirstResponder];
    
    return YES;

}


@end
