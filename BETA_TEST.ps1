#=====Начало меню №1 =====#
######################################
Add-Type -Assembly system.windows.forms # класс для графического GUI
Add-Type -AssemblyName System.Drawing
 #---------------------------------------------------Авторизация от Администратор-----------------------------------#
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}


#---------------------------------------------------Начало меню окна №1-----------------------------------#
#---------------------------------------------------Логика-----------------------------------#
######################################
#####################################
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "TEST"
$Form.StartPosition = "CenterScreen"
$Form.Width = 700
$Form.Height = 500
######################################
######################################
$knopka1 = New-Object System.Windows.Forms.Button
$knopka1.Size = New-Object System.Drawing.Point 100,80
$knopka1.Text = "Выполнить"
$knopka1.Location = New-Object System.Drawing.Point 570,370
$form.Controls.Add($knopka1)
######################################
######################################
$galochka1 = New-Object System.Windows.Forms.Checkbox
$galochka1.Autosize = $true
$galochka1.Size = New-Object System.Drawing.Size(100,10)
$galochka1.Location = New-Object System.Drawing.Size(10,10)
$galochka1.Text = 'ChatGPT'
$knopka1.add_click({ $(if ($galochka1.Checked) {
Start-Process https://console.yandex.cloud/folders/b1gm50gt4cu8ldorbb44/foundation-models/chat
})})

$Form.Controls.Add($galochka1)
######################################
######################################
$form2 = New-Object System.Windows.Forms.Form
$form2.Text = "Проверка доступности сайтов"
$form2.Size = New-Object System.Drawing.Size(400,300)
$form2.StartPosition = "CenterScreen"
######################################
######################################
$form.KeyPreview = $True
$form.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
    {
    # if enter, perform click
    $button.PerformClick()
    }
})
$form.Add_KeyDown({if ($_.KeyCode -eq "Escape") 
    {
    # if escape, exit
    $form.Close()
    }
})

$button = New-Object System.Windows.Forms.Button
$button.Size = New-Object System.Drawing.Size(200, 25)
$button.Location = New-Object System.Drawing.Point(450,10)
$button.Text = "Проверить доступность IP_Domen"
$button.Add_Click({
    $textBox.Text = ""
    $checkedSites = $checkedSitesTextBox.Text.Split("`n")
    foreach ($site in $checkedSites) {
        $ping = New-Object System.Net.NetworkInformation.Ping
        $reply = $ping.Send($site)
        if ($reply.Status -eq "Success") {
            $textBox.AppendText("$site доступен`n")
        } else {
            $textBox.AppendText("$site недоступен`n")
        }
    }
})

$checkedSitesTextBox = New-Object System.Windows.Forms.TextBox
$checkedSitesTextBox.Location = New-Object System.Drawing.Point(450, 40)
$checkedSitesTextBox.Size = New-Object System.Drawing.Size(200, 20)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(450, 70)
$textBox.Size = New-Object System.Drawing.Size(200,100)
$textBox.MultiLine = $true

$form.Controls.Add($button)
$form.Controls.Add($checkedSitesTextBox)
$form.Controls.Add($textBox)
######################################
######################################




