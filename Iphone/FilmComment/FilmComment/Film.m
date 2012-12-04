#import "Film.h"

@implementation Film

@synthesize url, name;


+ (id)productWithUrl:(NSString *)url name:(NSString *)name img:(UIImage *)img performer:(NSString *)performer
{
	Film *newFilm = [[[self alloc] init] autorelease];
	newFilm.url = url;
	newFilm.name = name;
    newFilm.img = img;
    newFilm.performer = performer;
	return newFilm;
}


- (void)dealloc
{
    [performer release];
    [img release];
	[url release];
	[name release];
	[super dealloc];
}

@end
