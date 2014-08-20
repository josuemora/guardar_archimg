//
//  ViewController.m
//  guardar_archimg
//
//  Created by josue mora on 13/08/14.
//  Copyright (c) 2014 josue mora. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *paths;
    NSString *path_descargas;
    NSString *path_plist;
    NSString *path_imagenes;
    NSString *DirDocumentos;
    NSFileManager *fileManager;
    NSString *archivo_plist;
    
    NSArray *IMGS;
    NSString *rutaIMGS;
    NSString *httpimage;
    NSString *fileimage;
    
    NSURL *tmpURL;
    NSData *datosexternos;
    
}

@end

@implementation ViewController
@synthesize scroll_img,txt_datos;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    fileManager     = [NSFileManager defaultManager];
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    DirDocumentos   = [paths objectAtIndex:0];
    path_descargas  = [DirDocumentos stringByAppendingPathComponent:@"descargas"];
    path_plist      = [path_descargas stringByAppendingPathComponent:@"plist"];
    path_imagenes   = [path_descargas stringByAppendingPathComponent:@"imagenes"];
    archivo_plist   = [path_plist stringByAppendingPathComponent:@"archivo.plist"];
    
    IMGS    = @[@"2621200.png",@"4260204.png",@"9007001.png",
                @"9501015.png",@"9503031.png",@"9511013.png",
                @"9515033.png",@"9519030.png",@"9704111.png",
                @"9704251.png"];
    rutaIMGS = @"https://www.omnilife.com/shopping/images/nvo/productos/mex/detail/";
    httpimage = @"";
    fileimage = @"";

    tmpURL = [NSURL URLWithString:@"http://qa.omnilife.com/zpruebas/ws_practica6.php?tipo=PLIST"];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
    
}

- (IBAction)btn_traer:(id)sender {
    
    //limpiar todo
    [self btn_limpiar:nil];
    
    //Crear folder descargas,plist e imagenes...
    if (![fileManager fileExistsAtPath:path_descargas]){
        [fileManager createDirectoryAtPath:path_descargas withIntermediateDirectories:NO attributes:nil error:nil];
        [fileManager createDirectoryAtPath:path_plist withIntermediateDirectories:NO attributes:nil error:nil];
        [fileManager createDirectoryAtPath:path_imagenes withIntermediateDirectories:NO attributes:nil error:nil];
    }

    datosexternos = [NSData dataWithContentsOfURL:tmpURL];
    [datosexternos writeToFile:archivo_plist atomically:YES];
    
    //NSLog(@"dir plist %@ %@",path_plist,archivo_plist);
 
   
    for( NSString * tmpS in IMGS){
        httpimage = [rutaIMGS stringByAppendingPathComponent:tmpS];
        fileimage = [path_imagenes stringByAppendingPathComponent:tmpS];
        NSLog(@" %@    imagen %@",fileimage,httpimage);
        datosexternos = [NSData dataWithContentsOfURL:[NSURL URLWithString:httpimage]];
        [datosexternos writeToFile:fileimage atomically:YES];
    }

        [[[UIAlertView alloc] initWithTitle:@"Transferencia" message:@"terminada!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
}

- (IBAction)btn_ver_archivo:(id)sender {
    
    txt_datos.text = [[NSString alloc] initWithContentsOfFile:archivo_plist encoding:NSUTF8StringEncoding error:nil];


}

- (IBAction)btn_ver_imagenes:(id)sender {
    int xInc = 0;
    int yInc = 0;
    int contador = 1;
    int xleft = 160;
    int ytop = 160;
    int btnes_linea = 2;
    
    
    int xpadding = 5;
    int ypadding = 5;
    
    int width_img  = 141;
    int height_img = 135;
    int xleft_img  = 45;
    int ytop_img   = 10;
    
    
    
    for( NSString * tmpS in IMGS){
        fileimage = [path_imagenes stringByAppendingPathComponent:tmpS];
        UIImage * img = [[UIImage alloc] initWithContentsOfFile:fileimage];

        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(xpadding + xInc + xleft_img, ypadding + yInc + ytop_img, width_img, height_img)];
        imgView.image = img;
        [scroll_img addSubview:imgView];
        xInc = contador % btnes_linea ? xInc + xleft : 0;
        yInc = contador % btnes_linea ? yInc : yInc + ytop;
        contador = contador + 1;
        
    }

    [scroll_img setContentSize:CGSizeMake(xleft * btnes_linea ,((int)(contador  / btnes_linea)+1) * ytop )];
    
    
    
}

- (IBAction)btn_limpiar:(id)sender {

    //eliminamos todo el contenido de la carpeta descargas...
    [fileManager removeItemAtPath:path_descargas error:nil];
    
    //limpiamos contenido de text datos...
    txt_datos.text = @"";
    

    //elimina todo el contenido del scroll_img...
    [scroll_img clearsContextBeforeDrawing];
    for(UIView *subview in [scroll_img subviews]) {
        [subview removeFromSuperview];
    }

}
@end
