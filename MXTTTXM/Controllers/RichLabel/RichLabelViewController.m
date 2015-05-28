//
//  RichLabelViewController.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "RichLabelViewController.h"
#import "M80AttributedLabel.h"

#define kM80ScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kM80ScreenHeight           [UIScreen mainScreen].bounds.size.height

@interface RichLabelViewController ()

@end

@implementation RichLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    M80AttributedLabel *label = [[M80AttributedLabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:15.f];
    label.textColor = [UIColor purpleColor];
    label.backgroundColor = [UIColor lightGrayColor];
    label.lineSpacing = 0.0;
    
    // 加一张图片
    [label appendImage:[UIImage imageNamed:@"logo.jpg"]
               maxSize:CGSizeMake(100, 100)
                margin:UIEdgeInsetsMake(0, 100, 0, 0)
             alignment:M80ImageAlignmentCenter];
    
    NSString *text  = @"\n有人问我为什么要去西藏\n谁都知道318这条天路难走又危险。[haha][haha][haha][haha]\n\t我回答道：“是内心驱使我去那里，因为那里有高原雪山，有哈达。”\n为了此次骑行，我辞掉工作并准备了很久，终于在2014年7月1日和队友们踏上了征途。\n\t除此之外[haha2]我喜欢骑行，其实并没有多么的热爱，就是喜欢而已，而318是每一位骑行者的终极梦想[haha][haha][haha]路途中困难重重，恶劣的天气[face37]以及物质的缺乏[face44][face43]，每天都要骑上几十甚至几百公里。[haha]下雨下雪下冰雹最为艰苦，手指僵硬导致很难抓紧刹车把，很多时候一下坡就是一百多公里。无论怎么样，再多的苦难都是值得的，痛并快乐着[face39]。\n[haha][haha1][haha2][face44][face43]\n\n  如果有一天我不见了，那我一定在西藏。[face41]\n  如果有一天我不见了，那我一定在西藏。[face41]\n  如果有一天我不见了，那我一定在西藏。[face41]";
    
    // 利用正则表达式找出文本内所有的表情名，也就是中括号里面的内容
    NSArray *emotes = [self match:text withRegex:@"(?<=\\[).*?(?=\\])"];
    
    // 在字符串内前后分别添加]和[，是为了方便找出表情两边的内容
    text = [NSString stringWithFormat:@"]%@[", text];
    // 如有换行，下面的正则表达式无法查出正确的内容（求高手帮忙写个咯），因此先把换行符转义了
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    // 找出表情两边的内容
    NSArray *texts  = [self match:text withRegex:@"(?<=\\]).*?(?=\\[)"];
    
    for (NSUInteger i = 0; i < [texts count]; i++) {
        NSString *s = [texts objectAtIndex:i];
        // 根据上面的转义替换成换行符，这样绘制的时候就能换行了
        s = [s stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        [label appendText:s];
        if (i < [texts count] - 1) {
            [label appendImage:[UIImage imageNamed:[emotes objectAtIndex:i]]
                       maxSize:CGSizeMake(20, 20)
                        margin:UIEdgeInsetsZero
                     alignment:M80ImageAlignmentBottom];
        }
    }
    // 获取label的size（参数是label的最大size）
    CGSize size = [label sizeThatFits:CGSizeMake(kM80ScreenWidth, 600)];
    label.frame = CGRectInset(CGRectMake(5, 100, size.width - 5*2, size.height),0, 0);
    [self.view addSubview:label];
}

- (NSArray *)match:(NSString *)string withRegex:(NSString *)regex {
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regex
                                                                                       options:NSRegularExpressionCaseInsensitive
                                                                                         error:&error];
    NSArray *matchResults = [regularExpression matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    NSString *tmpStr = @"";
    NSMutableArray *matchs = [NSMutableArray array];
    for (NSTextCheckingResult *match in matchResults) {
        NSRange matchRange = [match range];
        tmpStr = [string substringWithRange:matchRange];
        //        NSLog(@"=%@=", tmpStr);
        [matchs addObject:tmpStr];
    }
    return matchs;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
