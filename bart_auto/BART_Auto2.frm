VERSION 5.00
Object = "{C1A8AF28-1257-101B-8FB0-0020AF039CA3}#1.1#0"; "MCI32.OCX"
Begin VB.Form Form2 
   BackColor       =   &H00FFC0FF&
   ClientHeight    =   11400
   ClientLeft      =   60
   ClientTop       =   60
   ClientWidth     =   15240
   ControlBox      =   0   'False
   FillColor       =   &H00400040&
   ForeColor       =   &H00000000&
   LinkTopic       =   "Form1"
   ScaleHeight     =   11400
   ScaleWidth      =   15240
   WindowState     =   2  'Maximized
   Begin VB.TextBox txtbalnum 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   27.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      IMEMode         =   3  'DISABLE
      Left            =   11520
      TabIndex        =   27
      TabStop         =   0   'False
      Top             =   8640
      Width           =   2175
   End
   Begin VB.TextBox txtlastnum 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   41.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   960
      TabIndex        =   25
      Top             =   7320
      Width           =   3495
   End
   Begin VB.CommandButton cmdpumpconfirm 
      BackColor       =   &H00FF8080&
      Caption         =   " Type in the number of pumps above and click here to confirm"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   5640
      MaskColor       =   &H00FF0000&
      Style           =   1  'Graphical
      TabIndex        =   24
      Top             =   8280
      UseMaskColor    =   -1  'True
      Width           =   3495
   End
   Begin VB.TextBox txtpumpnum 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   41.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   5640
      TabIndex        =   1
      Top             =   7320
      Width           =   3495
   End
   Begin VB.CommandButton Command2 
      Caption         =   "   Click this button to continue.     You will have a chance to earn some more money in a few minutes!"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1575
      Left            =   4680
      TabIndex        =   23
      Top             =   9600
      Visible         =   0   'False
      Width           =   5295
   End
   Begin VB.CommandButton CmdReject 
      Caption         =   "Click to Reject Estimate"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   6720
      TabIndex        =   22
      Top             =   6360
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.CommandButton CmdConfirm 
      Caption         =   "Click to Confirm Estimate"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   8280
      TabIndex        =   21
      Top             =   6360
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.TextBox Text2 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   27.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Left            =   8040
      TabIndex        =   19
      TabStop         =   0   'False
      Top             =   7920
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.CommandButton CmdAccept 
      Caption         =   "Press to Record Estimate"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   20.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   5520
      TabIndex        =   17
      Top             =   5640
      Visible         =   0   'False
      Width           =   4695
   End
   Begin VB.TextBox TextScoreList 
      Alignment       =   2  'Center
      CausesValidation=   0   'False
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   27.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   10320
      TabIndex        =   15
      TabStop         =   0   'False
      Top             =   240
      Visible         =   0   'False
      Width           =   2055
   End
   Begin VB.CommandButton CmdDown 
      Caption         =   "Pump Down"
      Height          =   855
      Left            =   4560
      TabIndex        =   14
      Top             =   6480
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.CommandButton CmdUp 
      Caption         =   "Pump UP"
      Height          =   855
      Left            =   10080
      TabIndex        =   13
      Top             =   5520
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "  Click to End"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1335
      Left            =   1320
      TabIndex        =   11
      Top             =   1080
      Visible         =   0   'False
      Width           =   12015
   End
   Begin MCI.MMControl MMControl3 
      Height          =   300
      Left            =   2520
      TabIndex        =   9
      Top             =   2160
      Width           =   0
      _ExtentX        =   0
      _ExtentY        =   529
      _Version        =   393216
      BorderStyle     =   0
      PrevVisible     =   0   'False
      NextVisible     =   0   'False
      PlayVisible     =   0   'False
      PauseVisible    =   0   'False
      BackVisible     =   0   'False
      StepVisible     =   0   'False
      StopVisible     =   0   'False
      RecordVisible   =   0   'False
      EjectVisible    =   0   'False
      DeviceType      =   ""
      FileName        =   ""
   End
   Begin VB.Data datPrimaryRS 
      Align           =   2  'Align Bottom
      Caption         =   " "
      Connect         =   "Access"
      DatabaseName    =   "c:\Risk Task\Databases\Bart_Auto.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   0
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   11055
      Visible         =   0   'False
      Width           =   15240
   End
   Begin MCI.MMControl MMControl2 
      Height          =   300
      Left            =   2760
      TabIndex        =   8
      Top             =   3120
      Width           =   0
      _ExtentX        =   0
      _ExtentY        =   529
      _Version        =   393216
      BorderStyle     =   0
      PrevVisible     =   0   'False
      NextVisible     =   0   'False
      PlayVisible     =   0   'False
      PauseVisible    =   0   'False
      BackVisible     =   0   'False
      StepVisible     =   0   'False
      StopVisible     =   0   'False
      RecordVisible   =   0   'False
      EjectVisible    =   0   'False
      DeviceType      =   ""
      FileName        =   ""
   End
   Begin MCI.MMControl MMControl1 
      Height          =   300
      Left            =   2040
      TabIndex        =   7
      Top             =   4440
      Width           =   0
      _ExtentX        =   0
      _ExtentY        =   529
      _Version        =   393216
      BorderStyle     =   0
      PrevEnabled     =   -1  'True
      NextEnabled     =   -1  'True
      PlayEnabled     =   -1  'True
      PauseEnabled    =   -1  'True
      BackEnabled     =   -1  'True
      StepEnabled     =   -1  'True
      StopEnabled     =   -1  'True
      RecordEnabled   =   -1  'True
      EjectEnabled    =   -1  'True
      PrevVisible     =   0   'False
      NextVisible     =   0   'False
      PlayVisible     =   0   'False
      PauseVisible    =   0   'False
      BackVisible     =   0   'False
      StepVisible     =   0   'False
      StopVisible     =   0   'False
      RecordVisible   =   0   'False
      EjectVisible    =   0   'False
      DeviceType      =   ""
      FileName        =   "C:\Ringin.wav"
   End
   Begin VB.Timer Timer1 
      Interval        =   50
      Left            =   3120
      Top             =   4440
   End
   Begin VB.TextBox textpumpvalue 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   27.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Left            =   11520
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   7560
      Width           =   2175
   End
   Begin VB.TextBox TextScore 
      Alignment       =   2  'Center
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   27.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      HideSelection   =   0   'False
      Left            =   11520
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   6480
      Width           =   2175
   End
   Begin VB.CommandButton CmdReset 
      BackColor       =   &H00C0C0FF&
      Caption         =   "  Collect        $$$"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   20.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   465
      Left            =   1080
      MaskColor       =   &H00C0C0FF&
      TabIndex        =   2
      Top             =   7680
      UseMaskColor    =   -1  'True
      Visible         =   0   'False
      Width           =   3375
   End
   Begin VB.CommandButton CmdPump 
      Caption         =   "        Click Here to      Pump up the Balloon"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   960
      TabIndex        =   0
      Top             =   7320
      Visible         =   0   'False
      Width           =   3495
   End
   Begin MCI.MMControl MMControl4 
      Height          =   300
      Left            =   360
      TabIndex        =   33
      Top             =   0
      Width           =   30
      _ExtentX        =   53
      _ExtentY        =   529
      _Version        =   393216
      BorderStyle     =   0
      PrevVisible     =   0   'False
      NextVisible     =   0   'False
      PlayVisible     =   0   'False
      PauseVisible    =   0   'False
      BackVisible     =   0   'False
      StepVisible     =   0   'False
      StopVisible     =   0   'False
      RecordVisible   =   0   'False
      EjectVisible    =   0   'False
      DeviceType      =   ""
      FileName        =   "C:\Robotz Error.wav"
   End
   Begin VB.Label Label13 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   "*** Remember ***"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   960
      TabIndex        =   32
      Top             =   6000
      Width           =   3495
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label12 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   "64 is best overall strategy"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   960
      TabIndex        =   31
      Top             =   6840
      Width           =   3495
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label11 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   "Must be between 1-128"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   960
      TabIndex        =   30
      Top             =   6480
      Width           =   3495
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   "Must be between 1-128"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   5640
      TabIndex        =   29
      Top             =   9120
      Width           =   3495
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label9 
      Alignment       =   2  'Center
      BackColor       =   &H008080FF&
      Caption         =   "Balloon Number"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   9960
      TabIndex        =   28
      Top             =   8640
      Width           =   1455
   End
   Begin VB.Label Label8 
      Caption         =   "  Explosion point for last balloon"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   960
      TabIndex        =   26
      Top             =   8280
      Width           =   3495
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H0000C000&
      Caption         =   "# of Pumps"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   7200
      TabIndex        =   20
      Top             =   7920
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "BONUS ROUND !!!"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   36
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800080&
      Height          =   735
      Left            =   3720
      TabIndex        =   18
      Top             =   10080
      Visible         =   0   'False
      Width           =   8295
   End
   Begin VB.Label Label5 
      BackColor       =   &H00FF8080&
      Caption         =   $"BART_Auto2.frx":0000
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   18.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C0C0FF&
      Height          =   3975
      Left            =   1800
      TabIndex        =   16
      Top             =   9960
      Visible         =   0   'False
      Width           =   11055
      WordWrap        =   -1  'True
   End
   Begin VB.Label label4 
      Alignment       =   2  'Center
      BackColor       =   &H00FF8080&
      Caption         =   "          This part is now complete.           Press the button below to continue."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   20.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C0C0FF&
      Height          =   1335
      Left            =   3960
      TabIndex        =   12
      Top             =   1680
      Visible         =   0   'False
      Width           =   8295
      WordWrap        =   -1  'True
   End
   Begin VB.Label label3 
      BackColor       =   &H00FF8080&
      Caption         =   "Congratulations!!!  You earned"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   30
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C0C0FF&
      Height          =   975
      Left            =   1320
      TabIndex        =   10
      Top             =   240
      Visible         =   0   'False
      Width           =   12015
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFF80&
      Caption         =   "     Cents     per Pump"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   9960
      TabIndex        =   6
      Top             =   7560
      Width           =   1455
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H0000FF00&
      Caption         =   " Total  Score"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   9960
      TabIndex        =   5
      Top             =   6480
      Width           =   1455
   End
   Begin VB.Shape Shape2 
      FillStyle       =   0  'Solid
      Height          =   255
      Left            =   7080
      Top             =   7080
      Width           =   495
   End
   Begin VB.Shape ShpBalloon 
      BackColor       =   &H00FF0000&
      BackStyle       =   1  'Opaque
      FillColor       =   &H00FF0000&
      FillStyle       =   0  'Solid
      Height          =   3000
      Left            =   5880
      Shape           =   2  'Oval
      Top             =   4095
      Width           =   3000
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Start As Variant
Dim Now As Variant
Dim now1 As Variant
Dim sessionstarttime As Variant
Dim sessionstoptime As Variant
Dim TotalSessionLength As Variant
Dim highSessionLength As Variant
Dim mediumSessionLength As Variant
Dim lowSessionLength As Variant
Dim Start2 As Variant
Dim Now2 As Variant
Dim DoTimer As Variant
Dim read As Variant
Dim size(1000) As Variant
Dim color(1000) As Variant
Dim paycode(1000) As Variant
Dim pumpup(300) As Variant
Dim pumpdown(300) As Variant
Public textwrite As Variant
Public balnum As Integer
Public endnow As Integer
Public textpumpnum As String
Public balloontype As Variant
Public SetHeight As Variant
Public SetTop As Variant
Public SetLeft As Variant
Public SetWidth As Variant
Public InitialSetHeight As Variant
Public InitialSetTop As Variant
Public InitialSetLeft As Variant
Public InitialSetWidth As Variant
Public InitialSetFrmFillWidth As Variant
Public condition As String
Public SetWidth_Meter As Variant
Public SetThrough As Variant
Public BurstIndex As Variant
Public BurstInterval As Variant
Public BurstNow As Variant
Public NumberofPumps As Variant
Public TotalNumberofPumps As Variant
Public TempPointCount As Variant
Public tempTempPointCount As Variant
Public Flashpointcount As Variant
Public PointCount As Variant
Public RollingPointCount As Variant
Public BurstRange As Variant
Public BurstRangeConvert As Variant
Public explode As Variant
Public i As Variant
Public j As Variant
Public q As Variant
Public X As Variant
Public Y As Variant
Public ii As Variant
Public t As Variant
Public confirm As Variant
Public confirmx As Variant
Dim totalpumpsarray(1300)
Dim totalpumpsarrayx(1300)
Dim coloripitime(1000) As Variant
Dim colortime(1000) As Variant
Dim AVG_IPI(1000) As Variant
Dim AVG_IPI_Adjusted(1000) As Variant
Dim AVG_PrePump(1000) As Variant
Dim AVG_IPI_PreReset(1000) As Variant
Dim all_IPIs(1000, 1500) As Variant
Dim Pre_IPI(1000) As Variant
Dim Post_IPI(1000) As Variant
Dim explosion_yn(1000) As Variant
Dim QuickReset(1000) As Variant
Public PumpTime As Variant
Public IPI_Start As Variant
Public IPI_Stop As Variant
Public IPI_TimeToFirstPump As Variant
Public IPI_TimeFromLastPump As Variant
Public IPI_LastPump As Variant
Public flashvalue As Variant
Public skip As Variant
Public explosions As Variant
Public maxtrials As Variant
Public totalpumps As Variant
Public highpumps As Variant
Public mediumpumps As Variant
Public lowpumps As Variant
Public adjtotalpumps As Variant
Public adjhighpumps As Variant
Public adjmediumpumps As Variant
Public adjlowpumps As Variant
Public highexpl As Variant
Public mediumexpl As Variant
Public lowexpl As Variant
Public numhigh As Variant
Public nummedium As Variant
Public numlow As Variant
Public lowcolortime As Variant
Public mediumcolortime As Variant
Public highcolortime As Variant
Public avg_totalpumps As Variant
Public avg_highpumps As Variant
Public avg_mediumpumps As Variant
Public avg_lowpumps As Variant
Public Adjavg_totalpumps As Variant
Public Adjavg_highpumps As Variant
Public Adjavg_mediumpumps As Variant
Public Adjavg_lowpumps As Variant
Public highpointcount As Variant
Public mediumpointcount As Variant
Public lowpointcount As Variant
Public ExchangeRate As Variant
Public preExchangeRate As Variant
Public Total_AVG_IPI_Adjusted  As Variant
Public Total_AVG_post_IPI  As Variant
Public Total_AVG_pre_IPI  As Variant
Public hightime  As Variant
Public mediumtime  As Variant
Public lowtime  As Variant
Public fu As Variant
Public fu2 As Variant
Public loophole As Variant
Public timethrough As Variant
Public both As Variant
Public LastOne As Variant
Public current As Variant
Public onlyonce As Variant
Public cond As Variant
Public Accept As Variant
Public gothrough As Variant
Public ReportTime As Variant
Public ReportStart As Variant
Public explosionduration As Variant
Public help1 As Variant
Public help2 As Variant
Public stoptime As Variant
Public Payouttype As Variant
Public totalexchange As Variant
Public tvalue As Variant
Public resetnow As Variant
Public repeatpump As Variant
Public totalpumpsx As Variant
Dim currenttime(1000) As Variant

