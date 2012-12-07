#import "FilmObj.h"

@implementation FilmObj

@synthesize url, name;


+ (id)productWithUrl:(NSString *)url name:(NSString *)name img:(NSString *)imgUrl introduce:(NSString *)introduce
{
	FilmObj *newFilm = [[[self alloc] init] autorelease];
	newFilm.url = url;
	newFilm.name = name;
    newFilm.imgUrl = imgUrl;
    newFilm.introduce = introduce;
	return newFilm;
}


- (void)dealloc
{
    [introduce release];
    [imgUrl release];
	[url release];
	[name release];
	[super dealloc];
}

@end
