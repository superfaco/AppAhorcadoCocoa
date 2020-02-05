//
//  AhorcadoController.m
//  AppAhorcadoCocoa
//
//  Created by Fernando Alfonso Caldera Olivas on 03/03/19.
//  Copyright © 2019 Fernando Alfonso Caldera Olivas. All rights reserved.
//

#import "AhorcadoController.h"

@implementation AhorcadoController

- (IBAction)btnJuegoNuevoClick:(id)sender {
    _tfLetraAProbar.enabled = true;
    _btnProbar.enabled = true;
    _tfLetraAProbar.stringValue = @"";
    
    [_imgView setImage:[NSImage imageNamed:@"ahorcadovacio"]];
    
    int x;
    switch(_cbxDificultad.indexOfSelectedItem){
        case FACIL:
            _lblIntentosRestantes.intValue = 7;
            srand((int)time(NULL));
            x = rand() % palabrasFaciles.count;
            palabraActual = palabrasFaciles[x];
            break;
        case MEDIA:
            _lblIntentosRestantes.intValue = 5;
            srand((int)time(NULL));
            x = rand() % palabrasMedias.count;
            palabraActual = palabrasMedias[x];
            break;
        case DIFICIL:
            _lblIntentosRestantes.intValue = 3;
            srand((int)time(NULL));
            x = rand() % palabrasDificiles.count;
            palabraActual = palabrasDificiles[x];
            break;
    }
    
    //Llenamos el label de la palabra a encontrar con
    //_
    palabraActualUI = [NSMutableString stringWithString: @"_"];
    for(int i = 1; i < palabraActual.length; i++){
        palabraActualUI = [NSMutableString stringWithFormat:@"%@ _", palabraActualUI];
    }
    noAciertos = 0;
    _lblPalabraAEncontrar.stringValue = palabraActualUI;
}
- (IBAction)btnProbarClick:(id)sender {
    
    NSString* letraAux = _tfLetraAProbar.stringValue;
    _btnProbar.enabled = false;
    _tfLetraAProbar.enabled = false;
    bool huboCoincidencias = false;
    if(letraAux.length == 1){
        char letra = [letraAux characterAtIndex:0];
        //Buscamos las coinicidencias de la letra
        //en la palabra actual, al mismo tiempo que vamos
        //generando una nueva cadena a en la palabra.
        
        if([palabraActual characterAtIndex:0] == letra){
            [palabraActualUI replaceCharactersInRange:NSMakeRange(0, 1) withString:[NSString stringWithFormat:@"%c", letra]];
            huboCoincidencias = true;
            noAciertos++;
        }
        
        for(int i = 1, j = 2; i < palabraActual.length; i++, j+=2){
            if([palabraActual characterAtIndex:i] == letra){
                [palabraActualUI replaceCharactersInRange:NSMakeRange(j, 1) withString:[NSString stringWithFormat:@"%c", letra]];
                huboCoincidencias = true;
                noAciertos++;
            }
        }
        
        //Actualizamos el storyboard
        _lblPalabraAEncontrar.stringValue = palabraActualUI;
        
        if(!huboCoincidencias){
            _lblIntentosRestantes.intValue--;
        }
        
        if(_lblIntentosRestantes.intValue == 0){
            [_imgView setImage: [NSImage imageNamed:@"ahorcadolleno"]];
        }
        
    }
    
    if(_lblIntentosRestantes.intValue == 0 || noAciertos == palabraActual.length){
        _tfLetraAProbar.stringValue = @"";
    }
    
    if(_lblIntentosRestantes.intValue > 0 && noAciertos < palabraActual.length){
        _tfLetraAProbar.enabled = true;
        _btnProbar.enabled = true;
    }
}

-(void) awakeFromNib{
    //Preparamos el storyboard
    _btnJuegoNuevo.enabled = false;
    _tfLetraAProbar.enabled = false;
    _btnProbar.enabled = false;
    _lblIntentosRestantes.stringValue = @"";
    _lblPalabraAEncontrar.stringValue = @"";
}

-(id) init{
    self = [super init];
    if(self){
        palabraActual = @"";
        palabraActualUI = [NSMutableString stringWithString: @""];
        
        noAciertos = 0;
        
        //Entre 3 y 5 letras
        palabrasFaciles = @[
                     @"casa",
                     @"carro",
                     @"perro",
                     @"gato",
                     @"dia",
                     @"sol",
                     @"sal",
                     @"taza",
                     @"tubo",
                     @"risa",
                     @"leon",
                     @"villa",
                     @"bola"
                     ];
        
        //Entre 6 y 8 letras
        palabrasMedias = @[
                           @"babeando",
                           @"caballo",
                           @"gabinete",
                           @"habanero",
                           @"obedecer",
                           @"tabernas",
                           @"lealtad",
                           @"hablado",
                           @"sabana",
                           @"jabones",
                           @"labios",
                           @"labora",
                           @"objeto",
                           @"obispo"
                           ];
        
        //Entre 9 y más letras
        palabrasDificiles = @[
                              @"constitucion",
                              @"ferrocarril",
                              @"constitucionalista",
                              @"ferrocarrilero",
                              @"electroencefalografista",
                              @"otorrinolaringologo",
                              @"analfabetismo",
                              @"telecomunicaciones",
                              @"electrocardiograma",
                              @"magnetoencefalografia",
                              @"carbonificacion",
                              @"desfeminizacion",
                              @"desmovilizacion",
                              @"invisibilizacion"
                              ];
    }
    return self;
}
- (IBAction)cbxDificultadValueChanged:(id)sender {
    _cbxDificultad.enabled = false;
    NSString* s = _cbxDificultad.stringValue;
    if([s isEqualToString:@""]){
        //Si no ha seleccionado y deslecciona,
        //reiniciamos la forma
        [self awakeFromNib];
    }else{
        //Habilitamos boton de juego nuevo
        _btnJuegoNuevo.enabled = true;
    }
    _cbxDificultad.enabled = true;
}
@end