Private Sub CmdAccept_Click()
CmdConfirm.Visible = True
CmdReject.Visible = True






Text2.Text = " "

ii = ii + 1

If ii > 3 Then
ShpBalloon.Visible = False
CmdDown.Visible = False
CmdUp.Visible = False
Shape2.Visible = False
CmdAccept.Visible = False
Label7.Visible = False
Text2.Visible = False
Form5.Show
Form5.Hide
Form3.Show
Form2.Hide

'Call writetofile


End If

''&HFFFF& &H80FF&
ShpBalloon.Top = InitialSetTop
ShpBalloon.Height = InitialSetHeight
ShpBalloon.Left = InitialSetLeft
ShpBalloon.Width = InitialSetWidth
Accept = 0

End Sub

Private Sub CmdConfirm_Click()
Accept = 1
Call CmdAccept_Click
CmdConfirm.Visible = False
CmdReject.Visible = False
End Sub

Private Sub CmdDown_Click()

'InitialSetHeight = ShpBalloon.Height
'InitialSetLeft = ShpBalloon.Left
'InitialSetWidth = ShpBalloon.Width
Label6.Visible = False
Label5.Visible = False
CmdAccept.Visible = True
Label7.Visible = True
Text2.Visible = True



If ShpBalloon.Width > InitialSetWidth Then
pumpdown(ii) = 1 + pumpdown(ii)

Text2.Text = pumpup(ii) - pumpdown(ii)
ShpBalloon.Top = ShpBalloon.Top + SetTop
ShpBalloon.Height = ShpBalloon.Height - SetHeight
ShpBalloon.Left = ShpBalloon.Left + SetLeft
ShpBalloon.Width = ShpBalloon.Width - SetWidth
End If
End Sub

Public Sub writetofile()

End Sub


Private Sub CmdPump_click()
'''' to keep temppumps from exceeding it before a reset




End Sub

Private Sub cmdpumpconfirm_Click()


If (Val(txtpumpnum) = 0) Or (Val(txtpumpnum) > 128) Then
textwrite = Val(txtpumpnum)
txtpumpnum.Text = ""
End If


If (Val(txtpumpnum) > 0) And (Val(txtpumpnum) < 129) Then
cmdpumpconfirm.Visible = False
txtpumpnum.Visible = False
 



If balnum < 30 Then
balnum = balnum + 1
End If


txtbalnum.Text = Str(balnum)

confirm = Val(txtpumpnum)
confirmx = confirm
explode = 0

Do Until confirmx = 0



Now = Timer
If NumberofPumps = 0 Then

IPI_TimeToFirstPump = Now - sessionstarttime

End If

totalpumps = totalpumps + 1
adjtotalpumps = adjtotalpumps + 1


If balloontype = 3 Then
highpumps = highpumps + 1
adjhighpumps = adjhighpumps + 1
End If

If balloontype = 2 Then
mediumpumps = mediumpumps + 1
adjmediumpumps = adjmediumpumps + 1
End If

If balloontype = 1 Then
lowpumps = lowpumps + 1
adjlowpumps = adjlowpumps + 1
End If

IPI_LastPump = Timer
If NumberofPumps > 0 Then
'IPI_LastPump = Timer
all_IPIs(i, NumberofPumps) = (IPI_LastPump - PumpTime)
'MsgBox (i)
'MsgBox (NumberofPumps)
'MsgBox (all_IPIs(i, NumberofPumps))
End If
PumpTime = Timer

ShpBalloon.Left = ShpBalloon.Left - SetLeft
ShpBalloon.Width = ShpBalloon.Width + SetWidth
ShpBalloon.Top = ShpBalloon.Top - SetTop
ShpBalloon.Height = ShpBalloon.Height + SetHeight
'FrmFill.Width = FrmFill.Width + SetWidth_Meter
NumberofPumps = NumberofPumps + 1
TempPointCount = TempPointCount + 1

'If BurstInterval >= (TotalNumberofPumps * BurstIndex) Then
'TempPointCount = TempPointCount + 3
'End If

'If FrmFill.Width >= 1920 Then
'FrmFill.BackColor = &HFFFF&
'End If

'MsgBox (ShpBalloon.Height)
'MsgBox (ShpBalloon.Left)
'MsgBox (ShpBalloon.Top)
'MsgBox (FrmFill.Width)










confirmx = confirmx - 1
If confirmx = 0 Then
cmdpumpconfirm.Visible = True
txtpumpnum.Visible = True
txtpumpnum.SetFocus
End If

Loop

'_____________________________________________________________

If confirmx = 0 Then

totalpumps = confirm


If totalpumps >= BurstRange(i) Then '(2)
explode = 1

'totalpumpsarrayx(i) = totalpumps

If i < 1 Then
totalpumpsarrayx(i) = totalpumps
End If

If i >= 1 Then
totalpumpsarrayx(i) = totalpumps - totalpumpsarray(i - 1)
End If



If NumberofPumps >= (BurstRange(i)) Then
'FrmFill.BackColor = &HFF&

''''check here
'flashvalue = 0