######################################
######################################
#$galochka2 = New-Object System.Windows.Forms.CheckBox
#$galochka2.Autosize = $true
#$galochka2.Size = New-Object System.Drawing.Size(100,10)
#$galochka2.Location = New-Object System.Drawing.Size(10,30)
#$galochka2.Text = "Удалить OneDrive"
#$knopka1.add_click({ $(if ($galochka2.Checked) {  
#    cmd /c "takeown /f C:\Windows\SysWOW64\OneDriveSetup.exe"
#    cmd /c "icacls C:\Windows\SysWOW64\OneDriveSetup.exe /grant:r %USERDOMAIN%\%USERNAME%:F /c"
#    cmd /c "del /a /f /q C:\Windows\SysWOW64\OneDriveSetup.exe"
#
#    cmd /c "takeown /f C:\Windows\System32\OneDriveSetup.exe"
#    cmd /c "icacls C:\Windows\System32\OneDriveSetup.exe /grant:r %USERDOMAIN%\%USERNAME%:F /c"
#    cmd /c "del /a /f /q C:\Windows\System32\OneDriveSetup.exe"
#
#    cmd /c "takeown /f C:\Windows\SysWOW64\OneDriveSettingSyncProvider.dll"
#    cmd /c "icacls C:\Windows\SysWOW64\OneDriveSettingSyncProvider.dll /grant:r %USERDOMAIN%\%USERNAME%:F /c"
#    cmd /c "del /a /f /q C:\Windows\SysWOW64\OneDriveSettingSyncProvider.dll"
#
#    cmd /c "takeown /f C:\Windows\SysWOW64\OneDrive.ico"
#    cmd /c "icacls C:\Windows\SysWOW64\OneDrive.ico /grant:r %USERDOMAIN%\%USERNAME%:F /c"
#    cmd /c "del /a /f /q C:\Windows\SysWOW64\OneDrive.ico"
#    })})
#$form.Controls.Add($galochka2)
#########################################
#########################################
#$UWPapps = @(
#    "Microsoft.549981C3F5F10"
#    "Microsoft.BingWeather"
#    "Microsoft.GetHelp"
#   "Microsoft.MicrosoftOfficeHub"
#    "Microsoft.MicrosoftSolitaireCollection"
#    "Microsoft.MixedReality.Portal"
#    "Microsoft.Office.OneNote"
#    "Microsoft.People"
#    "Microsoft.SkypeApp"
#    "Microsoft.WindowsFeedbackHub"
#    "Microsoft.Xbox.TCUI"
#    "Microsoft.XboxApp"
#    "Microsoft.XboxGameOverlay"
#    "Microsoft.XboxGamingOverlay"
#    "Microsoft.XboxIdentityProvider"
#    "Microsoft.XboxSpeechToTextOverlay"
#    "Microsoft.ZuneMusic"
#    "Microsoft.ZuneVideo"
#    "Microsoft.WindowsMaps"
#    "Yandex.Music"
#    "Microsoft.XboxGameCallableUI"
#    "Microsoft.Getstarted"	
#)
#    
#$galochka3 = New-Object System.Windows.Forms.CheckBox
#$galochka3.Autosize = $true
#$galochka3.Location = New-Object System.Drawing.Point(10,50)
#$galochka3.Text = "Удалить стандартный набор встроенных приложений"
#$knopka1.add_click({ $(if ($galochka3.Checked)    #Действие чекбокса при нажатии кнопки
#{  
#$defautdeloutput = @()
#ForEach($UWPapp in $UWPapps){ 
#$defautdeloutput += Get-AppXProvisionedPackage -Online | Where-Object DisplayName -eq $UWPApp 
#}
#$defautdeloutput | Out-GridView -PassThru -Title "Набор Provisioned приложений" | Remove-AppxProvisionedPackage -online
#ForEach($UWPapp in $UWPapps){ 
#$defautdeloutput += Get-AppXPackage -allusers | Where-Object DisplayName -eq $UWPApp 
#}
#$defautdeloutput | Out-GridView -PassThru -Title "Набор приложений пользователей"| Remove-AppxPackage
#})})
#$form.Controls.Add($galochka3)
#########################################
#-----------------------------------------------------------------------------------------------------------#
#--------------------------------------------------- Начало меню окна №2 -----------------------------------#
######################################
######################################
$Form1 = New-Object System.Windows.Forms.Form
$Form1.Text = "TEST1"
$Form1.StartPosition = "CenterScreen"
$Form1.Width = 600
$Form1.Height = 400
######################################
######################################
$knopka2 = New-Object System.Windows.Forms.Button
$knopka2.Size = New-Object System.Drawing.Point 100,80
$knopka2.Location = New-Object System.Drawing.Point 10,370
$knopka2.Text = 'Инструменты'
$knopka2.add_click{
$form1.ShowDialog()
}
$form1.Topmost = $true
$form.Controls.Add($knopka2)
######################################
######################################
#########################################
$knopka4 = New-Object System.Windows.Forms.Button
$knopka4.Size = New-Object System.Drawing.Point 100,50
$knopka4.Location = New-Object System.Drawing.Point 370,10
$knopka4.Text = 'Файл hosts'
$knopka4.add_click{
Start-Process C:\Windows\System32\drivers\etc\hosts

}
$form1.Controls.Add($knopka4)
######################################
######################################
$knopka5 = New-Object System.Windows.Forms.Button
$knopka5.Size = New-Object System.Drawing.Point 100,50
$knopka5.Location = New-Object System.Drawing.Point 480,110
$knopka5.Text = 'Панель управления'
$knopka5.add_click{
Start-Process control

}
$form1.Controls.Add($knopka5)
######################################
######################################
$knopka6 = New-Object System.Windows.Forms.Button
$knopka6.Size = New-Object System.Drawing.Point 100,50
$knopka6.Location = New-Object System.Drawing.Point 10,10
$knopka6.Text = 'Powershell'
$knopka6.add_click{
Start-Process powershell.exe

}
$form1.Controls.Add($knopka6)
######################################
######################################
$knopka7 = New-Object System.Windows.Forms.Button
$knopka7.Size = New-Object System.Drawing.Point 100,50
$knopka7.Location = New-Object System.Drawing.Point 10,60
$knopka7.Text = 'Cmd'
$knopka7.add_click{
Start-Process cmd.exe

}
$form1.Controls.Add($knopka7)
######################################
######################################
$knopka8 = New-Object System.Windows.Forms.Button
$knopka8.Size = New-Object System.Drawing.Point 100,50
$knopka8.Location = New-Object System.Drawing.Point 480,60
$knopka8.Text = 'Управление компьютером'
$knopka8.add_click{
Start-Process compmgmt.msc

}
$form1.Controls.Add($knopka8)
######################################
######################################
$knopka9 = New-Object System.Windows.Forms.Button
$knopka9.Size = New-Object System.Drawing.Point 100,50
$knopka9.Location = New-Object System.Drawing.Point 480,160
$knopka9.Text = 'Реестр'
$knopka9.add_click{
Start-Process regedit

}
$form1.Controls.Add($knopka9)
######################################
######################################
$knopka10 = New-Object System.Windows.Forms.Button
$knopka10.Size = New-Object System.Drawing.Point 100,50
$knopka10.Location = New-Object System.Drawing.Point 480,260
$knopka10.Text = 'Учетные записи пользователя'
$knopka10.add_click{
Start-Process netplwiz

}
$form1.Controls.Add($knopka10)
######################################
######################################
$knopka11 = New-Object System.Windows.Forms.Button
$knopka11.Size = New-Object System.Drawing.Point 100,50
$knopka11.Location = New-Object System.Drawing.Point 480,10
$knopka11.Text = 'Cвойства системы'
$knopka11.add_click{
Start-Process sysdm.cpl

}
$form1.Controls.Add($knopka11)
######################################
######################################
$knopka12 = New-Object System.Windows.Forms.Button
$knopka12.Size = New-Object System.Drawing.Point 100,50
$knopka12.Location = New-Object System.Drawing.Point 480,210
$knopka12.Text = 'Просмотр событий'
$knopka12.add_click{
Start-Process eventvwr.msc

}
$form1.Controls.Add($knopka12)
######################################
######################################
$knopka13 = New-Object System.Windows.Forms.Button
$knopka13.Size = New-Object System.Drawing.Point 100,50
$knopka13.Location = New-Object System.Drawing.Point 480,310
$knopka13.Text = 'Настройка сетевых подключений'
$knopka13.add_click{
Start-Process ncpa.cpl

}
$form1.Controls.Add($knopka13)
######################################
######################################



$form.ShowDialog()
######################################
#--------------------------------------------------- Конец -----------------------------------#
