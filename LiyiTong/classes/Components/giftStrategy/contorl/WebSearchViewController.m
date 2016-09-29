//
//  WebSearchViewController.m
//  LiyiTong
//
//  Created by zhangtijie on 16/9/29.
//  Copyright © 2016年 WanYu. All rights reserved.
//

#import "WebSearchViewController.h"

@interface WebSearchViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *WebView;

@end

@implementation WebSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.URL]];
    self.WebView.scalesPageToFit =YES;
    self.WebView.delegate =self;
 
    [self.WebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"stasrt");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *url =  [webView.request.URL path];
    NSLog(@"url=%@",url);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
//    [alterview release];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