explosions = explosions + 1
explosion_yn(i + 1) = 1


'textpumpvalue.Text = TempPointCount * 2
t = 1
ShpBalloon.Top = InitialSetTop
ShpBalloon.Height = InitialSetHeight
ShpBalloon.Left = InitialSetLeft
ShpBalloon.Width = InitialSetWidth
'FrmFill.Width = InitialSetFrmFillWidth
'FrmFill.BackColor = &HC000&
'PointCount = PointCount + TempPointCount
'TextScore.Text = PointCount
TempPointCount = 0
IPI_Stop = Timer
'AVG_IPI(i + 1) = (IPI_Stop - IPI_Start) / NumberofPumps

If balloontype = 3 Then
hightime = (IPI_Stop - IPI_Start) + hightime
End If

If balloontype = 2 Then
mediumtime = (IPI_Stop - IPI_Start) + mediumtime
End If

If balloontype = 1 Then
lowtime = (IPI_Stop - IPI_Start) + lowtime
End If


'AVG_IPI_Adjusted(i + 1) = (((IPI_Stop - IPI_Start) - (IPI_TimeToFirstPump - IPI_Start)) - (IPI_TimeFromLastPump - IPI_LastPump)) / (NumberofPumps - 1)
'MsgBox (AVG_IPI_Adjusted(i + 1))
'Total_AVG_IPI_Adjusted = ((AVG_IPI_Adjusted(i + 1) + Total_AVG_IPI_Adjusted) / (i + 1))

Pre_IPI(i + 1) = IPI_TimeToFirstPump - currenttime(i)
currenttime(i + 1) = (Now - sessionstarttime)
'MsgBox (currenttime(i))

Total_AVG_pre_IPI = ((Pre_IPI(i + 1) + Total_AVG_pre_IPI) / (i + 1))
Post_IPI(i + 1) = asmerelda
'Total_AVG_post_IPI = ((Post_IPI(i + 1) + Total_AVG_post_IPI) / (i + 1))
'MsgBox (Total_AVG_post_IPI)

If balloontype = 3 Then
adjhighpumps = adjhighpumps - NumberofPumps
highexpl = 1 + highexpl
'MsgBox ("hi")
End If

If balloontype = 2 Then
adjmediumpumps = adjmediumpumps - NumberofPumps
mediumexpl = 1 + mediumexpl
'MsgBox ("med")
End If

If balloontype = 1 Then
adjlowpumps = adjlowpumps - NumberofPumps
lowexpl = 1 + lowexpl
'MsgBox ("low")
End If



'here __NumberofPumps = 0





'MsgBox (i)
If i = maxtrials - 1 Then
loophole = 1
both = 0
End If



'totalpumpsarrayx(i) = totalpumps

If i < 1 Then
totalpumpsarrayx(i) = totalpumps
End If

If i >= 1 Then
totalpumpsarrayx(i) = totalpumps - totalpumpsarray(i - 1)
End If




'Beep


'MMControl4.Command = "prev"
'      MMControl4.Command = "prev"
'   MMControl4.Command = "play"
'   MMControl4.Command = "prev"
 '     MMControl1.Command = "close"
MMControl4.Command = "prev"
   MMControl4.Command = "play"
   MMControl4.Command = "prev"
      MMControl1.Command = "close"

   
   MMControl1.Notify = False
   MMControl1.Wait = True
   MMControl1.Shareable = False
   MMControl1.DeviceType = "WaveAudio"
   MMControl1.FileName = "C:\Risk Task\Sounds\casino.WAV"

   ' Open the MCI WaveAudio device.
   MMControl1.Command = "Open"




'MsgBox (AVG_IPI(i + 1))
'MsgBox (AVG_IPI_Adjusted(i + 1))

ShpBalloon.Top = InitialSetTop
ShpBalloon.Height = InitialSetHeight
ShpBalloon.Left = InitialSetLeft
ShpBalloon.Width = InitialSetWidth
'FrmFill.Width = InitialSetFrmFillWidth
'FrmFill.BackColor = &HC000&
BurstInterval = 0
TempPointCount = 0
NumberofPumps = 0


'''''''''''''''ugh
tvalue = (flashvalue * ExchangeRate) + tvalue
flashvalue = 0








'Pre_IPI(i + 1) = IPI_TimeToFirstPump - currenttime(i)
'IPI_Start = Timer + 1.07
j = i + 1
i = 1 + i
k = j + 1

'If j = 30 And gothrough = 0 Then

'TextScore.Text = FormatCurrency((tvalue + (flashvalue * ExchangeRate)) / 100, -1)

'30 take out
'Command2.Visible = True
'CmdPump.Visible = False
'CmdReset.Visible = False
'MsgBox (Now)
'ReportStart = Now
'End If


'If j = 2 Or j = 4 Or j = 6 Or j = 9 Or j = 10 Or j = 13 Or j = 16 Or j = 17 Or j = 19 Or j = 20 Or j = 23 Or j = 24 Or j = 30 Or j = 32 Or j = 33 Or j = 38 Or j = 41 Or j = 43 Or j = 46 Or j = 48 Or j = 53 Or j = 57 Or j = 61 Or j = 67 Or j = 68 Or j = 75 Or j = 78 Or j = 83 Or j = 87 Or j = 90 Then
'ShpBalloon.FillColor = &H80FF&
'ShpBalloon.BackColor = &H80FF&
'End If
'If j = 3 Or j = 5 Or j = 7 Or j = 11 Or j = 14 Or j = 15 Or j = 18 Or j = 21 Or j = 25 Or j = 26 Or j = 29 Or j = 31 Or j = 36 Or j = 39 Or j = 45 Or j = 49 Or j = 51 Or j = 54 Or j = 56 Or j = 58 Or j = 63 Or j = 64 Or j = 66 Or j = 70 Or j = 71 Or j = 74 Or j = 76 Or j = 81 Or j = 82 Or j = 89 Then
'ShpBalloon.FillColor = &HFF0000
'ShpBalloon.BackColor = &HFF0000
'End If
'If j = 1 Or j = 8 Or j = 12 Or j = 22 Or j = 27 Or j = 28 Or j = 34 Or j = 35 Or j = 37 Or j = 40 Or j = 42 Or j = 44 Or j = 47 Or j = 50 Or j = 52 Or j = 55 Or j = 59 Or j = 60 Or j = 62 Or j = 65 Or j = 69 Or j = 72 Or j = 73 Or j = 77 Or j = 79 Or j = 80 Or j = 84 Or j = 85 Or j = 86 Or j = 88 Then
'ShpBalloon.FillColor = &HFFFF&
'ShpBalloon.BackColor = &HFFFF&
'End If


If j <= maxtrials Then
If k = 21 Or k = 22 Or k = 23 Or k = 24 Or k = 25 Or k = 26 Or k = 27 Or k = 28 Or k = 29 Or k = 30 Then
preExchangeRate = 1
textpumpvalue.Text = Str(preExchangeRate)
balloontype = 3
paycode(j) = 3
numhigh = 1 + numhigh
End If
End If

If j <= maxtrials Then
If k = 1 Or k = 2 Or k = 3 Or k = 4 Or k = 5 Or k = 6 Or k = 7 Or k = 8 Or k = 9 Or k = 10 Then
preExchangeRate = 1
textpumpvalue.Text = Str(preExchangeRate)
balloontype = 1
paycode(j) = 1
numlow = 1 + numlow

End If
End If

If j <= maxtrials Then
If k = 11 Or k = 12 Or k = 13 Or k = 14 Or k = 15 Or k = 16 Or k = 17 Or k = 18 Or k = 19 Or k = 20 Then
preExchangeRate = 1
textpumpvalue.Text = Str(preExchangeRate)
balloontype = 2
paycode(j) = 2
nummedium = 1 + nummedium

End If
End If


If j <= maxtrials Then
If j = 21 Or j = 22 Or j = 23 Or j = 24 Or j = 25 Or j = 26 Or j = 27 Or j = 28 Or j = 29 Or j = 30 Then
ExchangeRate = 1
'textpumpvalue.Text = Str(ExchangeRate)
'balloontype = 3
'size(j) = 3

End If
End If ''''


If j <= maxtrials Then
If j = 1 Or j = 2 Or j = 3 Or j = 4 Or j = 5 Or j = 6 Or j = 7 Or j = 8 Or j = 9 Or j = 10 Then
ExchangeRate = 1
'textpumpvalue.Text = Str(ExchangeRate)
'balloontype = 1
'size(j) = 1

