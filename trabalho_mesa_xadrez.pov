// PoVRay 3.7 Scene File " ... .pov"
// author:  ...
// date:    ...
//--------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
#include "shapesq.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare quarto = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <14.0 , 7.0 ,14.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 2.0 , 0.0>}
#declare cadeira = camera {/*ultra_wide_angle*/ angle 90   // diagonal view
                            location  <0, 7.5 ,1>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 7.5>}
#declare pe_mesa = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare topo_tabuleiro = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 6.75 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare lustre = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 4.5 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 9 , 0.0>}                           
camera{lustre}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
light_source{ <-1000, 800, 3000> 
              color White
              looks_like{ sphere{ <0,0,0>,300 
                                  texture{ pigment{ color White }
                                           normal { bumps 0.5
                                                    scale 50    }
                                           finish { ambient 0.8   
                                                    diffuse 0.2
                                                    phong 1     }
                                                  
                                         } // end of texture
                                } // end of sphere
                        } //end of looks_like
            } //end of light_source
            
// create a point "spotlight" (conical directed) light source
light_source {
  <0,9,0> // position of a coner of the light plane
  color Gray85
  area_light <3, 0, 0>, <0, 3, 0>, 2, 2 // light plane's edges; m by n bulbs
// adaptive 1 // if on, some rays will not be traced
// jitter // randomization of bulb's positions, emulating fuzzy shadow edges
}
// sky --------------------------------------------------------------------
  // the dark blue
plane{ <0,1,0>,1 hollow  
       texture{ pigment { color rgb <0.20, 0.20, 1.0> }
                finish  { ambient 0.25 diffuse 0 } 
              }      
       scale 10000}
  // the clouds 
plane{<0,1,0>,1 hollow  
       texture{pigment{ bozo turbulence 0.76
                        color_map { [0.5 rgbf<1.0,1.0,1.0,1.0> ]
                                    [0.6 rgb <1.0,1.0,1.0>     ]
                                    [1.0 rgb <0.5,0.5,0.5>     ]}
                       }
               finish { ambient 0.25 diffuse 0} 
              }      
       scale 500}
// ground ------------------------------------------------------------------

plane { <0,1,0>, 0 
        texture { pigment{ color rgb<0.35,0.65,0.0>*0.72}
                  normal { bumps 0.75 scale 0.015  }
                  finish { phong 0.1 }
                }
      }
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



#declare peao =
    union {
        cylinder { <0,0,0>,<0,0.10,0>, 0.30               
                   scale <0.4,0.4,0.4> rotate<0,0,0> translate<0,0,0>
                 } // end of cylinder -------------------------------------        
        cone { <0,0,0>,0.25,<0,1,0>,0         
               scale <0.4,0.4,0.4> rotate<0,0,0> translate<0,0,0>         
             } // end of cone -------------------------------------
        cylinder { <0,0.7,0>,<0,0.8,0>, 0.20        
               scale <0.4,0.4,0.4> rotate<0,0,0> translate<0,0,0>
             } // end of cylinder -------------------------------------    
        sphere { <0,0.004,0>, 0.18               
                  scale <0.4,0.4,0.4>  rotate<0,0,0>  translate<0,0.37,0>  
               }  // end of sphere ----------------------------------- 
    }

#declare torre =    
    union {
        cylinder{<0,0,0> <0,2,0> 0.3}   
        cylinder{<0,1.8,0> <0,1.9,0> 0.5}
        cone { <0,0,0>,0.45,<0,2,0>,0 scale <1,1,1> rotate<0,0,0> translate<0,0,0>} // end of cone -------------------------------------
    
        difference{
            // CILINDRO TOPO
            cylinder{<0,2,0> <0,2.4,0> 0.5} 
            cylinder{<0,2,0> <0,2.5,0> 0.4} 
            // JANELAS
            box{ <1,2.1,-0.1> <-1,2.5,0.1>} 
            box{ <1,2.1,-0.1> <-1,2.5,0.1> rotate y*120}
            box{ <1,2.1,-0.1> <-1,2.5,0.1> rotate y*240}
            }
        cylinder{<0,0,0> <0,0.2,0> 0.5}
    }   
    

