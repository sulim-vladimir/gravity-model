object OKBottomDlg: TOKBottomDlg
  Left = 484
  Top = 378
  BorderStyle = bsToolWindow
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072
  ClientHeight = 310
  ClientWidth = 185
  Color = clBtnFace
  TransparentColorValue = clBtnFace
  ParentFont = True
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = s
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 169
    Height = 265
    Shape = bsFrame
  end
  object OKBtn: TButton
    Left = 7
    Top = 276
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 103
    Top = 276
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = CancelBtnClick
  end
  object ValueEditBox1: TPanel
    Left = 16
    Top = 16
    Width = 153
    Height = 25
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 5
      Width = 43
      Height = 13
      Caption = 'Vx ('#1084'/'#1089'):'
    end
    object VXEdit: TEdit
      Left = 56
      Top = 3
      Width = 89
      Height = 19
      AutoSize = False
      TabOrder = 0
      OnChange = VXEditChange
    end
  end
  object ValueEditBox2: TPanel
    Left = 16
    Top = 48
    Width = 153
    Height = 25
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 5
      Width = 43
      Height = 13
      Caption = 'Vy ('#1084'/'#1089'):'
    end
    object VYEdit: TEdit
      Left = 56
      Top = 3
      Width = 89
      Height = 19
      AutoSize = False
      TabOrder = 0
      OnChange = VYEditChange
    end
  end
  object ValueEditBox3: TPanel
    Left = 16
    Top = 80
    Width = 153
    Height = 25
    TabOrder = 4
    object Label4: TLabel
      Left = 8
      Top = 5
      Width = 27
      Height = 13
      Caption = 'X ('#1084'):'
    end
    object ObjXEdit: TEdit
      Left = 56
      Top = 3
      Width = 89
      Height = 19
      AutoSize = False
      TabOrder = 0
      OnChange = ObjXEditChange
    end
  end
  object ValueEditBox4: TPanel
    Left = 16
    Top = 112
    Width = 153
    Height = 25
    TabOrder = 5
    object Label6: TLabel
      Left = 8
      Top = 5
      Width = 27
      Height = 13
      Caption = 'Y ('#1084'):'
    end
    object ObjYEdit: TEdit
      Left = 56
      Top = 3
      Width = 89
      Height = 19
      AutoSize = False
      TabOrder = 0
      OnChange = ObjYEditChange
    end
  end
  object ValueEditBox5: TPanel
    Left = 16
    Top = 144
    Width = 153
    Height = 25
    TabOrder = 6
    object Label7: TLabel
      Left = 8
      Top = 5
      Width = 32
      Height = 13
      Caption = 'M ('#1082#1075'):'
    end
    object ObjWeightEdit: TEdit
      Left = 56
      Top = 3
      Width = 89
      Height = 19
      AutoSize = False
      TabOrder = 0
      OnChange = ObjWeightEditChange
    end
  end
  object ValueEditBox6: TPanel
    Left = 16
    Top = 176
    Width = 153
    Height = 25
    TabOrder = 7
    object Label5: TLabel
      Left = 8
      Top = 5
      Width = 56
      Height = 13
      Caption = #1056#1072#1076#1080#1091#1089' ('#1084'):'
    end
    object ObjRadiusEdit: TEdit
      Left = 72
      Top = 3
      Width = 73
      Height = 19
      AutoSize = False
      TabOrder = 0
      OnChange = ObjRadiusEditChange
    end
  end
  object ValueEditBox7: TPanel
    Left = 16
    Top = 208
    Width = 153
    Height = 25
    TabOrder = 8
    object Label8: TLabel
      Left = 8
      Top = 5
      Width = 25
      Height = 13
      Caption = #1048#1084#1103':'
    end
    object ObjNameEdit: TEdit
      Left = 56
      Top = 3
      Width = 89
      Height = 19
      AutoSize = False
      TabOrder = 0
      OnChange = ObjNameEditChange
    end
  end
  object ColorBox1: TColorBox
    Left = 16
    Top = 240
    Width = 153
    Height = 22
    Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbCustomColor]
    ItemHeight = 16
    TabOrder = 9
    OnChange = ColorBox1Change
  end
end