End If
End If '''

If j <= maxtrials Then
If j = 11 Or j = 12 Or j = 13 Or j = 14 Or j = 15 Or j = 16 Or j = 17 Or j = 18 Or j = 19 Or j = 20 Then
ExchangeRate = 1
'textpumpvalue.Text = Str(ExchangeRate)
'balloontype = 2
'size(j) = 2

End If
End If



CmdPump.Visible = False
CmdReset.Visible = False
cmdpumpconfirm.Visible = False
txtpumpnum.Visible = False
If i = maxtrials Then
Shape2.Visible = False
ShpBalloon.Visible = False
End If

now1 = Timer


'---------------------------
If i = maxtrials Then
loophole = 1
sessionstoptime = Timer
TotalSessionLength = sessionstoptime - sessionstarttime
'MsgBox (TotalSessionLength)


LastOne = Timer
'Call writetofile keep
CmdPump.Visible = False
cmdpumpconfirm.Visible = False
txtpumpnum.Visible = False
ShpBalloon.Visible = False
CmdReset.Visible = False
Shape2.Visible = False

End If

'----------------------------


End If


End If





If explode = 0 Then '(3)
If (totalpumps < BurstRange(i)) Then '(2)


'totalpumpsarray(i) = totalpumps


If i < 1 Then
totalpumpsarrayx(i) = totalpumps
End If

If i >= 1 Then
totalpumpsarrayx(i) = totalpumps - totalpumpsarray(i - 1)
End If


resetnow = 1
tvalue = (flashvalue * ExchangeRate) + tvalue
flashvalue = 0
'flashvalue = PointCount - flashvalue
Now = Timer



If NumberofPumps = 0 Then

resetnow = 0
'Pre_IPI(i + 1) = IPI_TimeToFirstPump - currenttime(i)

QuickReset(i + 1) = ((Now - sessionstarttime) - currenttime(i)) 'IPI_Start
'MsgBox (QuickReset(i))
'MsgBox (Now)
'MsgBox (currenttime(i))

currenttime(i + 1) = (Now - sessionstarttime)


'MsgBox (Pre_IPI(i + 1))


End If




'MsgBox (AVG_IPI(5))
'MsgBox (AVG_IPI_Adjusted(5))
'MsgBox (both)





If balloontype = 3 Then
highpointcount = TempPointCount + highpointcount
End If

If balloontype = 2 Then
mediumpointcount = TempPointCount + mediumpointcount
End If

If balloontype = 1 Then
lowpointcount = TempPointCount + lowpointcount
End If



IPI_Stop = Timer
IPI_TimeFromLastPump = Timer

If NumberofPumps = 0 Then
'QuickReset(i) = IPI_Stop - currenttime(i) 'IPI_Start
'MsgBox (QuickReset(i))


'If i <> 30 Then
IPI_Start = Timer
'End If
both = 0
End If



'MsgBox (i + 1)
If (NumberofPumps = 0) Then
'If j = (30 - 1) And gothrough = 0 Then
'TextScore.Text = FormatCurrency((tvalue + (flashvalue * ExchangeRate)) / 100, -1)

'30 take out
'Command2.Visible = True
'CmdPump.Visible = False
'CmdReset.Visible = False

'XXXXXXXXXXXXXXXXXXX

'If i = 31 Then
'ReportStart = Now
'End If
'End If

'AVG_IPI(i + 1) = (IPI_Stop - IPI_Start) / NumberofPumps
End If

If NumberofPumps > 1 Then
'AVG_IPI_Adjusted(i + 1) = (((IPI_Stop - IPI_Start) - (IPI_TimeToFirstPump - IPI_Start)) - (IPI_TimeFromLastPump - IPI_LastPump)) / (NumberofPumps - 1)
'MsgBox (AVG_IPI_Adjusted(i + 1))
'Total_AVG_IPI_Adjusted = ((AVG_IPI_Adjusted(i + 1) + Total_AVG_IPI_Adjusted) / (i + 1))
End If

If balloontype = 3 Then
hightime = (IPI_Stop - IPI_Start) + hightime
End If

If balloontype = 2 Then
mediumtime = (IPI_Stop - IPI_Start) + mediumtime
End If

If balloontype = 1 Then
lowtime = (IPI_Stop - IPI_Start) + lowtime
End If

'currenttime(i) = Now - sessionstarttime


Pre_IPI(i + 1) = IPI_TimeToFirstPump - currenttime(i)
'MsgBox (Pre_IPI(i + 1))




Post_IPI(i + 1) = IPI_TimeFromLastPump - IPI_LastPump
'MsgBox (IPI_TimeFromLastPump)
'MsgBox (IPI_LastPump)
'Total_AVG_pre_IPI = ((Pre_IPI(i + 1) + Total_AVG_pre_IPI) / (i + 1))
'Total_AVG_post_IPI = ((Post_IPI(i + 1) + Total_AVG_post_IPI) / (i + 1))
'MsgBox (Total_AVG_post_IPI)

'MsgBox (AVG_IPI(i + 1))
'MsgBox (AVG_IPI_Adjusted(i + 1))

'mci_play
   

   
   MMControl1.Command = "play"
   MMControl1.Command = "prev"





BurstInterval = 0


If TempPointCount > 0 Then
CmdPump.Visible = False
CmdReset.Visible = False
cmdpumpconfirm.Visible = False
txtpumpnum.Visible = False
'Shape2.Visible = False
'ShpBalloon.Visible = False


End If

If TempPointCount = 0 Then
'textpumpvalue.Text = 0
MMControl1.Command = "stop"

End If


ShpBalloon.Top = InitialSetTop
ShpBalloon.Height = InitialSetHeight
ShpBalloon.Left = InitialSetLeft
ShpBalloon.Width = InitialSetWidth
'FrmFill.Width = InitialSetFrmFillWidth
'FrmFill.BackColor = &HC000&

'TextScore.Text = PointCount

DoTimer = 1
Start = Timer

'MsgBox (flashvalue)

'If flashvalue = PointCount Then
'textpumpvalue.Text = TempPointCount * 2
'PointCount = PointCount + TempPointCount
'End If



NumberofPumps = 0
RollingPointCount = 0

PointCount = PointCount + TempPointCount
'TempPointCount = 0
NumberofPumps = 0
j = i + 1
i = i + 1
k = j + 1

If j <= maxtrials Then
If k = 21 Or k = 22 Or k = 23 Or k = 24 Or k = 25 Or k = 26 Or k = 27 Or k = 28 Or k = 29 Or k = 30 Then
preExchangeRate = 1
textpumpvalue.Text = Str(preExchangeRate)
paycode(j) = 3
balloontype = 3
'Size(j) = 3
numhigh = 1 + numhigh

End If
End If

If j <= maxtrials Then
If k = 1 Or k = 2 Or k = 3 Or k = 4 Or k = 5 Or k = 6 Or k = 7 Or k = 8 Or k = 9 Or k = 10 Then
preExchangeRate = 1
textpumpvalue.Text = Str(preExchangeRate)

paycode(j) = 1
balloontype = 1
'Size(j) = 1

numlow = 1 + numlow
End If
End If

If j <= maxtrials Then
If k = 11 Or k = 12 Or k = 13 Or k = 14 Or k = 15 Or k = 16 Or k = 17 Or k = 18 Or k = 19 Or k = 20 Then
paycode(j) = 2
preExchangeRate = 1
textpumpvalue.Text = Str(preExchangeRate)
balloontype = 2
nummedium = 1 + nummedium


End If
End If

If j <= maxtrials Then
If j = 21 Or j = 22 Or j = 23 Or j = 24 Or j = 25 Or j = 26 Or j = 27 Or j = 28 Or j = 29 Or j = 30 Then
ExchangeRate = 1
'textpumpvalue.Text = Str(ExchangeRate)
'balloontype = 3


End If
End If ''''


If j <= maxtrials Then
If j = 1 Or j = 2 Or j = 3 Or j = 4 Or j = 5 Or j = 6 Or j = 7 Or j = 8 Or j = 9 Or j = 10 Then
ExchangeRate = 1
'textpumpvalue.Text = Str(ExchangeRate)
'balloontype = 1


