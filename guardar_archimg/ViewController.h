//
//  ViewController.h
//  guardar_archimg
//
//  Created by josue mora on 13/08/14.
//  Copyright (c) 2014 josue mora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)btn_traer:(id)sender;
- (IBAction)btn_ver_archivo:(id)sender;
- (IBAction)btn_ver_imagenes:(id)sender;
- (IBAction)btn_limpiar:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *txt_datos;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll_img;

@end
