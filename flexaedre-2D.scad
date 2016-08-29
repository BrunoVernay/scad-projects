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


function hauteur_triangle_isocele(base, cote_congru) =
  sqrt( pow(cote_congru, 2) -pow(base/2, 2) );


// Angles face aux petits cotés
Aa = acos( (a/2) / c );
Ba = (180-90)/2;      // acos( (a/2) / b ); 
Ca = acos( (b/2) / c );

Ah = hauteur_triangle_isocele(a, c);
Bh = a/2;     // B a un angle droit!
echo("Hauteur Bh=", Bh, " = ", hauteur_triangle_isocele(a, b));
Ch = hauteur_triangle_isocele(b, c);

module triangle_isocele(base, cote_congru) {
 polygon([
    [0, 0],
    [base, 0],
    [base/2, hauteur_triangle_isocele( base, cote_congru)]
    ]);
};

color ("Silver") {
    
  triangle_isocele(a, c);

  rotate(-(180-90)/2) 
    mirror([0,1,0]) triangle_isocele(b, c);
 
  translate([+a/2,0,0])  mirror([1,0,0]) 
  translate([-a/2,0,0]) 
    rotate(-Ba) 
    mirror([0,1,0]) triangle_isocele(b, c);

/* Another solution:
    translate([a,0,0]) 
    rotate(Ba) translate([-b,0,0]) 
    mirror([0,1,0]) triangle_isocele(b, c);
*/
}

// Optionnel (pour coller l'intérieur)
color ("LightGrey") offset(delta=-1) {
  
  translate([a,0,0]) 
    rotate(180-Aa-Ca)
    triangle_isocele(b, c);

  rotate(-Ba-Ca-Aa)
    triangle_isocele(a, c);

  rotate(-Ba)    
    translate([b,0,0]) 
    rotate( -(90 +2*Ca -180) )
    triangle_isocele(b, c);

}
