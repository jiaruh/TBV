//
//  ViewController.m
//  TBV
//
//  Created by jiaruh on 2017/10/1.
//  Copyright © 2017年 jiaruh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource>{
    NSArray *arr1;
    NSArray *arr2;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //String->data->NSJSonSerialization
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"Notes" ofType:@"json"];
    //NSData *jsondata = [[NSData alloc] initWithContentsOfFile:path];
    //NSDictionary *jsonobj = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
    
    //String->inputStream->NSJSonSerialization
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"Notes" ofType:@"json"];
    //NSInputStream *inputJson = [NSInputStream inputStreamWithFileAtPath:path];
    //[inputJson open];
    //NSDictionary *jsonobj = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:&error];
    //***
    //[inputJson close];

//  url->data->inputStream->NSJSonSerialization
    NSURL *url = [NSURL URLWithString:@"http://teachers.ren/Notes.json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSInputStream *inputJson = [NSInputStream inputStreamWithData:data];
 

    //URL->Strram 暂且行不通
    //NSURL *url = [NSURL URLWithString:@"http://teachers.ren/Notes.json"];
    //NSInputStream *inputJson = [NSInputStream inputStreamWithURL:url];
    
    [inputJson open];
    NSError *error;
    NSDictionary *jsonobj = [NSJSONSerialization JSONObjectWithStream:inputJson options:NSJSONReadingMutableContainers error:&error];
    if(!jsonobj||error){
        NSLog(@"解码失败");
    }else{
        arr1 =jsonobj[@"Record"];
    }
    [inputJson close];
   // arr1 = [[NSArray alloc] initWithObjects:@1,@2,@3,@4,@5,@6,@7,@8,nil];
  //  arr2 = [[NSArray alloc] initWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h", nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[arr1 objectAtIndex:indexPath.row] valueForKey:@"Content"];
    NSLog(@"%@",cell.textLabel.text);
    //cell.detailTextLabel.text = [arr2 objectAtIndex:indexPath.row];
    UIImage *image = [UIImage imageNamed:@"apple_logo-128"];
    cell.imageView.image = image;
    return  cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arr1 count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"页眉";
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"页脚";
}

@end