End If
End If '''

If j <= maxtrials Then
If j = 11 Or j = 12 Or j = 13 Or j = 14 Or j = 15 Or j = 16 Or j = 17 Or j = 18 Or j = 19 Or j = 20 Then
ExchangeRate = 1
'textpumpvalue.Text = Str(ExchangeRate)
'balloontype = 2


End If
End If


If i = maxtrials Then
loophole = 1
sessionstoptime = Timer
TotalSessionLength = sessionstoptime - sessionstarttime
'MsgBox (TotalSessionLength)


LastOne = Timer
'Call writetofile keep
CmdPump.Visible = False
ShpBalloon.Visible = False
CmdReset.Visible = False
cmdpumpconfirm.Visible = False
txtpumpnum.Visible = False
Shape2.Visible = False
txtpumpnum.Visible = False

End If



End If '(2)
End If '(3)

txtlastnum.Text = BurstRange(i - 1)
textwrite = Val(txtpumpnum)
txtpumpnum.Text = ""
    
End If


End If

If i < maxtrials Then
'txtpumpnum.SetFocus
End If

End Sub

Private Sub CmdReject_Click()
CmdReject.Visible = False
CmdConfirm.Visible = False
End Sub

Private Sub Command1_Click()

Dim FindStr As String

    FindStr = "MainBalloon"
    datPrimaryRS.RecordSource = FindStr
    datPrimaryRS.Refresh
    datPrimaryRS.Recordset.AddNew
    Subject = datPrimaryRS.Recordset.Fields("ID")
    datPrimaryRS.Recordset.Fields("Subj Num") = IIf(Not IsNull(form1.CboSubjNum.Text) And Len(form1.CboSubjNum.Text) > 0, form1.CboSubjNum, Null)
    datPrimaryRS.Recordset.Fields("Sess Num") = IIf(Not IsNull(form1.cboSessNum.Text) And Len(form1.cboSessNum.Text) > 0, form1.cboSessNum, Null)
    datPrimaryRS.Recordset.Fields("Exp Name") = IIf(Not IsNull(form1.CboExpName.Text) And Len(form1.CboExpName.Text) > 0, form1.CboExpName, Null)
    datPrimaryRS.Recordset.Fields("Gender") = IIf(Not IsNull(form1.gender) And Len(form1.gender) > 0, form1.gender, Null)
    datPrimaryRS.Recordset.Fields("Date") = IIf(Not IsNull(form1.CboDate) And Len(form1.CboDate) > 0, form1.CboDate, Null)
    datPrimaryRS.Recordset.Fields("Time of Day") = IIf(Not IsNull(form1.CboTime) And Len(form1.CboTime) > 0, form1.CboTime, Null)

Label4.Visible = False
Label3.Visible = False
Command1.Visible = False
CmdReset.Visible = False
CmdPump.Visible = False
cmdpumpconfirm.Visible = False
txtpumpnum.Visible = False
CmdDown.Visible = True
CmdUp.Visible = True
ShpBalloon.Visible = True
Shape2.Visible = True
TextScoreList.Visible = False
Label5.Visible = True
TextScore.Visible = False
textpumpvalue.Visible = False
Label1.Visible = False
Label2.Visible = False
Label6.Visible = True





avg_highpumps = highpumps / numhigh
avg_mediumpumps = mediumpumps / nummedium
avg_lowpumps = lowpumps / numlow
avg_pumps = totalpumps / (numhigh + nummedium + numlow)

If highexpl <> numhigh Then
Adjavg_highpumps = adjhighpumps / (numhigh - highexpl)
End If

If mediumexpl <> nummedium Then
Adjavg_mediumpumps = adjmediumpumps / (nummedium - mediumexpl)
End If

If lowexpl <> numlow Then
Adjavg_lowpumps = adjlowpumps / (numlow - lowexpl)
End If

If explosions <> (numhigh + nummedium + numlow) Then
adjavg_pumps = (adjhighpumps + adjmediumpumps + adjlowpumps) / (numhigh + nummedium + numlow - highexpl - mediumexpl - lowexpl)
End If

If onlyonce = 0 Then
onlyonce = 1
Shape2.Visible = False
ShpBalloon.Visible = False

'Do Until current - LastOne > 2
'current = Timer
'Loop

If fu = 0 Then
'    FindStr = "MainBalloon"
'    datPrimaryRS.RecordSource = FindStr
'    datPrimaryRS.Refresh
'    datPrimaryRS.Recordset.AddNew
'    Subject = datPrimaryRS.Recordset.Fields("ID")
'    datPrimaryRS.Recordset.Edit
   fu = 1



    datPrimaryRS.Recordset.Fields("Pumps Low") = lowpumps
    datPrimaryRS.Recordset.Fields("Pumps Med") = mediumpumps
    datPrimaryRS.Recordset.Fields("Pumps High") = highpumps
    datPrimaryRS.Recordset.Fields("Pumps Total") = lowpumps + mediumpumps + highpumps
    datPrimaryRS.Recordset.Fields("Pumps AdjTotal") = adjhighpumps + adjmediumpumps + adjlowpumps
    datPrimaryRS.Recordset.Fields("Pumps AdjLow") = adjlowpumps
    datPrimaryRS.Recordset.Fields("Pumps AdjMed") = adjmediumpumps
    datPrimaryRS.Recordset.Fields("Pumps AdjHigh") = adjhighpumps
    datPrimaryRS.Recordset.Fields("Pumps Avg") = (lowpumps + mediumpumps + highpumps) / 30
    datPrimaryRS.Recordset.Fields("Pumps Avg Low") = (lowpumps) / 10
    datPrimaryRS.Recordset.Fields("Pumps Avg Med") = (mediumpumps) / 10
    datPrimaryRS.Recordset.Fields("Pumps Avg High") = (highpumps) / 10
    datPrimaryRS.Recordset.Fields("Pumps AdjAvg") = adjavg_pumps
    datPrimaryRS.Recordset.Fields("Pumps AdjAvg Low") = Adjavg_lowpumps
    datPrimaryRS.Recordset.Fields("Pumps AdjAvg Med") = Adjavg_mediumpumps
    datPrimaryRS.Recordset.Fields("Pumps AdjAvg High") = Adjavg_highpumps
    datPrimaryRS.Recordset.Fields("Num Total") = numlow + nummedium + numhigh
    datPrimaryRS.Recordset.Fields("Num Low") = numlow
    datPrimaryRS.Recordset.Fields("Num Med") = nummedium
    datPrimaryRS.Recordset.Fields("Num High") = numhigh
    datPrimaryRS.Recordset.Fields("Num AdjTotal") = numlow + nummedium + numhigh - explosions
    datPrimaryRS.Recordset.Fields("Num AdjLow") = numlow - lowexpl
    datPrimaryRS.Recordset.Fields("Num AdjMed") = nummedium - mediumexpl
    datPrimaryRS.Recordset.Fields("Num AdjHigh") = numhigh - highexpl
    datPrimaryRS.Recordset.Fields("$$$ Total") = Val((tvalue + (flashvalue * ExchangeRate)))
    datPrimaryRS.Recordset.Fields("$$$ Low") = adjlowpumps * 1
    datPrimaryRS.Recordset.Fields("$$$ Med") = adjmediumpumps * 1
    datPrimaryRS.Recordset.Fields("$$$ High") = adjhighpumps * 1
    datPrimaryRS.Recordset.Fields("Explosions") = explosions
    datPrimaryRS.Recordset.Fields("Expl Low") = lowexpl
    datPrimaryRS.Recordset.Fields("Expl Med") = mediumexpl
    datPrimaryRS.Recordset.Fields("Expl High") = highexpl
    datPrimaryRS.Recordset.Fields("Duration Session") = TotalSessionLength - ReportTime
    'datPrimaryRS.Recordset.Fields("Duration SR") = ReportTime
    
    '''over here
     datPrimaryRS.Recordset.Update
    
    'If cond = 1 Then
    'datPrimaryRS.Recordset.Fields("high_Est") = pumpup(3) - pumpdown(3)
    'datPrimaryRS.Recordset.Fields("medium_Est") = pumpup(2) - pumpdown(2)
    'datPrimaryRS.Recordset.Fields("low_Est") = pumpup(1) - pumpdown(1)
    'End If
    
   ' If cond = 2 Then
   ' datPrimaryRS.Recordset.Fields("high_Est") = pumpup(2) - pumpdown(2)
   ' datPrimaryRS.Recordset.Fields("medium_Est") = pumpup(3) - pumpdown(3)
   ' datPrimaryRS.Recordset.Fields("low_Est") = pumpup(1) - pumpdown(1)
   ' End If
    
    'If cond = 3 Then
   ' datPrimaryRS.Recordset.Fields("high_Est") = pumpup(2) - pumpdown(2)
   ' datPrimaryRS.Recordset.Fields("medium_Est") = pumpup(1) - pumpdown(1)
   ' datPrimaryRS.Recordset.Fields("low_Est") = pumpup(3) - pumpdown(3)
   ' End If
   '
  '  If cond = 4 Then
  '  datPrimaryRS.Recordset.Fields("high_Est") = pumpup(3) - pumpdown(3)
  '  datPrimaryRS.Recordset.Fields("medium_Est") = pumpup(1) - pumpdown(1)
  '  datPrimaryRS.Recordset.Fields("low_Est") = pumpup(2) - pumpdown(2)
  ''  End If
    
   ' If cond = 5 Then
   ' datPrimaryRS.Recordset.Fields("high_Est") = pumpup(1) - pumpdown(1)
   ' datPrimaryRS.Recordset.Fields("medium_Est") = pumpup(3) - pumpdown(3)
   ' datPrimaryRS.Recordset.Fields("low_Est") = pumpup(2) - pumpdown(2)
   ' End If
    
  '  If cond = 6 Then
  '  datPrimaryRS.Recordset.Fields("high_Est") = pumpup(1) - pumpdown(1)
  '  datPrimaryRS.Recordset.Fields("medium_Est") = pumpup(2) - pumpdown(2)
  '  datPrimaryRS.Recordset.Fields("low_Est") = pumpup(3) - pumpdown(3)
  '  End If
    
    
    'datPrimaryRS.Recordset.Fields("Gender") = IIf(Not IsNull(gender) And Len(gender) > 0, gender, Null)
    'datPrimaryRS.Recordset.Fields("Condition") = IIf(Not IsNull(condition) And Len(condition) > 0, condition, Null)
    'datPrimaryRS.Recordset.Fields("Stressor") = IIf(Not IsNull(stressor) And Len(stressor) > 0, stressor, Null)
    'datPrimaryRS.Recordset.Fields("Session") = IIf(Not IsNull(Session) And Len(Session) > 0, Session, Null)
    'datPrimaryRS.Recordset.Fields("CboSubGen") = IIf(Not IsNull(CboSubGen.Text) And Len(CboSubGen.Text) > 0, CboSubGen, Null)
    'datPrimaryRS.Recordset.Fields("CboStrName") = IIf(Not IsNull(Cbostrname.Text) And Len(Cbostrname.Text) > 0, Cbostrname, Null)
    'datPrimaryRS.Recordset.Fields("CboCond") = IIf(Not IsNull(CboCond.Text) And Len(CboCond.Text) > 0, CboCond, Null)
    'datPrimaryRS.Recordset.Fields("CboExpName") = IIf(Not IsNull(CboExpName) And Len(CboExpName) > 0, CboExpName, Null)
    'datPrimaryRS.Recordset.Fields("CboDate") = IIf(Not IsNull(CboDate) And Len(CboDate) > 0, CboDate, Null)
    'datPrimaryRS.Recordset.Fields("CboTime") = IIf(Not IsNull(CboTime) And Len(CboTime) > 0, CboTime, Null)


X = 1
    Y = 1
    For X = 1 To 30
    
    'If QuickReset(x) > 0 Then
    'Post_IPI(x) = 0
    'End If
    
    For Y = 1 To 129
    coloripitime(X) = coloripitime(X) + all_IPIs(X - 1, Y)
    Next
    
    If QuickReset(X) = 0 Then
 
    colortime(X) = coloripitime(X) + QuickReset(X) + Pre_IPI(X) + Post_IPI(X)
 
    End If
    
    If QuickReset(X) > 0 Then
 
    colortime(X) = QuickReset(X)
    End If
 
  '  End If
    Next

If cond = 1 Then
z = 31
For z = 31 To 50
lowcolortime = lowcolortime + colortime(z)

Next
z = 51
For z = 51 To 70
mediumcolortime = mediumcolortime + colortime(z)

Next
z = 71
For z = 71 To 90
highcolortime = highcolortime + colortime(z)

