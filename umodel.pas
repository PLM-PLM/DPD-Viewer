unit uModel;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math;

const

  Xmin = -1.0;    // boîte de simulation
  Xmax =  1.0;
  Ymin = -1.0;
  Ymax =  1.0;
  a_   = 1.0;     // constante de répulsion
  g_   = 3.0;     // coefficient de friction
  kT_  = 1.0;     // température réduite
  dt   = 0.05;   // default time step

type
  vec2D = array[1..2] of double;

var
  Np: Integer  = 10;      // nombre de particules
  XY, XY1: array of array[1..3] of array[1..2] of double;
// XY[i,1,k] = position (x,y)
// XY[i,2,k] = vitesse  (vx,vy)
// XY[i,3,k] = accélération (ax,ay)

procedure InitParticules();
procedure ShowParticules();
procedure F3();
procedure Verlet();

implementation

// ========================
// Bruit gaussien N(0,1)
// ========================
function RandNorm: double;
var s: double; k: integer;
begin
  s := 0;
  for k := 1 to 12 do s += Random;  // somme de 12 U[0,1] ~ N(6,1)
  Result := s - 6.0;
end;

// ========================
// Conditions périodiques
// ========================
procedure ApplyPBC(var x, y: double);
var
  Lx, Ly: double;
begin
  Lx := Xmax - Xmin;
  Ly := Ymax - Ymin;
  while x < Xmin do x := x + Lx;
  while x > Xmax do x := x - Lx;
  while y < Ymin do y := y + Ly;
  while y > Ymax do y := y - Ly;
end;

// ========================
// Vecteur unité r_ij avec
// convention de la distance
// minimum image
// ========================
function uvec(i1, i2, J: integer; out nrm: double): vec2D;
var
  dx, dy, Lx, Ly: double;
  lu: vec2D;
begin
  dx := XY[i2,J,1] - XY[i1,J,1];
  dy := XY[i2,J,2] - XY[i1,J,2];
  Lx := Xmax - Xmin;
  Ly := Ymax - Ymin;

  if dx >  0.5*Lx then dx -= Lx else
  if dx < -0.5*Lx then dx += Lx;

  if dy >  0.5*Ly then dy -= Ly else
  if dy < -0.5*Ly then dy += Ly;

  nrm := sqrt(dx*dx + dy*dy);

  if nrm <> 0 then
  begin
    lu[1] := dx / nrm;
    lu[2] := dy / nrm;
  end
  else
  begin
    lu[1] := 0; lu[2] := 0;
  end;
  Result := lu;
end;

// ========================
// Initialisation
// ========================
procedure InitParticules();
var i: integer;
begin
  SetLength(XY,  Np+1);
  SetLength(XY1, Np+1);

  for i := 1 to Np do
  begin
    XY[i,1,1] := (Xmax - Xmin) * Random + Xmin;  // x
    XY[i,1,2] := (Ymax - Ymin) * Random + Ymin;  // y
    XY[i,2,1] := 0; XY[i,2,2] := 0;  // vitesse
    XY[i,3,1] := 0; XY[i,3,2] := 0;  // accélération
  end;
end;

// ========================
// Affichage console
// ========================
procedure ShowParticules();
var i: integer;
begin
  Writeln('**** ', Np, ' Particules ****');
  for i := 1 to Np do
    Writeln(Format('P%d: Pos(%.3f, %.3f)  V(%.3f, %.3f)  A(%.3f, %.3f)',
      [i,
       XY[i,1,1], XY[i,1,2],
       XY[i,2,1], XY[i,2,2],
       XY[i,3,1], XY[i,3,2]]));
end;

// ========================
// Forces DPD : F3()
// ========================
procedure F3();
var
  i1, i2: integer;
  rij: vec2D;
  rij_, omega, Fc_, Fd_, Fr_, dvx, dvy, rij_dot_vij: double;
  dF: vec2D;
begin
  // Reset accélérations
  for i1 := 1 to Np do
  begin
    XY[i1,3,1] := 0;
    XY[i1,3,2] := 0;
  end;

  // Double boucle particules
  for i1 := 1 to Np do
    for i2 := i1+1 to Np do
    begin
      rij := uvec(i1, i2, 1, rij_);
      omega := 0;
      if rij_ < 1 then
        omega := (1 - rij_) * (1 - rij_);

      // Conservative
      Fc_ := 0;
      if rij_ < 1 then
        Fc_ := a_ * (1 - rij_);

      // Dissipative
      dvx := XY[i2,2,1] - XY[i1,2,1];
      dvy := XY[i2,2,2] - XY[i1,2,2];
      rij_dot_vij := rij[1]*dvx + rij[2]*dvy;
      Fd_ := -g_ * omega * rij_dot_vij;

      // Random
      Fr_ := sqrt(2.0*g_*kT_) * RandNorm() * sqrt(omega);

      // Total force
      dF[1] := (Fc_ + Fd_ + Fr_) * rij[1];
      dF[2] := (Fc_ + Fd_ + Fr_) * rij[2];

      // Action-réaction
      XY[i1,3,1] += dF[1];
      XY[i1,3,2] += dF[2];
      XY[i2,3,1] -= dF[1];
      XY[i2,3,2] -= dF[2];
    end;
end;

// ========================
// Intégrateur de Verlet
// ========================
procedure Verlet;
var
  i: integer;
//  a_old_x, a_old_y: array of double;
begin
//  SetLength(a_old_x, Np+1); // <-- Trop cher computationellement
//  SetLength(a_old_y, Np+1);

  // Sauvegarde accélérations dans XY1
  for i := 1 to Np do
  begin
    XY1[i,3,1] := XY[i,3,1];
    XY1[i,3,2] := XY[i,3,2];
    //a_old_x[i] := XY[i,3,1];
    //a_old_y[i] := XY[i,3,2];
  end;

  // Positions
  for i := 1 to Np do
  begin
    XY[i,1,1] += XY[i,2,1]*dt + 0.5*XY1[i,3,1]*dt*dt;
    XY[i,1,2] += XY[i,2,2]*dt + 0.5*XY1[i,3,2]*dt*dt;
    ApplyPBC(XY[i,1,1], XY[i,1,2]);
  end;

  // Nouvelles accélérations
  F3();

  // Vitesses
  for i := 1 to Np do
  begin
    XY[i,2,1] += 0.5*(XY1[i,3,1] + XY[i,3,1])*dt;
    XY[i,2,2] += 0.5*(XY1[i,3,2] + XY[i,3,2])*dt;
  end;
end;

end.
