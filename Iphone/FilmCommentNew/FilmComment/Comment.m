#import "Comment.h"

@implementation Comment

@synthesize name, content;


+ (id)commentWithName:(NSString *)name content:(NSString *)content
{
	Comment *newFilm = [[[self alloc] init] autorelease];
	newFilm.name = name;
    newFilm.content = content;
	return newFilm;
}


- (void)dealloc
{
	[name release];
    [content release];
	[super dealloc];
}

@end