#declare cavalo = union {
   intersection {
      object { Cylinder_Z      
         scale <17.875, 17.875, 1>
         translate <-18.625, 7, 0>
         inverse
      }
      object { Cylinder_Z      
         scale <17.875, 17.875, 1>
         translate <18.625, 7, 0>
         inverse
      }
      object { Cylinder_X
         scale <1, 5.1, 5.1>
         translate <0, 11.2, -5>
         inverse
      }

      union {
         plane { y, 0
            rotate 30*x
            translate 9.15*y
         }
         
         plane { z, 0
            rotate -20*x
            translate 10*y         
         }
      }
      union {
         plane { -y, 0
            rotate 30*x
            translate 7.15*y                           
         }
         plane { y, 0
            rotate 60*x
            translate 7.3*y                    
         }
      }
      union {
         plane { y, 0
            rotate -45*y
                
         }
         plane { y, 0
            rotate 45*z
                        
         }
         translate 9*y
      }

      object { Cylinder_Y 
      scale <2, 1, 2>}
      sphere { <0, 7, 0>, 4
        scale<1,1,1>
      }
   }

   sphere { <0, 0, 0>, 1               
      scale <2.5, 0.5, 2.5>
      translate <0, 2.8, 0>
   }
}

#declare base =
    union {
        intersection {
           sphere { <0, 0, 0>, 3 }
           plane { -y, 0 }
        }
        cylinder { 0, y*0.35, 3.0 pigment { green 0.65 } }
    }

#declare bispo = union {
   sphere { <0, 10.8, 0>, 0.4 }

   intersection {
      union {
         plane { -z, -0.25 }
         plane { +z, -0.25 }
         plane { y, 0  }
         rotate 30*x
         translate 8.5*y
      }

      sphere { <0, 0, 0>, 1 
         scale <1.4, 2.1, 1.4>
         translate 8.4*y
      }

      plane { -y, -7 }
   }

   sphere { <0, 0, 0>, 1
      scale <1.5, 0.4, 1.5>
      translate 7*y
   }

   intersection {
      plane { y, 7 }
      object {
         Hyperboloid_Y
         scale <0.6, 1.4, 0.6>
         translate 7*y
      }
      plane { -y, -3 }
   }

   sphere { <0, 0, 0>, 1
      scale <2.5, 0.5, 2.5>
      translate 2.8*y
   }

}


#declare reiErainha = union {
   sphere { <0, 10.5, 0>, 1.5 }

   intersection {
      union {
         sphere { <1.75, 12, 0>, 0.9  rotate 150*y }
         sphere { <1.75, 12, 0>, 0.9  rotate 120*y }
         sphere { <1.75, 12, 0>, 0.9  rotate 90*y }
         sphere { <1.75, 12, 0>, 0.9  rotate 60*y }
         sphere { <1.75, 12, 0>, 0.9  rotate 30*y }
         sphere { <1.75, 12, 0>, 0.9  }
         sphere { <1.75, 12, 0>, 0.9  rotate -30*y }
         sphere { <1.75, 12, 0>, 0.9  rotate -60*y }
         sphere { <1.75, 12, 0>, 0.9  rotate -90*y }
         sphere { <1.75, 12, 0>, 0.9  rotate -120*y }
         sphere { <1.75, 12, 0>, 0.9  rotate -150*y }
         sphere { <1.75, 12, 0>, 0.9  rotate  180*y }
         inverse
      }

      plane { y, 11.5 }

      object { QCone_Y
         scale <1, 3, 1>
         translate 5*y
      }

      plane { -y, -8 }
   }

   sphere { <0, 0, 0>, 1
      scale <1.8, 0.4, 1.8>
      translate 8*y
   }

   intersection {
      plane { y, 8 }
      object { Hyperboloid_Y
         scale <0.7, 1.6, 0.7>
         translate 7*y
      }
      plane { -y, -3 }
   }

   sphere { <0, 0, 0>, 1
      scale <2.5, 0.5, 2.5>
      translate 2.8*y
   }

   object { base }
}

#declare rainha = union {
   sphere { <0, 12.3, 0>, 0.4 }
   object { reiErainha }
}

#declare rei = union {
   intersection {
      union {
         intersection {
            plane { y, 13 }
            plane { -y, -12.5 }
         }

         intersection {
            plane { +x, 0.25 }
            plane { -x, 0.25 }
         }
      }

      plane { +z,  0.25 }
      plane { -z,  0.25 }
      plane { +x,  0.75 }
      plane { -x,  0.75 }
      plane { +y,  13.5  }
      plane { -y,  -11.5  }
   }

   object { reiErainha }
}


