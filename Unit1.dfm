object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 372
  ClientWidth = 712
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 329
    Height = 331
    Align = alLeft
    Lines.Strings = (
      '{'
      '  "id": "0001",'
      '  "type": "donut",'
      '  "name": "Cake",'
      '  "ppu": 0.55,'
      '  "batters": {'
      '    "batter": ['
      '      { "id": "1001", "type": "Regular" },'
      '      { "id": "1002", "type": "Chocolate" },'
      '      { "id": "1003", "type": "Blueberry" },'
      '      { "id": "1004", "type": "Devil'#39's Food" }'
      '    ]'
      '  },'
      '  "topping":['
      '    { "id": "5001", "type": "None" },'
      '    { "id": "5002", "type": "Glazed" },'
      '    { "id": "5005", "type": "Sugar" },'
      '    { "id": "5007", "type": "Powdered Sugar" },'
      '    { "id": "5006", "type": "Chocolate with Sprinkles" },'
      '    { "id": "5003", "type": "Chocolate" },'
      '    { "id": "5004", "type": "Maple" }'
      '  ]'
      '}')
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object TreeView1: TTreeView
    Left = 329
    Top = 41
    Width = 383
    Height = 331
    Align = alClient
    Indent = 19
    TabOrder = 2
    ExplicitLeft = 384
    ExplicitTop = 296
    ExplicitWidth = 121
    ExplicitHeight = 97
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 712
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    ExplicitLeft = 176
    ExplicitTop = 112
    ExplicitWidth = 185
    object Button2: TButton
      Left = 9
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Parse'
      TabOrder = 0
      OnClick = Button2Click
    end
  end
end
