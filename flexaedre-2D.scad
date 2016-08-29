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
Aa = acos( (a/2) / c );
Ba = (180-90)/2;      // acos( (a/2) / b ); 
Ca = acos( (b/2) / c );

Ah = hauteur_triangle_isocele(a, c);
Bh = a/2;     // B a un angle droit!
echo("Hauteur Bh=", Bh, " = ", hauteur_triangle_isocele(a, b));
Ch = hauteur_triangle_isocele(b, c);

module triangle(gc, pc) {
 polygon([
    [0,0],
    [gc,0],
    [gc/2, hauteur_triangle_isocele(gc,pc)]
    ]);
};

color ("Silver") {
    
  triangle(a, c);

  rotate(-(180-90)/2) 
    mirror([0,1,0]) triangle(b, c);
 
  translate([+a/2,0,0])  mirror([1,0,0]) 
  translate([-a/2,0,0]) 
    rotate(-Ba) 
    mirror([0,1,0]) triangle(b, c);

/* Another solution:
    translate([a,0,0]) 
    rotate(Ba) translate([-b,0,0]) 
    mirror([0,1,0]) triangle(b, c);
*/
}

// Optionnel (pour coller l'intérieur)
color ("LightGrey") {

  translate([a,0,0]) 
    rotate(180-Aa-Ca)
    triangle(b, c);

    rotate(-Ba-Ca-Aa)
    triangle(a, c);

    rotate(-Ba)    
    translate([b,0,0]) 
    rotate( -(90 +2*Ca -180) )
    triangle(b, c);

}
