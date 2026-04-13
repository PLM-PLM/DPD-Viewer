unit uxDPD;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, DBGrids, TASeries, TAGraph, TASources, uModel,BufDataset, Db, Types, Crt;

type

  { TfrmDPD }

  TfrmDPD = class(TForm)
    btOK: TButton;
    Chart1LineSeries1: TLineSeries;
    ChtViewParticle: TChart;
    ChtViewParticleLineSeries1: TLineSeries;
    EdtNp: TEdit;
    EdtStep: TEdit;
    Label1: TLabel;
    ChrtSrcParticle: TListChartSource;
    Label2: TLabel;
    Label3: TLabel;
    mmData: TMemo;
    pcParam: TPageControl;
    tbsOutput: TTabSheet;
    tbsParam: TTabSheet;
    procedure EdtNpChange(Sender: TObject);
    procedure EdtStepChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure mmDataChange(Sender: TObject);
    procedure TabSheet2ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    Image1: TImage;
    procedure DrawParticles;
    procedure UpdateShowParticle;
  public
  end;

var
  frmDPD: TfrmDPD;
  ParticleColor: array of TColor;

implementation

{$R *.lfm}

procedure TfrmDPD.FormCreate(Sender: TObject);
begin

end;

procedure TfrmDPD.EdtNpChange(Sender: TObject);
begin

end;

procedure TfrmDPD.EdtStepChange(Sender: TObject);
begin

end;

procedure TfrmDPD.btOKClick(Sender: TObject);
var
  dt: double;
  step: integer;
  Nsteps: integer;
begin
  // Show output page
  pcParam.PageIndex := 1;
  Application.ProcessMessages;

  // Lecture des paramètres
  Np := StrToInt(EdtNp.Text);
  Nsteps := StrToInt(EdtStep.Text);
  step := 0;

  // Génère une couleur aléatoire pour chaque particule
  SetLength(ParticleColor, Np+1);
  Randomize;
  for step := 1 to Np do
  ParticleColor[step] := RGBToColor(Random(256), Random(256), Random(256));

  // Initialisation du modèle
  InitParticules();
  F3();

  // View Initial situation
  DrawParticles;
  Application.ProcessMessages;

  // Verlet integration
  dt:=0.0004;
  for step:=1 to Nsteps do
  begin
    Verlet();
    UpdateShowParticle();
    Delay(100);
    Application.ProcessMessages;
    mmData.Lines.Add('Step: '+IntToStr(step));
  end;

end;

procedure TfrmDPD.mmDataChange(Sender: TObject);
begin

end;

procedure TfrmDPD.TabSheet2ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TfrmDPD.DrawParticles;
var
  i: integer;
  S: String;
begin
  // Efface les anciens points du graphique
  ChrtSrcParticle.Clear;

  // Ajoute les nouvelles positions des particules
  mmData.Lines.Add('--- Début de la simulation ---');
  for i := 1 to Np do

  begin
   ChrtSrcParticle.Add(XY[i, 1, 1], XY[i, 1, 2]);

   // Rentre les données des différentes particules dans le mmData
   S:=Format('P%d: Pos(%.3f, %.3f)  V(%.3f, %.3f)  A(%.3f, %.3f)',
      [i,XY[i,1,1],XY[i,1,2],XY[i,2,1], XY[i,2,2],XY[i,3,1], XY[i,3,2]]);
   mmData.Lines.Add(S);
  end;
  mmData.Lines.Add('--- Simulation terminée ---');

end;

procedure TfrmDPD.UpdateShowParticle;
var
  i, i1: integer;
  S: String;
begin
  for i:=1 to Np do
  begin
    i1:=i-1;
    ChrtSrcParticle.SetXValue(i1,XY[i,1,1]);
    ChrtSrcParticle.SetYValue(i1,XY[i,1,2]);
    S:=Format('P%d: Pos(%.3f, %.3f)  V(%.3f, %.3f)  A(%.3f, %.3f)',
      [i,XY[i,1,1],XY[i,1,2],XY[i,2,1], XY[i,2,2],XY[i,3,1], XY[i,3,2]]);
   mmData.Lines.Add(S);
  end;
  ChtViewParticle.Repaint;

end;

end.
