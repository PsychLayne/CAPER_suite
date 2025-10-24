VERSION 5.00
Begin VB.Form Form9 
   BackColor       =   &H00C0FFFF&
   ClientHeight    =   8880
   ClientLeft      =   165
   ClientTop       =   165
   ClientWidth     =   14850
   ControlBox      =   0   'False
   LinkTopic       =   "Form4"
   ScaleHeight     =   8880
   ScaleWidth      =   14850
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.CommandButton CmdInst 
      Caption         =   "When you are ready, click here to begin"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   20.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1575
      Left            =   1200
      TabIndex        =   0
      Top             =   7560
      Width           =   12255
   End
   Begin VB.Label Label7 
      BackColor       =   &H0080C0FF&
      Caption         =   "* The best overall strategy is 64 pumps"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   21.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1200
      TabIndex        =   7
      Top             =   4680
      Width           =   12255
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H0080C0FF&
      Caption         =   "Now, do you have any questions?"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   21.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1200
      TabIndex        =   6
      Top             =   6600
      Width           =   12255
   End
   Begin VB.Label Label6 
      BackColor       =   &H0080C0FF&
      Caption         =   "* You type in how many pumps yopu want the computer to make"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   21.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1200
      TabIndex        =   5
      Top             =   1800
      Width           =   12255
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00C0FFFF&
      Caption         =   "Summary"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   36
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   2640
      TabIndex        =   4
      Top             =   600
      Width           =   9135
   End
   Begin VB.Label Label5 
      BackColor       =   &H0080C0FF&
      Caption         =   "* You earn 1 cent for each pump if the balloon does not explode"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   21.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1200
      TabIndex        =   3
      Top             =   2760
      Width           =   12255
   End
   Begin VB.Label Label3 
      BackColor       =   &H0080C0FF&
      Caption         =   "* You save money for a balloon when it does not explode"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   21.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1200
      TabIndex        =   2
      Top             =   3720
      Width           =   12255
   End
   Begin VB.Label Label2 
      BackColor       =   &H0080C0FF&
      Caption         =   "* There are just 30 balloons "
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   21.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1200
      TabIndex        =   1
      Top             =   5640
      Width           =   12255
   End
End
Attribute VB_Name = "Form9"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub CmdInst_Click()
Form2.Show
Form9.Hide

End Sub

