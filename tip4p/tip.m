#! /usr/bin/octave -q

[];

function y = aa_to_cart(x)
  %% Conversion from angle-axis (x) to Cartesian (y)
  %% coordinates. Input x must have an even number of rows (n). 1..n/2
  %% are the oxygen positions.  n/2+1..n are the angle-axis
  %% coordinates. Output y are the Cartesian coordinates in angstrom
  %% for all atoms, with 3*n rows. The atoms are in the sequence O-H-H-O-...
  %% See: Appendix A in Wales, Phil. Trans. R. Soc. A (2005) 363, 357-377.

  ## Reference geometry
  doh = 0.9572;
  ang = 104.52 * pi / 180 / 2;
  R0 = [
        0 0 0 ## oxygen
        doh*sin(ang), 0, -doh*cos(ang) ## hydrogen1
        -doh*sin(ang), 0, -doh*cos(ang) ## hydrogen2
  ];

  n2 = floor(rows(x)/2);
  y = zeros(3*n2,3);
  k = 0;
  for i = 1:n2
    xpos = x(i,:);
    nlm = x(n2+i,:);
    alpha = norm(nlm);
    p = nlm / alpha;
    for j = 1:3
      y(++k,:) = xpos + R0(j,:) * cos(alpha) + (p * R0(j,:)') * p * (1-cos(alpha)) + cross(R0(j,:),p) * sin(alpha);
    endfor
  endfor
endfunction

function writexyz(y)
  %% Write an xyz file to standard output from the Cartesian
  %% coordinates for a water cluster in y. The atom order is
  %% assumed to be O-H-H-O-H...

  nat = rows(y)/3;
  printf("%d\n\n",rows(y));
  for i = 1:rows(y)/3
    printf("O %.10f %.10f %.10f\n",y((i-1)*3+1,:));
    printf("H %.10f %.10f %.10f\n",y((i-1)*3+2,:));
    printf("H %.10f %.10f %.10f\n",y((i-1)*3+3,:));
  endfor

endfunction

function x = cart_to_aa(y)
  %% Conversion from Cartesian(y) to angle-axis coordinates (x).  y
  %% must have a number of rows that is a multiple of 3. The order of
  %% the atoms must be O-H-H-O-... On output, x contains 2*n rows,
  %% where n is the number of atoms. The first 1...n rows are the 
  %% positions of the oxygen atoms. The n+1...2*n rows are the 
  %% axis-angle vectors.
  %% See: Appendix A in Wales, Phil. Trans. R. Soc. A (2005) 363, 357-377.
  %% Requires the quaternion package.

  pkg load quaternion;

  ## reference geometry
  doh = 0.9572;
  ang = 104.52 * pi / 180 / 2;
  xoref = [0 0 0];
  xh1ref = [doh*sin(ang), 0, -doh*cos(ang)];
  xh2ref = [-doh*sin(ang), 0, -doh*cos(ang)];

  nat = rows(y)/3;

  x = zeros(2*nat,3);
  k = 0;
  for i = 1:nat
    xt = y((i-1)*3+1,:);

    xo  = y((i-1)*3+1,:) - xt;
    xh1 = y((i-1)*3+2,:) - xt;
    xh2 = y((i-1)*3+3,:) - xt;

    e(:,1) = xh1';
    e(:,2) = cross(e(:,1),xh2');
    e(:,3) = cross(e(:,1),e(:,2));

    eref(:,1) = xh1ref';
    eref(:,2) = cross(eref(:,1),xh2ref');
    eref(:,3) = cross(eref(:,1),eref(:,2));

    [axis,angle] = q2rot(rotm2q(e * inv(eref)));
    nlm = -axis * angle;
    x(++k,:) = xt;
    x(nat+k,:) = nlm;
  endfor

endfunction

function etip = tip4p(x)
  %% Calculates the TIP4P energy for a water cluster given in
  %% angle-axis coordinates. Adapted from the GMIN source code, by
  %% Wales et al.

  ## The reference geometry. The TIP4P model has four sites: the two H
  ## atoms (rows 2 and 3), the O atom (row 1), and a ghost atom (row
  ## 4) that contains the negative charge. The LJ potential energy is
  ## calculated using the O atoms only.
  nsite = 4;
  doh = 0.9572;
  ang = 104.52 * pi / 180 / 2;
  site = [
          0 0 0
          doh*sin(ang), 0, -doh*cos(ang) ## hydrogen1
          -doh*sin(ang), 0, -doh*cos(ang) ## hydrogen2
          0 0 -0.15
  ];

  ## The tip4p charges for the four sites and LJ parameters for the O atom.
  C6=2552.24;
  C12=2510.4D3;
  charge = [0 0.52 0.52 -1.04];

  nmol = floor(rows(x)/2);
  etip=0.0D0;
  for J1 = 1:nmol-1
    x1 = x(J1,:);
    l1 = x(nmol+J1,:);
    alpha1 = norm(l1);
    ca1 = cos(alpha1);
    c2a1 = ca1;
    if (alpha1 < 0.0001)
      c3a1=-0.5D0+alpha1^2/24.0D0;
      s1=1.0D0-alpha1^2/6;
    else
      c3a1=(ca1-1.0D0)/alpha1^2;
      s1=sin(alpha1)/alpha1;
    endif
    for J2=J1+1:nmol
      x2 = x(J2,:);
      l2 = x(nmol+J2,:);
      alpha2=norm(l2);
      ca2=cos(alpha2);
      c2a2=ca2;
      if (alpha2 < 0.00001D0)
        c3a2=-0.5D0+alpha2^2/24.0D0;
        s2=1.0D0-alpha2^2/6;
      else
        c3a2=(ca2-1.0D0)/alpha2^2;
        s2=sin(alpha2)/alpha2;
      endif

      %% LJ contribution
      dist=norm(x1-x(J2,:));
      dummy=(C12/dist^6-C6)/dist^6;

      %% electrostatic contribution
      for K1=2:nsite
        P1X=site(K1,1);
        P1Y=site(K1,2);
        P1Z=site(K1,3);
        for K2=2:nsite
          P2X=site(K2,1);
          P2Y=site(K2,2);
          P2Z=site(K2,3);
          dist=sqrt((c2a1*P1X-c3a1*l1(1)*(l1(1)*P1X+l1(2)*P1Y+l1(3)*P1Z)-c2a2*P2X+c3a2*l2(1)*(l2(1)*P2X + l2(2)*P2Y + l2(3)*P2Z)+...
                     (l1(3)*P1Y - l1(2)*P1Z)*s1 - (l2(3)*P2Y - l2(2)*P2Z)*s2 + x1(1) - x2(1))^2 +...
                    (c2a1*P1Y - c3a1*l1(2)*(l1(1)*P1X + l1(2)*P1Y + l1(3)*P1Z) - c2a2*P2Y+c3a2*l2(2)*(l2(1)*P2X+l2(2)*P2Y+l2(3)*P2Z)+...
                     (-(l1(3)*P1X) + l1(1)*P1Z)*s1 - (-(l2(3)*P2X) + l2(1)*P2Z)*s2 + x1(2)-x2(2))^2 +...
                    (c2a1*P1Z - c3a1*l1(3)*(l1(1)*P1X + l1(2)*P1Y + l1(3)*P1Z) - c2a2*P2Z+c3a2*l2(3)*(l2(1)*P2X+l2(2)*P2Y+l2(3)*P2Z)+...
                     (l1(2)*P1X - l1(1)*P1Y)*s1 - (l2(2)*P2X - l2(1)*P2Y)*s2 + x1(3) - x2(3))^2);
          dummy=dummy+1389.354848D0*(charge(K1)*charge(K2)/dist);
        endfor
      endfor
      etip=etip+dummy;
    endfor
  endfor
endfunction

## Example: a relatively stable water hexamer.

x = [
     -1.0983082325504558          1.4498914582697009          1.8082708052982048     
     1.4802840469638612          -2.0915114063961808          0.50138775628175847     
     0.14654237227165115          -0.85958346496029958          2.5350376233368843     
     -2.1770081868960385          1.2711694451027995          -0.67960367892183104     
     -0.32375978339758571          0.65086047712719919          -2.5803762919024553     
     1.9722497836085677          -0.42082650914321912          -1.5847162140925612     
     -0.36774597790294733          -0.88702113603333621          1.8215089911024442     
     -2.5494224437618693          3.0958802988689094          -0.42829058193268071     
     -2.1443807015836991          1.3235301043633179          -1.2254795745784770     
     6.0494581085018115          -1.8677826820395638          -2.9152114524331449     
     5.2992196089611150E-002     1.0752593781043240          0.42754124061959164     
     -3.2557425267117135          -1.0946026999113436          0.91331042793875850     
];

etip = tip4p(x)