//-----------------------------------------------------------------------------------------

//quarto
union{
    //chao
    box { <-15.00, 0.00, -15.00>,< 15.00, 0.05, 15.00>   
               texture{ T_Wood7     
                normal { wood 0.5 scale 0.05 turbulence 0.1 rotate<0,0,0> }
                finish { phong 1 } 
                rotate<0,0,0> scale 0.5 translate<0,0,0>
              } // end of texture 



          scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
        } // end of box --------------------------------------
    //paredes     
    box { <-15, 0.00, 14.8>,<15, 10, 15>   
        texture{ pigment{ color rgb< 1, 1, 1>*0.85} 
                normal { bozo 2 scale 0.050 }
                finish { phong 1 reflection{ 0.05 } }
              } // end of texture
          scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
        } // end of box --------------------------------------
    box { <15, 0.00, -14.8>,<-15, 10, -15>   
        texture{ pigment{ color rgb< 1, 1, 1>*0.85} 
                normal { bozo 2 scale 0.050 }
                finish { phong 1 reflection{ 0.05 } }
              } // end of texture
          scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
        } // end of box --------------------------------------

    box { <-14.8, 0.00, 15>,<-15, 10, -15>   
        texture{ pigment{ color rgb< 1, 1, 1>*0.85} 
                normal { bozo 2 scale 0.050 }
                finish { phong 1 reflection{ 0.05 } }
              } // end of texture
    }
    box { <14.8, 0.00, -15>,<15, 10, 15>   
        texture{ pigment{ color rgb< 1, 1, 1>*0.85} 
                normal { bozo 2 scale 0.050 }
                finish { phong 1 reflection{ 0.05 } }
              } // end of texture
       }
    //teto
    box { <-15.00, 9.9, -15.00>,< 15.00, 10, 15.00>   
            texture { T_Grnt23
                   //normal { agate 0.15 scale 0.15}
                   finish { phong 0.5 } 
                   scale 1 
                 } // end of texture 

          scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
        }    
    //lampada
    object{ Octahedron 
        scale <1,1,1>
        texture { pigment{ color rgb< 0.75, 0.5, 1.0> }
                  normal { bumps 0.85 scale 0.05 }
                  finish { phong 1 reflection{ 0.30 metallic 0.30 } } 
                }
        scale <0.6,0.6,0.6>*1.00 rotate<0, 0,0> translate<0,9,0>
       } // end of object


}

