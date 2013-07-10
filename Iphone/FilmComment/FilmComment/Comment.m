#import "Comment.h"

@implementation Comment

@synthesize name, content, title;


+ (id)commentWithName:(NSString *)name content:(NSString *)content title:(NSString *)title cid:(NSString *)cid time:(NSString *)time
{
	Comment *newComment = [[[self alloc] init] autorelease];
	newComment.name = name;
    newComment.content = content;
    newComment.title = title;
    newComment.cid = cid;
    newComment.time = time;
	return newComment;
}


- (void)dealloc
{
	[name release];
    [content release];
    [title release];
    [cid release];
    [time release];
	[super dealloc];
}

@end