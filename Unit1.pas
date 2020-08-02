unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, SuperObject;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    TreeView1: TTreeView;
    Panel1: TPanel;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure ParseItemsIntoTreeView(node: TTreeNode; itemData: ISuperObject);
    function _s(i: integer; padLeftWith0Count: integer = 0): string;
    function _i(s: String; default: integer = 0): Integer;
    function  DateFromSQL(const ASQLDate: String): TDateTime;
    function  DateIndoShort (const ADate: TDate):String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var
  s, v: string;
  curv,
  iso: ISuperObject;
  item: TSuperObjectIter;
  tvi: TTreeNode;
begin
  s := Memo1.Text;
  TreeView1.Items.BeginUpdate;
  try
    TreeView1.Items.Clear;
    tvi := TreeView1.Items.AddFirst(nil, 'Parsed Data:');
    tvi.ImageIndex := 0;
    if (s = '') or (s = '{}') then
    begin
      TreeView1.Items.AddChild(tvi, 'Tidak ada data...').ImageIndex := 5;
    end
    else
    begin
      iso := so(s);
      ParseItemsIntoTreeView(tvi, iso);
    end;
  finally
    TreeView1.Items.EndUpdate;
    TreeView1.Items[0].Expand(false);
    TreeView1.Items[0].MakeVisible;
  end;
end;

function TForm1.DateFromSQL(const ASQLDate: String): TDateTime;
begin
  try
    Result := EncodeDate(
      _i(Copy(ASQLDate,1,4)),
      _i(Copy(ASQLDate,6,2)),
      _i(Copy(ASQLDate,9,2))
    );
  except
    Result := Date();
  end;
end;

function TForm1.DateIndoShort(const ADate: TDate): String;
begin
  Result := FormatDateTime('dd/MM/yyyy', ADate);
end;

procedure TForm1.ParseItemsIntoTreeView(node: TTreeNode; itemData: ISuperObject);
var
  curv: ISuperObject;
  cura: TSuperArray;
  item: TSuperObjectIter;
  tvi: TTreeNode;
  s, v, dv: string;
  i: integer;
begin
  try
    if ObjectFindFirst(itemData, item) then
    repeat
      s := item.key;
      v := '';
      if item.val.IsType(stString) then
      begin
        v := item.val.AsString;
        dv := copy(v,1,10);
        // '2020-06-04'
        if
          (length(dv)>=10) and
          (dv[5] = '-') and (dv[8] = '-') and
          (_s(_i( copy(dv,1,4) ,0)) = copy(dv,1,4)) and
          (_s(_i( copy(dv,6,2) ,0),2) = copy(dv,6,2)) and
          (_s(_i( copy(dv,9,2) ,0),2) = copy(dv,9,2))
        then
        begin
          TreeView1.Items.AddChild(node, s+': '+DateIndoShort(DateFromSQL(dv))+' '+copy(v,11,length(v)))

        end
        else
          TreeView1.Items.AddChild(node, s+': '+v)
      end
      else
      if item.val.IsType(stBoolean) then
      begin
        v := BoolToStr(item.val.AsBoolean, true);
        TreeView1.Items.AddChild(node, s+': '+v)
      end
      else
      if item.val.IsType(stInt) then
      begin
        v := FloatToStr( item.val.AsInteger);
        TreeView1.Items.AddChild(node, s+': '+v)
      end
      else
      if item.val.IsType(stDouble) then
      begin
        v := FloatToStr( item.val.AsDouble);
        TreeView1.Items.AddChild(node, s+': '+v)
      end
      else
      if item.val.IsType(stCurrency) then
      begin
        v := FloatToStr (item.val.AsCurrency);
        TreeView1.Items.AddChild(node, s+': '+v)
      end
      else
      if item.val.IsType(stNull) then
      begin
        v := '';
        TreeView1.Items.AddChild(node, s+': '+v)
      end
      else
      if item.val.IsType(stObject) then
      begin
        v := item.val.AsString();
        tvi := TreeView1.Items.AddChild(node, s+':');
        ParseItemsIntoTreeView(tvi, item.val);
      end
      else
      if item.val.IsType(stArray) then
      begin
        v := item.val.AsString();
        cura := item.val.AsArray;
        tvi := TreeView1.Items.AddChild(node, s+':');
        for i := 0 to cura.Length-1 do
        begin
          ParseItemsIntoTreeView(TreeView1.Items.AddChild(tvi, _s(i+1)+'.:'), cura[i] );
        end;
      end;
    until not ObjectFindNext(item);
  finally

  end;
end;

function TForm1._i(s: String; default: integer = 0): Integer;
begin
  Result := StrToIntDef(s, default);
end;

function TForm1._s(i: integer; padLeftWith0Count: integer = 0): string;
begin
  Result := IntToStr(i);
  if padLeftWith0Count> 0 then
  begin
    while length(Result)<padLeftWith0Count do
      Result := '0' + Result;
  end;
end;

end.