Next
End If
'----------
If cond = 2 Then
z = 31
For z = 31 To 50
lowcolortime = lowcolortime + colortime(z)

Next
z = 51
For z = 71 To 90
mediumcolortime = mediumcolortime + colortime(z)

Next
z = 71
For z = 51 To 70
highcolortime = highcolortime + colortime(z)

Next
End If
'----------
If cond = 3 Then
z = 31
For z = 51 To 70
lowcolortime = lowcolortime + colortime(z)

Next
z = 51
For z = 71 To 90
mediumcolortime = mediumcolortime + colortime(z)

Next
z = 71
For z = 31 To 50
highcolortime = highcolortime + colortime(z)

Next

End If
'----------
If cond = 4 Then
z = 31
For z = 51 To 70
lowcolortime = lowcolortime + colortime(z)

Next
z = 51
For z = 31 To 50
mediumcolortime = mediumcolortime + colortime(z)

Next
z = 71
For z = 71 To 90
highcolortime = highcolortime + colortime(z)

Next
End If
'----------
If cond = 5 Then
z = 31
For z = 71 To 90
lowcolortime = lowcolortime + colortime(z)

Next
z = 51
For z = 31 To 50
mediumcolortime = mediumcolortime + colortime(z)

Next
z = 71
For z = 51 To 70
highcolortime = highcolortime + colortime(z)

Next
End If
'----------
If cond = 6 Then
z = 31
For z = 71 To 90
lowcolortime = lowcolortime + colortime(z)

Next
z = 51
For z = 51 To 70
mediumcolortime = mediumcolortime + colortime(z)

Next
z = 71
For z = 31 To 50
highcolortime = highcolortime + colortime(z)

Next
End If
    
End If

highcolortime = highcolortime + colortime(1) + colortime(6) + colortime(7) + colortime(13) + colortime(15) + colortime(19) + colortime(21) + colortime(23) + colortime(25) + colortime(30)
mediumcolortime = mediumcolortime + colortime(2) + colortime(4) + colortime(9) + colortime(10) + colortime(14) + colortime(16) + colortime(20) + colortime(24) + colortime(26) + colortime(29)
lowcolortime = lowcolortime + colortime(3) + colortime(5) + colortime(8) + colortime(11) + colortime(12) + colortime(17) + colortime(18) + colortime(22) + colortime(27) + colortime(28)


    'datPrimaryRS.Recordset.Fields("Time Pump Low") = lowcolortime
    'datPrimaryRS.Recordset.Fields("Time Pump Med") = mediumcolortime
    'datPrimaryRS.Recordset.Fields("Time Pump High") = highcolortime
    'datPrimaryRS.Recordset.Fields("Time Pump Total") = highcolortime + mediumcolortime + lowcolortime



'    datPrimaryRS.Recordset.Update

End If
   
   
'FindStr = "MainBalloon"
'    datPrimaryRS.RecordSource = FindStr
'    datPrimaryRS.Refresh
'    datPrimaryRS.Recordset.AddNew
'    Subject = datPrimaryRS.Recordset.Fields("ID")
      
'If form1.CboSubjNum = 2 Then
 '  FindStr1 = "SELECT DISTINCTROW Subject1.* FROM Subject2 WHERE "
'End If
'   FindStr1 = FindStr1 + "ID=" + Str(Subject)
'   datPrimaryRS.RecordSource = FindStr1
 '  datPrimaryRS.Refresh '

If fu2 = 0 Then
i = 0
fu2 = 1
For i = 0 To maxtrials - 1
findstr1 = "subject" ' + Format(form1.CboSubjNum)


'If (Val(form1.CboSubjNum) > 0) And (Val(form1.CboSubjNum) <= 10) Then
'asmerelda = betterthaasmerelda

'Else:  findstr1 = "subject999"
'End If
    
'If (form1.CboSubjNum > 0) And (form1.CboSubjNum <= 10) Then
'asmerelda = betterthaasmerelda

'Else: form1.CboSubjNum = 99
'End If
    
    
    'findstr1 = "Subject2"
    datPrimaryRS.RecordSource = findstr1
    datPrimaryRS.Refresh
    
    
    datPrimaryRS.Recordset.AddNew
    Subject = datPrimaryRS.Recordset.Fields("ID")
 
 '   datPrimaryRS.Recordset.Fields("Quick_Reset") = QuickReset(i + 1)
   
   If QuickReset(i + 1) > 0 Then
   datPrimaryRS.Recordset.Fields("Pre_IPI") = bubkiss
   End If
   
    datPrimaryRS.Recordset.Fields("explosion") = explosion_yn(i + 1)
    If explosion_yn(i + 1) = 0 Then
'    datPrimaryRS.Recordset.Fields("Post_IPI") = Post_IPI(i + 1)
    End If

    
    If (QuickReset(i + 1) > 0) Or (explosion_yn(i + 1) = 1) Then
 '   datPrimaryRS.Recordset.Fields("Post_IPI") = yourmother
    End If
    
    If QuickReset(i + 1) < 0.000000000000001 Then
    
    'If i = 30 Then
    'datPrimaryRS.Recordset.Fields("Pre_IPI") = (Pre_IPI(i + 1) - ReportTime)
    'End If
    
    'If i <> 30 Then
    datPrimaryRS.Recordset.Fields("Pre_IPI") = Pre_IPI(i + 1)
    'End If
    
    
    
'    datPrimaryRS.Recordset.Fields("Post_IPI") = Post_IPI(i + 1)
    End If
        
    datPrimaryRS.Recordset.Fields("Pay Code") = paycode(i)

    
    
    If i = 0 Then
    datPrimaryRS.Recordset.Fields("Start Time") = 0
    End If
    
    
 
    If i <> 0 Then
    datPrimaryRS.Recordset.Fields("Start Time") = (currenttime(i))
    End If
 
        
 
    
    
    datPrimaryRS.Recordset.Fields("Subj Num") = Val(form1.CboSubjNum)
    datPrimaryRS.Recordset.Fields("Sess Num") = Val(form1.cboSessNum)
    datPrimaryRS.Recordset.Fields("Trial Num") = i + 1
    datPrimaryRS.Recordset.Fields("Pumps") = totalpumpsarrayx(i)
 '   datPrimaryRS.Recordset.Fields("IPI_1") = all_IPIs(i, 1)
