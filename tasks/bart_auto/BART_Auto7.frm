VERSION 5.00
Begin VB.Form Form7 
   BackColor       =   &H00FFC0FF&
   ClientHeight    =   13380
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   21480
   ControlBox      =   0   'False
   LinkTopic       =   "Form7"
   ScaleHeight     =   13380
   ScaleWidth      =   21480
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.CommandButton Command1 
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
      Left            =   5760
      MaskColor       =   &H00FF0000&
      Style           =   1  'Graphical
      TabIndex        =   16
      Top             =   10560
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
      Left            =   5760
      TabIndex        =   9
      Top             =   9600
      Width           =   3495
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
      Left            =   1080
      TabIndex        =   8
      Top             =   9600
      Width           =   3495
   End
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
      Left            =   11640
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   10680
      Width           =   1815
   End
   Begin VB.CommandButton CmdCont 
      BackColor       =   &H00C0C0FF&
      Caption         =   "Press to Continue"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   20.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1215
      Left            =   11640
      MaskColor       =   &H00C0C0FF&
      TabIndex        =   5
      Top             =   6840
      UseMaskColor    =   -1  'True
      Width           =   1935
   End
   Begin VB.TextBox TextScore 
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
      HideSelection   =   0   'False
      Left            =   11640
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   8760
      Width           =   1815
   End
   Begin VB.TextBox texttempscore 
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
      Left            =   11640
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   9705
      Width           =   1815
   End
   Begin VB.CommandButton CmdPumpdemo 
      Caption         =   "          Click Here to               Pump up the Balloon"
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
      Left            =   5760
      TabIndex        =   0
      Top             =   9600
      Width           =   3495
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
      Left            =   1080
      TabIndex        =   19
      Top             =   8040
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
      Left            =   1080
      TabIndex        =   18
      Top             =   8880
      Width           =   3495
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label7 
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
      Left            =   1080
      TabIndex        =   17
      Top             =   8520
      Width           =   3495
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label10 
      BackColor       =   &H0080C0FF&
      Caption         =   $"BART_Auto7.frx":0000
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   480
      TabIndex        =   15
      Top             =   960
      Width           =   14055
   End
   Begin VB.Label Label6 
      BackColor       =   &H0080C0FF&
      Caption         =   $"BART_Auto7.frx":00C2
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2415
      Left            =   480
      TabIndex        =   14
      Top             =   1920
      Width           =   14055
   End
   Begin VB.Label Label5 
      BackColor       =   &H0080C0FF&
      Caption         =   $"BART_Auto7.frx":02EF
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1215
      Left            =   480
      TabIndex        =   13
      Top             =   4440
      Width           =   14055
   End
   Begin VB.Label Label3 
      BackColor       =   &H0080C0FF&
      Caption         =   "After each $$$ collection or explosion, a new balloon will appear."
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   480
      TabIndex        =   12
      Top             =   5760
      Width           =   14055
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H0080C0FF&
      Caption         =   "Instructions"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   480
      TabIndex        =   11
      Top             =   360
      Width           =   14055
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
      Left            =   1080
      TabIndex        =   10
      Top             =   10560
      Width           =   3495
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
      Left            =   10200
      TabIndex        =   7
      Top             =   10680
      Width           =   1335
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H0000FF00&
      Caption         =   "Total Earned"
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
      Left            =   10200
      TabIndex        =   4
      Top             =   8760
      Width           =   1335
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFF80&
      Caption         =   "  Cents  per Pump"
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
      Left            =   10200
      TabIndex        =   3
      Top             =   9720
      Width           =   1335
   End
   Begin VB.Shape ShpBalloon 
      BackColor       =   &H00FF0000&
      BackStyle       =   1  'Opaque
      FillColor       =   &H00FF0000&
      FillStyle       =   0  'Solid
      Height          =   3000
      Left            =   6000
      Shape           =   2  'Oval
      Top             =   6375
      Width           =   3000
   End
   Begin VB.Shape Shape2 
      FillStyle       =   0  'Solid
      Height          =   255
      Left            =   7200
      Top             =   9360
      Width           =   495
   End
End
Attribute VB_Name = "Form7"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub CmdCont_Click()
Form7.Hide
Form9.Show
End Sub

