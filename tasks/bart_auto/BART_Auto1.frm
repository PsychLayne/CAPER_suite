VERSION 5.00
Begin VB.Form form1 
   ClientHeight    =   9675
   ClientLeft      =   4275
   ClientTop       =   2640
   ClientWidth     =   14025
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   ScaleHeight     =   9675
   ScaleWidth      =   14025
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin VB.ComboBox cboSessNum 
      Height          =   315
      Left            =   4800
      TabIndex        =   12
      Top             =   5160
      Width           =   2055
   End
   Begin VB.ComboBox CboSubjGen 
      Height          =   315
      Left            =   4800
      TabIndex        =   9
      Top             =   3960
      Width           =   2055
   End
   Begin VB.CommandButton CmdBegin 
      Caption         =   "Click to Begin"
      Height          =   495
      Left            =   6720
      TabIndex        =   8
      Top             =   6480
      Width           =   1695
   End
   Begin VB.ComboBox CboSubjNum 
      Height          =   315
      Left            =   4800
      TabIndex        =   6
      Top             =   2760
      Width           =   2055
   End
   Begin VB.ComboBox CboTime 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "HH:mm"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1033
         SubFormatType   =   4
      EndProperty
      Height          =   315
      Left            =   8280
      TabIndex        =   4
      Top             =   5160
      Width           =   2055
   End
   Begin VB.ComboBox CboDate 
      Height          =   315
      Left            =   8280
      TabIndex        =   2
      Top             =   3960
      Width           =   2055
   End
   Begin VB.ComboBox CboExpName 
      Height          =   315
      Left            =   8280
      TabIndex        =   0
      Top             =   2760
      Width           =   2055
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      Caption         =   "Session Number"
      Height          =   255
      Index           =   1
      Left            =   4800
      TabIndex        =   11
      Top             =   4920
      Width           =   2055
   End
   Begin VB.Label Label8 
      Alignment       =   2  'Center
      Caption         =   "Subject Gender"
      Height          =   255
      Left            =   4800
      TabIndex        =   10
      Top             =   3720
      Width           =   2055
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      Caption         =   "Subject Number"
      Height          =   255
      Index           =   0
      Left            =   4800
      TabIndex        =   7
      Top             =   2520
      Width           =   2055
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      Caption         =   "Current Time"
      Height          =   255
      Left            =   8280
      TabIndex        =   5
      Top             =   4920
      Width           =   2055
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      Caption         =   "Today's Date"
      Height          =   255
      Left            =   8280
      TabIndex        =   3
      Top             =   3720
      Width           =   2055
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Experimenter Initials"
      Height          =   255
      Left            =   8280
      TabIndex        =   1
      Top             =   2520
      Width           =   2055
   End
End
Attribute VB_Name = "form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public stressor As String
Public gender As String
Public condition As String
Public Session As String








Private Sub Cmbstr_Change()

End Sub

Private Sub Cmbstrname_Change()

End Sub

Public Sub CmdBegin_Click()
'  Beep
  
    




If (CboSubjGen.Text = "Male") Then
gender = "1"
End If

If (CboSubjGen.Text = "Female") Then
gender = "2"
End If





Form7.Show
form1.Hide

End Sub

Private Sub Combo1_Change()

End Sub

Public Sub Form_Load()

    CboSubjGen.AddItem "Male"
   CboSubjGen.AddItem "Female"
   

   
   CboDate.Text = Date
   CboTime.Text = Time
  ' DlPortWritePortUlong 888, Val("&HFF0F")
   
End Sub


Public Sub Form_Unload(Cancel As Integer)
End Sub
'Load Form5
'Unload Form5