'    datPrimaryRS.Recordset.Fields("IPI_2") = all_IPIs(i, 2)
  '  datPrimaryRS.Recordset.Fields("IPI_3") = all_IPIs(i, 3)
  '  datPrimaryRS.Recordset.Fields("IPI_4") = all_IPIs(i, 4)
  '  datPrimaryRS.Recordset.Fields("IPI_5") = all_IPIs(i, 5)
  '  datPrimaryRS.Recordset.Fields("IPI_6") = all_IPIs(i, 6)
  '  datPrimaryRS.Recordset.Fields("IPI_7") = all_IPIs(i, 7)
  '  datPrimaryRS.Recordset.Fields("IPI_8") = all_IPIs(i, 8)
  '  datPrimaryRS.Recordset.Fields("IPI_9") = all_IPIs(i, 9)
  '  datPrimaryRS.Recordset.Fields("IPI_10") = all_IPIs(i, 10)
  '  datPrimaryRS.Recordset.Fields("IPI_11") = all_IPIs(i, 11)
  '  datPrimaryRS.Recordset.Fields("IPI_12") = all_IPIs(i, 12)
  '  datPrimaryRS.Recordset.Fields("IPI_13") = all_IPIs(i, 13)
  '  datPrimaryRS.Recordset.Fields("IPI_14") = all_IPIs(i, 14)
  '  datPrimaryRS.Recordset.Fields("IPI_15") = all_IPIs(i, 15)
  '  datPrimaryRS.Recordset.Fields("IPI_16") = all_IPIs(i, 16)
  '  datPrimaryRS.Recordset.Fields("IPI_17") = all_IPIs(i, 17)
  '  datPrimaryRS.Recordset.Fields("IPI_18") = all_IPIs(i, 18)
  '  datPrimaryRS.Recordset.Fields("IPI_19") = all_IPIs(i, 19)
  '  datPrimaryRS.Recordset.Fields("IPI_20") = all_IPIs(i, 20)
  '  datPrimaryRS.Recordset.Fields("IPI_21") = all_IPIs(i, 21)
  '  datPrimaryRS.Recordset.Fields("IPI_22") = all_IPIs(i, 22)
  '  datPrimaryRS.Recordset.Fields("IPI_23") = all_IPIs(i, 23)
  '  datPrimaryRS.Recordset.Fields("IPI_24") = all_IPIs(i, 24)
  '  datPrimaryRS.Recordset.Fields("IPI_25") = all_IPIs(i, 25)
  '  datPrimaryRS.Recordset.Fields("IPI_26") = all_IPIs(i, 26)
  '  datPrimaryRS.Recordset.Fields("IPI_27") = all_IPIs(i, 27)
  '  datPrimaryRS.Recordset.Fields("IPI_28") = all_IPIs(i, 28)
  '  datPrimaryRS.Recordset.Fields("IPI_29") = all_IPIs(i, 29)
  '  datPrimaryRS.Recordset.Fields("IPI_30") = all_IPIs(i, 30)
  '  datPrimaryRS.Recordset.Fields("IPI_31") = all_IPIs(i, 31)
  '  datPrimaryRS.Recordset.Fields("IPI_32") = all_IPIs(i, 32)
  '  datPrimaryRS.Recordset.Fields("IPI_33") = all_IPIs(i, 33)
  '  datPrimaryRS.Recordset.Fields("IPI_34") = all_IPIs(i, 34)
  '  datPrimaryRS.Recordset.Fields("IPI_35") = all_IPIs(i, 35)
  '  datPrimaryRS.Recordset.Fields("IPI_36") = all_IPIs(i, 36)
  '  datPrimaryRS.Recordset.Fields("IPI_37") = all_IPIs(i, 37)
   ' datPrimaryRS.Recordset.Fields("IPI_38") = all_IPIs(i, 38)
   ' datPrimaryRS.Recordset.Fields("IPI_39") = all_IPIs(i, 39)
   ' datPrimaryRS.Recordset.Fields("IPI_40") = all_IPIs(i, 40)
   ' datPrimaryRS.Recordset.Fields("IPI_41") = all_IPIs(i, 41)
   ' datPrimaryRS.Recordset.Fields("IPI_42") = all_IPIs(i, 42)
   ' datPrimaryRS.Recordset.Fields("IPI_43") = all_IPIs(i, 43)
   ' datPrimaryRS.Recordset.Fields("IPI_44") = all_IPIs(i, 44)
   ' datPrimaryRS.Recordset.Fields("IPI_45") = all_IPIs(i, 45)
   ' datPrimaryRS.Recordset.Fields("IPI_46") = all_IPIs(i, 46)
   ' datPrimaryRS.Recordset.Fields("IPI_47") = all_IPIs(i, 47)
   ' datPrimaryRS.Recordset.Fields("IPI_48") = all_IPIs(i, 48)
   ' datPrimaryRS.Recordset.Fields("IPI_49") = all_IPIs(i, 49)
   ' datPrimaryRS.Recordset.Fields("IPI_50") = all_IPIs(i, 50)
   ' datPrimaryRS.Recordset.Fields("IPI_51") = all_IPIs(i, 51)
   ' datPrimaryRS.Recordset.Fields("IPI_52") = all_IPIs(i, 52)
   ' datPrimaryRS.Recordset.Fields("IPI_53") = all_IPIs(i, 53)
   ' datPrimaryRS.Recordset.Fields("IPI_54") = all_IPIs(i, 54)
   ' datPrimaryRS.Recordset.Fields("IPI_55") = all_IPIs(i, 55)
   ' datPrimaryRS.Recordset.Fields("IPI_56") = all_IPIs(i, 56)
   ' datPrimaryRS.Recordset.Fields("IPI_57") = all_IPIs(i, 57)
   ' datPrimaryRS.Recordset.Fields("IPI_58") = all_IPIs(i, 58)
   ' datPrimaryRS.Recordset.Fields("IPI_59") = all_IPIs(i, 59)
   ' datPrimaryRS.Recordset.Fields("IPI_60") = all_IPIs(i, 60)
   ' datPrimaryRS.Recordset.Fields("IPI_61") = all_IPIs(i, 61)
   ' datPrimaryRS.Recordset.Fields("IPI_62") = all_IPIs(i, 62)
   ' datPrimaryRS.Recordset.Fields("IPI_63") = all_IPIs(i, 63)
   ' datPrimaryRS.Recordset.Fields("IPI_64") = all_IPIs(i, 64)
   ' datPrimaryRS.Recordset.Fields("IPI_65") = all_IPIs(i, 65)
   ' datPrimaryRS.Recordset.Fields("IPI_66") = all_IPIs(i, 66)
   ' datPrimaryRS.Recordset.Fields("IPI_67") = all_IPIs(i, 67)
   ' datPrimaryRS.Recordset.Fields("IPI_68") = all_IPIs(i, 68)
   ' datPrimaryRS.Recordset.Fields("IPI_69") = all_IPIs(i, 69)
   ' datPrimaryRS.Recordset.Fields("IPI_70") = all_IPIs(i, 70)
   ' datPrimaryRS.Recordset.Fields("IPI_71") = all_IPIs(i, 71)
   ' datPrimaryRS.Recordset.Fields("IPI_72") = all_IPIs(i, 72)
   ' datPrimaryRS.Recordset.Fields("IPI_73") = all_IPIs(i, 73)
   ' datPrimaryRS.Recordset.Fields("IPI_74") = all_IPIs(i, 74)
   ' datPrimaryRS.Recordset.Fields("IPI_75") = all_IPIs(i, 75)
   ' datPrimaryRS.Recordset.Fields("IPI_76") = all_IPIs(i, 76)
   ' datPrimaryRS.Recordset.Fields("IPI_77") = all_IPIs(i, 77)
   ' datPrimaryRS.Recordset.Fields("IPI_78") = all_IPIs(i, 78)
   ' datPrimaryRS.Recordset.Fields("IPI_79") = all_IPIs(i, 79)
   ' datPrimaryRS.Recordset.Fields("IPI_80") = all_IPIs(i, 80)
   ' datPrimaryRS.Recordset.Fields("IPI_81") = all_IPIs(i, 81)
   ' datPrimaryRS.Recordset.Fields("IPI_82") = all_IPIs(i, 82)
   ' datPrimaryRS.Recordset.Fields("IPI_83") = all_IPIs(i, 83)
   ' datPrimaryRS.Recordset.Fields("IPI_84") = all_IPIs(i, 84)
   ' datPrimaryRS.Recordset.Fields("IPI_85") = all_IPIs(i, 85)
   ' datPrimaryRS.Recordset.Fields("IPI_86") = all_IPIs(i, 86)
   ' datPrimaryRS.Recordset.Fields("IPI_87") = all_IPIs(i, 87)
   ' datPrimaryRS.Recordset.Fields("IPI_88") = all_IPIs(i, 88)
   ' datPrimaryRS.Recordset.Fields("IPI_89") = all_IPIs(i, 89)
   ' datPrimaryRS.Recordset.Fields("IPI_90") = all_IPIs(i, 90)
   ' datPrimaryRS.Recordset.Fields("IPI_91") = all_IPIs(i, 91)
   ' datPrimaryRS.Recordset.Fields("IPI_92") = all_IPIs(i, 92)
   ' datPrimaryRS.Recordset.Fields("IPI_93") = all_IPIs(i, 93)
   ' datPrimaryRS.Recordset.Fields("IPI_94") = all_IPIs(i, 94)
   ' datPrimaryRS.Recordset.Fields("IPI_95") = all_IPIs(i, 95)
   ' datPrimaryRS.Recordset.Fields("IPI_96") = all_IPIs(i, 96)
   ' datPrimaryRS.Recordset.Fields("IPI_97") = all_IPIs(i, 97)
   ' datPrimaryRS.Recordset.Fields("IPI_98") = all_IPIs(i, 98)
   ' datPrimaryRS.Recordset.Fields("IPI_99") = all_IPIs(i, 99)
   ' datPrimaryRS.Recordset.Fields("IPI_100") = all_IPIs(i, 100)
   ' datPrimaryRS.Recordset.Fields("IPI_101") = all_IPIs(i, 101)
   ' datPrimaryRS.Recordset.Fields("IPI_102") = all_IPIs(i, 102)
   ' datPrimaryRS.Recordset.Fields("IPI_103") = all_IPIs(i, 103)
   ' datPrimaryRS.Recordset.Fields("IPI_104") = all_IPIs(i, 104)
   ' datPrimaryRS.Recordset.Fields("IPI_105") = all_IPIs(i, 105)
   ' datPrimaryRS.Recordset.Fields("IPI_106") = all_IPIs(i, 106)
   ' datPrimaryRS.Recordset.Fields("IPI_107") = all_IPIs(i, 107)
   ' datPrimaryRS.Recordset.Fields("IPI_108") = all_IPIs(i, 108)
   ' datPrimaryRS.Recordset.Fields("IPI_109") = all_IPIs(i, 109)
   ' datPrimaryRS.Recordset.Fields("IPI_110") = all_IPIs(i, 110)
   ' datPrimaryRS.Recordset.Fields("IPI_111") = all_IPIs(i, 111)
   ' datPrimaryRS.Recordset.Fields("IPI_112") = all_IPIs(i, 112)
   ' datPrimaryRS.Recordset.Fields("IPI_113") = all_IPIs(i, 113)
   ' datPrimaryRS.Recordset.Fields("IPI_114") = all_IPIs(i, 114)
   ' datPrimaryRS.Recordset.Fields("IPI_115") = all_IPIs(i, 115)
   ' datPrimaryRS.Recordset.Fields("IPI_116") = all_IPIs(i, 116)
   ' datPrimaryRS.Recordset.Fields("IPI_117") = all_IPIs(i, 117)
   ' datPrimaryRS.Recordset.Fields("IPI_118") = all_IPIs(i, 118)
   ' datPrimaryRS.Recordset.Fields("IPI_119") = all_IPIs(i, 119)
   ' datPrimaryRS.Recordset.Fields("IPI_120") = all_IPIs(i, 120)
   ' datPrimaryRS.Recordset.Fields("IPI_120") = all_IPIs(i, 121)
   ' datPrimaryRS.Recordset.Fields("IPI_121") = all_IPIs(i, 121)
   ' datPrimaryRS.Recordset.Fields("IPI_122") = all_IPIs(i, 122)
   ' datPrimaryRS.Recordset.Fields("IPI_123") = all_IPIs(i, 123)
   ' datPrimaryRS.Recordset.Fields("IPI_124") = all_IPIs(i, 124)
   ' datPrimaryRS.Recordset.Fields("IPI_125") = all_IPIs(i, 125)
   ' datPrimaryRS.Recordset.Fields("IPI_126") = all_IPIs(i, 126)
   ' datPrimaryRS.Recordset.Fields("IPI_127") = all_IPIs(i, 127)
   ' datPrimaryRS.Recordset.Fields("IPI_128") = all_IPIs(i, 128)
   ' datPrimaryRS.Recordset.Fields("IPI_129") = all_IPIs(i, 129)
        datPrimaryRS.Recordset.Update
CmdPump.Visible = False
ShpBalloon.Visible = False
CmdReset.Visible = False
cmdpumpconfirm.Visible = False
Shape2.Visible = False
txtpumpnum.Visible = False

    Next
    
    
End If












End





End Sub


Private Sub Command2_Click()
'Form3.Show
'Form2.Hide

'gothrough = 1

'Command2.Visible = False
'CmdPump.Visible = True
'CmdReset.Visible = True
End Sub


