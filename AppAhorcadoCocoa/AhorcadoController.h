//
//  AhorcadoController.h
//  AppAhorcadoCocoa
//
//  Created by Fernando Alfonso Caldera Olivas on 03/03/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

enum Dificultades{
    FACIL = 0,
    MEDIA,
    DIFICIL
};

@interface AhorcadoController : NSObject{
    NSArray* palabrasFaciles;
    NSArray* palabrasMedias;
    NSArray* palabrasDificiles;
    NSString* palabraActual;
    NSMutableString* palabraActualUI;
    NSInteger noAciertos;
}
@property (weak) IBOutlet NSTextField *lblIntentosRestantes;
@property (weak) IBOutlet NSComboBox *cbxDificultad;
- (IBAction)cbxDificultadValueChanged:(id)sender;
@property (weak) IBOutlet NSButton *btnJuegoNuevo;
- (IBAction)btnJuegoNuevoClick:(id)sender;
@property (weak) IBOutlet NSTextField *lblPalabraAEncontrar;
@property (weak) IBOutlet NSTextField *tfLetraAProbar;
@property (weak) IBOutlet NSButton *btnProbar;
- (IBAction)btnProbarClick:(id)sender;
@property (weak) IBOutlet NSImageView *imgView;
@end
