object Form4: TForm4
  Left = 502
  Top = 358
  BorderStyle = bsToolWindow
  Caption = #1054#1073#1097#1080#1077' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 185
  ClientWidth = 216
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object SetPanel: TPanel
    Left = 0
    Top = -24
    Width = 217
    Height = 241
    BevelOuter = bvNone
    BorderWidth = 2
    TabOrder = 0
    object Bevel4: TBevel
      Left = 8
      Top = 64
      Width = 201
      Height = 9
      Shape = bsTopLine
    end
    object Label1: TLabel
      Left = 8
      Top = 72
      Width = 195
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1082#1086#1085#1077#1095#1085#1086#1075#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1103' '#1089#1080#1089#1090#1077#1084#1099':'
    end
    object Bevel2: TBevel
      Left = 8
      Top = 120
      Width = 201
      Height = 9
      Shape = bsTopLine
    end
    object Bevel3: TBevel
      Left = 8
      Top = 160
      Width = 201
      Height = 9
      Shape = bsBottomLine
    end
    object Label9: TLabel
      Left = 193
      Top = 184
      Width = 8
      Height = 13
      Caption = #1084
    end
    object Label2: TLabel
      Left = 144
      Top = 132
      Width = 59
      Height = 13
      Caption = #1080#1085#1090#1077#1088#1074#1072#1083#1086#1074
      Enabled = False
    end
    object IntEdit: TLabeledEdit
      Left = 128
      Top = 32
      Width = 81
      Height = 21
      EditLabel.Width = 116
      EditLabel.Height = 13
      EditLabel.Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1088#1072#1089#1095#1077#1090#1086#1074' ('#1089'):'
      LabelPosition = lpLeft
      TabOrder = 0
      Text = '500'
      OnChange = IntEditChange
    end
    object TimeToEdit: TEdit
      Left = 72
      Top = 88
      Width = 89
      Height = 21
      TabOrder = 1
      Text = '100'
      OnChange = TimeToEditChange
    end
    object MUnitBox: TComboBox
      Left = 160
      Top = 88
      Width = 49
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = #1089
      OnChange = MUnitBoxChange
      Items.Strings = (
        #1089
        #1084#1080#1085
        #1095
        #1089#1091#1090
        #1084#1077#1089
        #1083)
    end
    object PointsEdit: TSpinEdit
      Left = 72
      Top = 128
      Width = 65
      Height = 22
      Enabled = False
      MaxValue = 1000
      MinValue = 1
      TabOrder = 3
      Value = 1
      OnChange = PointsEditChange
    end
    object ScaleEdit: TLabeledEdit
      Left = 74
      Top = 179
      Width = 111
      Height = 22
      AutoSize = False
      EditLabel.Width = 63
      EditLabel.Height = 13
      EditLabel.Caption = '1 '#1087#1080#1082#1089#1077#1083#1100' = '
      LabelPosition = lpLeft
      LabelSpacing = 5
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Text = '1'
      OnChange = ScaleEditChange
    end
    object MakePointsBox: TCheckBox
      Left = 8
      Top = 131
      Width = 57
      Height = 17
      Caption = #1052#1077#1090#1082#1080
      TabOrder = 5
      OnClick = MakePointsBoxClick
    end
  end
end