Private Sub Form_Load()
'DlPortWritePortUlong 888, Val("&HFF0F")
'txtbalnum.Text = "1"
j = 1
maxtrials = 30
    
preExchangeRate = 1
numlow = 1 + numlow
textpumpvalue.Text = Str(preExchangeRate)
If preExchangeRate = 1 Then
textpumpvalue.Text = "1"
End If

txtbalnum.Text = "1"
balnum = 1
paycode(0) = 1
    
    
    
    
    

cond = 1
'textpumpvalue.Text = Str(1)

    
    

ii = 1
'Dim FindStr As String
   
   'FindStr = "SELECT DISTINCTROW mainballoon.* FROM mainballoon WHERE "
   'FindStr = FindStr + "ID=" + Str(Subject)
   'datPrimaryRS.RecordSource = FindStr
   'datPrimaryRS.Refresh


'FindStr = "Mainballoon"




balloontype = 1
IPI_Start = Timer
color(1) = 1


   MMControl1.Notify = False
   MMControl1.Wait = True
   MMControl1.Shareable = False
   MMControl1.DeviceType = "WaveAudio"
   MMControl1.FileName = "C:\Risk Task\Sounds\casino.WAV"

   ' Open the MCI WaveAudio device.
   MMControl1.Command = "Open"

' Set properties needed by MCI to open.
   MMControl3.Notify = False
   MMControl3.Wait = True
   MMControl3.Shareable = False
   MMControl3.DeviceType = "WaveAudio"
   MMControl3.FileName = "C:\Risk Task\Sounds\finale.WAV"

   ' Open the MCI WaveAudio device.
   MMControl3.Command = "Open"


MMControl4.Notify = False
   MMControl4.Wait = True
   MMControl4.Shareable = False
   MMControl4.DeviceType = "WaveAudio"
   MMControl4.FileName = "C:\Risk Task\Sounds\explosion.WAV"




   ' Open the MCI WaveAudio device.
   MMControl4.Command = "Open"

'If sessnum = 1 Then
'BurstRange = Array(65, 17, 5, 30, 8, 88, 31, 1, 9, 18, 4, 3, 90, 6, 44, 19, 5, 2, 98, 20, 92, 6, 21, 24, 96, 2, 1, 8, 15, 16, 4, 2, 5, 7, 4, 1, 2, 6, 7, 7, 8, 3, 6, 1, 3, 5, 2, 6, 8, 3, 22, 3, 21, 10, 16, 20, 7, 29, 32, 1, 12, 28, 5, 19, 26, 8, 23, 11, 25, 4, 105, 18, 68, 71, 16, 30, 121, 60, 31, 125, 56, 115, 26, 107, 11, 98, 82, 36, 77, 33)
'End If
'If sessnum = 2 Then
'BurstRange = Array(65, 17, 5, 30, 8, 88, 31, 1, 9, 18, 4, 3, 90, 6, 44, 19, 5, 2, 98, 20, 92, 6, 21, 24, 96, 2, 1, 8, 15, 16, 4, 2, 5, 7, 4, 1, 2, 6, 7, 7, 8, 3, 6, 1, 3, 5, 2, 6, 8, 3, 22, 3, 21, 10, 16, 20, 7, 29, 32, 1, 12, 28, 5, 19, 26, 8, 23, 11, 25, 4, 105, 18, 68, 71, 16, 30, 121, 60, 31, 125, 56, 115, 26, 107, 11, 98, 82, 36, 77, 33)
'End If
'If sessnum = 3 Then
'BurstRange = Array(65, 17, 5, 30, 8, 88, 31, 1, 9, 18, 4, 3, 90, 6, 44, 19, 5, 2, 98, 20, 92, 6, 21, 24, 96, 2, 1, 8, 15, 16, 4, 2, 5, 7, 4, 1, 2, 6, 7, 7, 8, 3, 6, 1, 3, 5, 2, 6, 8, 3, 22, 3, 21, 10, 16, 20, 7, 29, 32, 1, 12, 28, 5, 19, 26, 8, 23, 11, 25, 4, 105, 18, 68, 71, 16, 30, 121, 60, 31, 125, 56, 115, 26, 107, 11, 98, 82, 36, 77, 33)
'End If

BurstRange = Array(65, 104, 39, 80, 21, 8, 121, 96, 60, 38, 64, 101, 26, 34, 41, 121, 62, 95, 75, 13, 70, 112, 30, 88, 9, 72, 91, 17, 115, 52) '68, 70, 64, 101, 105, 101, 26, 29, 34, 55, 89, 18, 88, 9, 36, 121, 21, 125, 88, 76, 111, 17, 24, 95, 66, 21, 113, 84, 52, 13, 19, 66, 48, 23, 118, 32, 46, 63, 93, 127, 11, 55, 85, 115, 87, 29, 85, 71, 121, 62, 51, 45, 91, 47, 107, 26, 66, 40, 6, 85
sessionstarttime = Timer


TotalNumberofPumps = 180

'MsgBox (form1.condition)
If SetThrough = 0 Then

InitialSetTop = ShpBalloon.Top
InitialSetHeight = ShpBalloon.Height
InitialSetLeft = ShpBalloon.Left
InitialSetWidth = ShpBalloon.Width

SetThrough = 1
End If



ShpBalloon.Top = InitialSetTop
ShpBalloon.Height = InitialSetHeight
ShpBalloon.Left = InitialSetLeft
ShpBalloon.Width = InitialSetWidth
'FrmFill.Width = InitialSetFrmFillWidth

'FrmFill.Width = 0 '9600 / totalnumberofpumps

'SetWidth_Meter = 9600 / TotalNumberofPumps

SetHeight = 5800 / TotalNumberofPumps
SetLeft = 3625 / TotalNumberofPumps
SetTop = 5800 / TotalNumberofPumps
SetWidth = 7255 / TotalNumberofPumps


  'datPrimaryRS.DatabaseName = sDir & "\balloon.mdb"


End Sub




Public Sub Timer1_Timer()





If ((DoTimer = 1) And (flashvalue < TempPointCount)) And (resetnow = 1) Then
'Do Until flashvalue = PointCount

Now = Timer

flashvalue = 1 + flashvalue
'Beep
'thisscore = (flashvalue * ExchangeRate)
'MsgBox (flashvalue)
'MsgBox (DoTimer)
'MsgBox (TempPointCount)


TextScore.Text = FormatCurrency((tvalue + (flashvalue * ExchangeRate)) / 100, -1)

'If j = 31 And gothrough = 0 Then
'Form3.Show
'Form2.Hide
'gothrough = 1


'End If

q = 1
''maybe not
   'MMControl1.Command = "prev"
   'MMControl1.Command = "play"
   'MMControl1.Command = "prev"



'   MMControl2.Command = "rewind"
 '  MMControl2.Command = "play"
  ' MMControl2.Command = "rewind"

'Loop


End If


Now = Timer
If Now - now1 > 1 Then

''''''''''
If (i < maxtrials) Then


CmdPump.Visible = True
CmdReset.Visible = True
cmdpumpconfirm.Visible = True
txtpumpnum.Visible = True
txtpumpnum.SetFocus

'MousePointer

'If i > 0 Then
currenttime(i) = Now - sessionstarttime
'End If
End If


now1 = 1000000
End If


If ((flashvalue = TempPointCount) And (q = 1)) Or ((loophole = 1) And (both = 0)) Then
'MsgBox (TempPointCount)
loophole = 0
both = 1


'MsgBox (textpumpvalue.Text)
'PointCount = PointCount + TempPointCount
TempPointCount = 0
q = 0
MMControl1.Command = "stop"
resetnow = 0



'If j = 30 And gothrough = 0 Then
'TextScore.Text = FormatCurrency((tvalue + (flashvalue * ExchangeRate)) / 100, -1)

'Command2.Visible = True
'CmdPump.Visible = False
'CmdReset.Visible = False
'ReportStart = Now
'currenttime(i) = Now - sessionstarttime
'MsgBox (Now)
'If through = 1 Then



'End If


'End If


If i < maxtrials Then
'MsgBox (i)
'MsgBox (maxtrials)
'If j <> 30 Then
CmdReset.Visible = True
CmdPump.Visible = True
cmdpumpconfirm.Visible = True
txtpumpnum.Visible = True
txtpumpnum.SetFocus
currenttime(i) = Now - sessionstarttime
'MsgBox (currenttime(i))
'MsgBox (Now - sessionstarttime)
End If
'End If
IPI_Start = Timer


If i = maxtrials Then

loophole = 1
sessionstoptime = Timer
TotalSessionLength = sessionstoptime - sessionstarttime

If timethrough = 0 Then

'Form3.Show
'Form2.Hide

'label4.Visible = True
Command1.Visible = True
'TextScoreList.Visible = True
timethrough = 1
Label3.Visible = True
End If
CmdReset.Visible = False
CmdPump.Visible = False
cmdpumpconfirm.Visible = False
txtpumpnum.Visible = False
Shape2.Visible = False
ShpBalloon.Visible = False
txtpumpnum.Visible = False



MMControl3.Command = "prev"
   MMControl3.Command = "play"
   MMControl3.Command = "prev"

'CmdReset.Visible = False
'CmdPump.Visible = False

'MsgBox (TotalSessionLength)



'MsgBox (2)
TextScoreList.Visible = True
TextScoreList.Text = FormatCurrency((tvalue + (flashvalue * ExchangeRate)) / 100, -1)
TextScore.Text = FormatCurrency((tvalue + (flashvalue * ExchangeRate)) / 100, -1)





CmdPump.Visible = False
ShpBalloon.Visible = False
CmdReset.Visible = False
Shape2.Visible = False
cmdpumpconfirm.Visible = False
txtpumpnum.Visible = False
'Call writetofile keep
End If

End If

'If Now - Start > 3 Then
'Now = Timer
'DoTimer = 0
'End If


End Sub

