VERSION 5.00
Begin VB.Form Form6 
   ClientHeight    =   6030
   ClientLeft      =   60
   ClientTop       =   60
   ClientWidth     =   11445
   ControlBox      =   0   'False
   LinkTopic       =   "Form6"
   ScaleHeight     =   6030
   ScaleWidth      =   11445
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   3840
      Top             =   480
   End
   Begin VB.Label txtbegin 
      Caption         =   "The Experiment Will Begin in One Minute"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   32.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1935
      Left            =   360
      TabIndex        =   2
      Top             =   3360
      Visible         =   0   'False
      Width           =   11055
   End
   Begin VB.Label txt10min 
      Alignment       =   2  'Center
      Caption         =   "for the next 10 minutes"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   48
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1215
      Left            =   720
      TabIndex        =   1
      Top             =   4440
      Width           =   10095
   End
   Begin VB.Label txtrelax 
      Alignment       =   2  'Center
      Caption         =   "Relax"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   72
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1575
      Left            =   840
      TabIndex        =   0
      Top             =   2640
      Width           =   9855
   End
End
Attribute VB_Name = "Form6"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



