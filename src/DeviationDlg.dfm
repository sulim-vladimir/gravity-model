object Form5: TForm5
  Left = 414
  Top = 366
  Width = 300
  Height = 200
  BorderStyle = bsSizeToolWin
  Caption = #1054#1094#1077#1085#1082#1072' '#1087#1086#1075#1088#1077#1096#1085#1086#1089#1090#1080
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Menu = MainMenu1
  OldCreateOrder = False
  DesignSize = (
    292
    146)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 130
    Width = 208
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = #1057#1088#1072#1074#1085#1080#1090#1100' '#1089' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072#1084#1080' '#1087#1088#1080' '#1080#1085#1090#1077#1088#1074#1072#1083#1077
  end
  object Chart: TChart
    Left = 0
    Top = 0
    Width = 292
    Height = 120
    AllowPanning = pmNone
    AllowZoom = False
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      '')
    Title.Visible = False
    View3D = False
    TabOrder = 0
    Anchors = [akLeft, akTop, akRight, akBottom]
    object Series: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      ShowInLegend = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object WithIntEdit: TEdit
    Left = 224
    Top = 128
    Width = 65
    Height = 21
    Anchors = [akRight, akBottom]
    TabOrder = 1
    Text = '100'
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 40
    object FileMenu: TMenuItem
      Caption = #1060#1072#1081#1083
      object Start: TMenuItem
        Caption = #1053#1072#1095#1072#1090#1100' '#1086#1094#1077#1085#1082#1091
        OnClick = StartClick
      end
      object SaveChart: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1075#1088#1072#1092#1080#1082' '#1082#1072#1082' '#1088#1080#1089#1091#1085#1086#1082
        OnClick = SaveChartClick
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.wmf'
    Filter = 'Windows MetaFile (*.wmf)|*.wmf'
    OnCanClose = SaveDialog1CanClose
    Left = 8
    Top = 75
  end
end
