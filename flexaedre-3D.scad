a=141; b=100; c=87;

function hauteur_triangle_isocele(grand_cote, petit_cote) =
  // TODO: Utiliser min/max pour eviter les erreurs
  sqrt( pow(petit_cote, 2) -pow(grand_cote/2, 2) );

// https://en.wikipedia.org/wiki/Law_of_cosines#Applications
// donne l'angle en face du coté "c":
function regle_du_cosinus(a,b,c) = 
    acos( 
        ( pow(a, 2) + pow(b, 2) -pow(c, 2) )
        / (2*a*b)        
    );

// Angles face aux petits cotés
Aa = acos( (141/2) /  87 );
Ba = (180-90)/2; // acos( (141/2) / 100 ); 
Ca = acos( (100/2) /  87 );

Ah = hauteur_triangle_isocele(141, 87);
Bh = 141/2;     // B a un angle droit!
echo(Bh, " = ", hauteur_triangle_isocele(141, 100));
Ch = hauteur_triangle_isocele(100, 87);

module triangle(gc, pc) {
  polyhedron(
    points =[
      [0,0,0],
      [gc,0,0],
      [gc/2, hauteur_triangle_isocele(gc,pc),0]
    ],
    faces = [[0,1,2]]);
/* polygon([
    [0,0],
    [gc,0],
    [gc/2, hauteur_triangle_isocele(gc,pc)]
    ]);*/
};

color("Red") {
  // Pliage (3D folding)
    // Il faut un triangle qui coupe perpendiculairement 
    // l'axe de rotation
    // Donc 3 axes, 3 triangles ...
    
    // On plie: Ah -> Bh
    AB = regle_du_cosinus( Ah, Bh, 87 );
    
    // Second pliage: B -> C
    // Soit "B2" la moitié de "B"
    B2h = hauteur_triangle_isocele(100, 141/2);
    BC = regle_du_cosinus( Ch, B2h, Ah );
    
    // Pliage  C -> A
    Cab = 100*sin(Ca);
    Ahypo = cos(Ca)*100/cos(Aa);
    Abc = Ahypo*sin(Aa);
    Bca =sqrt( pow(100, 2) +pow(Ahypo, 2) -2*100*Ahypo*cos(Ba));
    CA = regle_du_cosinus( Cab, Abc, Bca );   
    
   // projection(cut = false)
   rotate(180-CA,[cos(-Ba-Ca),sin(-Ba-Ca),0])
   rotate(180-BC,[141/2,-Bh,0])
   rotate(180-AB,[1,0,0])
    triangle(141, 87);
}

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

/* Bien plus simple que le pliage:
    rotate(-Ba-Ca-Aa)
    triangle(141, 87);
*/
    rotate(-Ba)    
    translate([100,0,0]) 
    rotate(-(90+2*Ca -180))
    triangle(100, 87);

}
