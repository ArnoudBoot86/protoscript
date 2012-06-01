VERSION 5.00
Begin VB.Form main 
   Caption         =   "Beagle VB6 Examples"
   ClientHeight    =   4395
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3270
   LinkTopic       =   "Form1"
   ScaleHeight     =   4395
   ScaleWidth      =   3270
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command4
      Caption         =   "Capture MDIO"
      Height          =   615
      Left            =   600
      TabIndex        =   3
      Top             =   3240
      Width           =   2175
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Capture SPI"
      Height          =   615
      Left            =   600
      TabIndex        =   2
      Top             =   2400
      Width           =   2175
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Capture I2C"
      Height          =   615
      Left            =   600
      TabIndex        =   1
      Top             =   1560
      Width           =   2175
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Detect"
      Height          =   615
      Left            =   600
      TabIndex        =   0
      Top             =   720
      Width           =   2175
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Beagle VB6 Examples"
      Height          =   375
      Left            =   840
      TabIndex        =   4
      Top             =   120
      Width           =   1815
   End
End
Attribute VB_Name = "main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
    Call detect_run
End Sub

Private Sub Command2_Click()
    Call capture_i2c_run
End Sub

Private Sub Command3_Click()
    Call capture_spi_run
End Sub

Private Sub Command4_Click()
    Call capture_mdio_run
End Sub

