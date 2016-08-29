/*
Flexaèdre "HyperQBS"
B. Vernay 2016-08-28

https://www.youtube.com/watch?v=Kg3_gLO-reE

http://www.openscad.org/
*/

b = 100; 
a = b * sqrt(2);    // 141;  
c = b * sqrt(3)/2;  // 87;
echo("Taille des cotés: a=",a, " b=",b, " c=",c, "." );


function hauteur_triangle_isocele(grand_cote, petit_cote) =
  // TODO: Utiliser min/max pour eviter les erreurs
  sqrt( pow(petit_cote, 2) -pow(grand_cote/2, 2) );


// Angles face aux petits cotés
Aa = acos( (141/2) /  87 );
Ba = (180-90)/2; // acos( (141/2) / 100 ); 
Ca = acos( (100/2) /  87 );

Ah = hauteur_triangle_isocele(141, 87);
Bh = 141/2;     // B a un angle droit!
echo("Hauteur Bh=", Bh, " = ", hauteur_triangle_isocele(141, 100));
Ch = hauteur_triangle_isocele(100, 87);

module triangle(gc, pc) {
 polygon([
    [0,0],
    [gc,0],
    [gc/2, hauteur_triangle_isocele(gc,pc)]
    ]);
};

color ("Silver") {
    
  triangle(141, 87);

  rotate(-(180-90)/2) 
    mirror([0,1,0]) triangle(100, 87);
 
  translate([+141/2,0,0])  mirror([1,0,0]) 
  translate([-141/2,0,0]) 
    rotate(-Ba) 
    mirror([0,1,0]) triangle(100, 87);

/* Another solution:
    translate([141,0,0]) 
    rotate(Ba) translate([-100,0,0]) 
    mirror([0,1,0]) triangle(100, 87);
*/
}


color ("LightGrey") {

  translate([141,0,0]) 
    rotate(180-Aa-Ca)
    triangle(100, 87);

    rotate(-Ba-Ca-Aa)
    triangle(141, 87);

    rotate(-Ba)    
    translate([100,0,0]) 
    rotate(-(90+2*Ca -180))
    triangle(100, 87);

}