//mesa
union{
    //superficie
    intersection {
     
        box { <-3.00, 7.00, -3.00>,< 3.00, 8.00, 3.00>   
        
              texture { T_Wood12
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,0.5,1> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
        
        
        
        box { <-3.5, 7.00, -3.5>,< 3.5, 8.00, 3.5>   
        
              texture { T_Wood12
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,0.5,1> rotate<0,50,0> translate<0,0,0> 
            } // end of box --------------------------------------
    }
    //perna
    union {
        box { <-1.00, 0.00, -1.00>,< 1.00, 8.00, 1.00>   
        
              texture {T_Wood12
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <0.2,0.5,0.2> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
        //base
        union {
            box { <-1.00, 0.00, -1.00>,< 1.00, 0.2, 1.00>   
                
                  texture {T_Wood12     
                            finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                          } // end of texture
            
                  scale <0.9,1,0.9> rotate<0,0,0> translate<0,0,0> 
                } // end of box --------------------------------------
        
                    box { <-1.00, 0.00, -1.00>,< 1.00, 0.5, 1.00>   
                
                  texture { T_Wood12 
                            finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                          } // end of texture
            
                  scale <0.5,1,0.5> rotate<0,0,0> translate<0,0,0> 
                } // end of box --------------------------------------
            }
        }

}

//tabuleiro

union {
    box{<-9 ,7,-9> <9,8.5,9> 
        texture{T_Stone13 scale 10 }
        scale <0.15,0.5,0.15>
    } 
    box{<-8,7,-8> <8,8.501,8> texture{ checker
                                     texture{scale 10 pigment {  color rgb<0,0,0>} finish {brilliance 4 }}
                                     texture{pigment{ color rgb<1,1,1>} finish {brilliance 0.5 }  scale 10 rotate<90,90,90>} 
                                     scale 2
                                 }  
    scale <0.15,0.5,0.15>}  
    //peças claras
    object{ peao scale <0.8,0.8,0.8> translate<1.05,4.24,0.75> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } 
    }
    object{ peao scale <0.8,0.8,0.8> translate<0.75,4.24,0.75> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }
    object{ peao scale <0.8,0.8,0.8> translate<0.45,4.24,0.75> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }
    object{ peao scale <0.8,0.8,0.8> translate<0.15,4.24,0.75> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }
    object{ peao scale <0.8,0.8,0.8> translate<-0.15,4.24,0.75> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }
    object{ peao scale <0.8,0.8,0.8> translate<-0.45,4.24,0.75> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } } 
    object{ peao scale <0.8,0.8,0.8> translate<-0.75,4.24,0.75> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }
    object{ peao scale <0.8,0.8,0.8> translate<-1.05,4.24,0.75> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }
    object{ torre scale <0.2,0.17,0.2> translate<1.05,4.24,1.05> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }
    object{ torre scale <0.2,0.17,0.2> translate<-1.05,4.24,1.05> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }
    object{ cavalo scale <0.05,0.065,0.05> translate<0.75,4.05,-1.05> rotate <0,180,0> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }
    object{ cavalo scale <0.05,0.065,0.05> translate<-0.75,4.05,-1.05> rotate <0,180,0> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }
    object {bispo scale<0.05,0.05,0.05> translate<-0.45,4.11,-1.05> rotate <0,180,0> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }
    object {bispo scale<0.05,0.05,0.05> translate<0.45,4.11,-1.05> rotate <0,180,0> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }
    object {rei scale<0.05,0.05,0.05> translate<-0.15,4.11,1.05> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }
    object {rainha scale<0.05,0.05,0.05> translate<0.15,4.11,1.05> material{
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                } 
        interior{ ior 1.5 caustics 0.5
        }
      } }


     
    //peças escuras
    object{peao scale <0.8,0.8,0.8> translate<-1.05,4.24,-0.75> texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object{peao scale <0.8,0.8,0.8> translate<-0.75,4.24,-0.75>texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object{peao scale <0.8,0.8,0.8> translate<-0.45,4.24,-0.75>texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object{peao scale <0.8,0.8,0.8> translate<-0.15,4.24,-0.75>texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object{peao scale <0.8,0.8,0.8> translate<0.15,4.24,-0.75>texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object{peao scale <0.8,0.8,0.8> translate<0.45,4.24,-0.75>texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object{peao scale <0.8,0.8,0.8> translate<0.75,4.24,-0.75>texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object{peao scale <0.8,0.8,0.8> translate<1.05,4.24,-0.75>texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object{torre scale <0.2,0.17,0.2> translate<-1.05,4.24,-1.05> texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object{torre scale <0.2,0.17,0.2> translate<1.05,4.24,-1.05>texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object{cavalo scale <0.05,0.065,0.05> translate<0.75,4.05,-1.05> texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object{cavalo scale <0.05,0.065,0.05> translate<-0.75,4.05,-1.05> texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object {bispo scale<0.05,0.05,0.05> translate<-0.45,4.11,-1.05>texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object {bispo scale<0.05,0.05,0.05> translate<0.45,4.11,-1.05> texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object {rei scale<0.05,0.05,0.05> translate<0.15,4.11,-1.05>texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
    object {rainha scale<0.05,0.05,0.05> translate<-0.15,4.11,-1.05>texture {T_Chrome_1A normal { bumps 0.5 scale 0.15} finish { phong 1}}}
}   

  
  

//cadeira 1
union{
    //assento
    union {
        //assento madeira
        box { <-1.2, 2, 4.00>,<1.00, 2.5, 6.500>   
        
              texture { T_Wood12  
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
        //almofada
        object{ // Round_Box(A, B, WireRadius, UseMerge)
                Round_Box(<-1.2, 2.4, 4.00>,< 1.00, 2.6, 6.400>, 0.25   , 0)  
                texture{ pigment{ color rgb<1,1,1> }
                normal { pigment_pattern{
                            average pigment_map{[1, gradient z sine_wave]
                                                [1, gradient y scallop_wave]
                                                [3, bumps  ]}
                                         translate 0.02 scale 0.5}
                                         2 
                         rotate< 0,0,0> scale 0.15 } // end normal
                finish { phong 1 reflection{ 0.2 } }
              } // end of texture ------------------------------------------
                scale<1,1,1>  rotate<0, 0,0> translate<0,0.1,0>
              } // ---------------------------------------------------------
    }
    //encosto
    union {
        //encosto madeira
        box { <-1.2, 2, 6.00>,< 1.00,6, 6.500>   
        
              texture { T_Wood12 
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
        //almofada
        object{ // Round_Box(A, B, WireRadius, UseMerge)
            Round_Box(<-1.0, 3, 5.90>,< 0.8,5.5, 6.400>, 0.25   , 0)  
                texture{ pigment{ color rgb<1,1,1> }
                normal { pigment_pattern{
                            average pigment_map{[1, gradient z sine_wave]
                                                [1, gradient y scallop_wave]
                                                [3, bumps  ]}
                                         translate 0.02 scale 0.5}
                                         2 
                         rotate< 0,0,0> scale 0.15 } // end normal
                finish { phong 1 reflection{ 0.2 } }
              } // end of texture ------------------------------------------

            scale<1,1,1>  rotate<0, 0,0> translate<0,0.1,0>
          } // ---------------------------------------------------------  
    }
    //pernas
    union{
        //perna 1    
        box { <0.5, 0, 6.00>,< 1,2.5, 6.500>   
        
              texture { T_Wood12  
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
        //perna 2    
        box { <0.5, 0, 4.00>,< 1,2.5, 4.500>   
        
              texture { T_Wood12 
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
        //perna 3
        box { <-1.2, 0, 6.00>,<-0.7, 2.5, 6.500>   
        
              texture { T_Wood12 
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
        //perna 4   
        box { <-1.2, 0, 4.00>,<-0.7 ,2.5, 4.500>   
        
              texture { T_Wood12  
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
        }
            
}

//cadeira 2
union{
    //assento
    union {
        //assento madeira
        box { <1.2, 2, -4.00>,< -1.00,2.5, -6.500>   
              texture { T_Wood12  
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
          
        //almofada
        object{ // Round_Box(A, B, WireRadius, UseMerge)
                Round_Box(<1.2, 2.4, -4.00>,<-1.00, 2.6, -6.500>, 0.25   , 0)  
                texture{ pigment{ color rgb<1,1,1> }
                normal { pigment_pattern{
                            average pigment_map{[1, gradient z sine_wave]
                                                [1, gradient y scallop_wave]
                                                [3, bumps  ]}
                                         translate 0.02 scale 0.5}
                                         2 
                         rotate< 0,0,0> scale 0.15 } // end normal
                finish { phong 1 reflection{ 0.2 } }
              } // end of texture ------------------------------------------

                scale<1,1,1>  rotate<0, 0,0> translate<0,0.1,0>
              } // ---------------------------------------------------------
    }
    //encosto
    union {
        //encosto madeira
        box { <1.2, 2, -6.00>,< -1.00, 6, -6.500>           
              texture { T_Wood12  
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
          //almofada
        object{ // Round_Box(A, B, WireRadius, UseMerge)
            Round_Box(<1.0, 3, -5.90>,< -0.8, 5.5, -6.4>, 0.25   , 0)  
                texture{ pigment{ color rgb<1,1,1> }
                normal { pigment_pattern{
                            average pigment_map{[1, gradient z sine_wave]
                                                [1, gradient y scallop_wave]
                                                [3, bumps  ]}
                                         translate 0.02 scale 0.5}
                                         2 
                         rotate< 0,0,0> scale 0.15 } // end normal
                finish { phong 1 reflection{ 0.2 } }
              } // end of texture ------------------------------------------

            scale<1,1,1>  rotate<0, 0,0> translate<0,0.1,0>
          } // ---------------------------------------------------------  
    }
    //pernas
    union{
        //perna 1
        box { <-0.5, 0, -6.00>,< -1, 2.5, -6.500>   
        
              texture {T_Wood12 
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
        //perna 2    
        box { <-0.5, 0, -4.00>,<-1, 2.5, -4.500>   
        
              texture { T_Wood12 
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
        //perna 3
        box { <1.2, 0, -6.00>,<0.7, 2.5, -6.500>   
        
              texture { T_Wood12  
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
        //perna 4   
        box { <1.2, 0, -4.00>,<0.7 ,2.5, -4.500>   
        
              texture { T_Wood12  
                        finish { phong 1 reflection{ 0.00 metallic 0.00} } 
                      } // end of texture
        
              scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
            } // end of box --------------------------------------
        }
            
}