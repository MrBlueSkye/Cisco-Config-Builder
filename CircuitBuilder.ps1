[void][System.Reflection.Assembly]::LoadWithPartialName( “System.Windows.Forms”)
[void][System.Reflection.Assembly]::LoadWithPartialName( “Microsoft.VisualBasic”)


##########################
#### Define Functions ####
##########################

function OneworldCircuit {


##########################
#### Define Variables ####
##########################
$title = “Oneworld Circuit Configuration Wizard”
$title2 = "Circuit Configuration Script"
$VRF = “Enter Customer VRF”
$AS = “Enter VRF Autonomous System”
$REF = “Enter Circuit Reference”
$IP = "Enter IP Address"
$VLAN = "Enter VLAN ID"
$SPEED = "Enter Speed (Mb/s)"
$INT = "Enter Interface (e.g. GiX/X)"
$ROUTETARGET = "Enter Route-Target (8681:X)"
$RD = "Enter Route Distinguisher (8681:X)"
#############
#### GUI ####
#############
$form = New-Object “System.Windows.Forms.Form”;
$form.Width = 500;
$form.Height = 490;
$form.Text = $title;
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen;
$form.Opacity = 0.9
$form.KeyPreview = $True

$form2 = New-Object “System.Windows.Forms.Form”;
$form2.Width = 500;
$form2.Height = 670;
$form2.Text = $title2;
$form2.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen;

$textLabel1 = New-Object “System.Windows.Forms.Label”;
$textLabel1.Left = 10;
$textLabel1.Top = 10;
$textLabel1.width = 120;
$textLabel1.Text = $VRF;

$textLabel2 = New-Object “System.Windows.Forms.Label”;
$textLabel2.Left = 10;
$textLabel2.Top = 50;
$textLabel2.width = 180;
$textLabel2.Text = $AS;

$textLabel3 = New-Object “System.Windows.Forms.Label”;
$textLabel3.Left = 10;
$textLabel3.Top = 90;
$textLabel3.width = 130;
$textLabel3.Text = $REF;

$textLabel4 = New-Object “System.Windows.Forms.Label”;
$textLabel4.Left = 10;
$textLabel4.Top = 130;
$textLabel4.width = 100;
$textLabel4.Text = $IP;

$textLabel5 = New-Object “System.Windows.Forms.Label”;
$textLabel5.Left = 10;
$textLabel5.Top = 170;
$textLabel5.width = 100;
$textLabel5.Text = $VLAN;

$textLabel6 = New-Object “System.Windows.Forms.Label”;
$textLabel6.Left = 10;
$textLabel6.Top = 210;
$textLabel6.width = 120;
$textLabel6.Text = $SPEED;

$textLabel7 = New-Object “System.Windows.Forms.Label”;
$textLabel7.Left = 10;
$textLabel7.Top = 250;
$textLabel7.width = 150;
$textLabel7.Text = $INT;

$textLabel8 = New-Object “System.Windows.Forms.Label”;
$textLabel8.Left = 10;
$textLabel8.Top = 290;
$textLabel8.width = 150;
$textLabel8.Text = $ROUTETARGET;

$textLabel9 = New-Object “System.Windows.Forms.Label”;
$textLabel9.Left = 10;
$textLabel9.Top = 330;
$textLabel9.width = 190;
$textLabel9.Text = $RD;

$textBox1 = New-Object “System.Windows.Forms.TextBox”;
$textBox1.Left = 230;
$textBox1.Top = 10;
$textBox1.width = 220;

$textBox2 = New-Object “System.Windows.Forms.TextBox”;
$textBox2.Left = 230;
$textBox2.Top = 50;
$textBox2.width = 220;

$textBox3 = New-Object “System.Windows.Forms.TextBox”;
$textBox3.Left = 230;
$textBox3.Top = 90;
$textBox3.width = 220;

$textBox4 = New-Object “System.Windows.Forms.TextBox”;
$textBox4.Left = 230;
$textBox4.Top = 130;
$textBox4.width = 220;

$textBox5 = New-Object “System.Windows.Forms.TextBox”;
$textBox5.Left = 230;
$textBox5.Top = 170;
$textBox5.width = 220;

$textBox6 = New-Object “System.Windows.Forms.TextBox”;
$textBox6.Left = 230;
$textBox6.Top = 210;
$textBox6.width = 220;

$textBox7 = New-Object “System.Windows.Forms.TextBox”;
$textBox7.Left = 230;
$textBox7.Top = 250;
$textBox7.width = 220;

$textBox8 = New-Object “System.Windows.Forms.TextBox”;
$textBox8.Left = 230;
$textBox8.Top = 290;
$textBox8.width = 220;

$textBox9 = New-Object “System.Windows.Forms.TextBox”;
$textBox9.Left = 230;
$textBox9.Top = 330;
$textBox9.width = 220;

$defaultValue = “”
$textBox1.Text = $defaultValue;
$textBox2.Text = $defaultValue;
$textBox3.Text = $defaultValue;
$textBox4.Text = $defaultValue;
$textBox5.Text = $defaultValue;
$textBox6.Text = $defaultValue;
$textBox7.Text = $defaultValue;
$textBox8.Text = $defaultValue;
$textBox9.Text = $defaultValue;

$checkBox1 = New-Object System.Windows.Forms.CheckBox

$checkBox1.Left = 40;
$checkBox1.Top = 360;
$checkBox1.width = 380;
$checkBox1.Text = "Tick this checkbox if the circuit requires a bearer"
$checkBox1.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Bold)



#########################
#### Define Function ####
#########################


# Fucntion which is called when the 'Generate Configuration button is clicked          
# It sets the input variables to the text entered by the user in each of the text entry boxes 
# If the checkbox is ticked, it will set the output of @script differently                    
# It then opens form2, which displays the @script text                                        

#nested function to generate output config
function generate() {

$Input1=$textBox1.Text;
$Input2=$textBox2.Text;
$Input3=$textBox3.Text;
$Input4=$textBox4.Text;
$Input5=$textBox5.Text;
$Input6=$textBox6.Text;
$Input7=$textBox7.Text;
$Input8=$textBox8.Text;
$Input9=$textBox9.Text;
$form.Close();


    If ($checkBox1.Checked)     {  $Script = @"
configure terminal
ip vrf $Input1
rd 8681:$Input9
route-target export 8681:$Input8
route-target import 8681:$Input8
exit

router bgp 8681
address-family ipv4 vrf $Input1
no synchronization
redistribute static
redistribute connected
neighbor xxx.xxx.xxx.xxx remote-as $Input2
neighbor xxx.xxx.xxx.xxx activate
neighbor xxx.xxx.xxx.xxx next-hop-self)
neighbor xxx.xxx.xxx.xxx as-override
exit

interface $Input7
description $Input3
speed $Input6
duplex full
no shutdown
exit

interface $Input7.$Input5
description $Input3
encapsulation dot1q $Input5
ip vrf forwarding $Input1
ip address $Input4 255.255.255.252
no shutdown
exit"
"@   }


    Else { $Script = @"
configure terminal
ip vrf $Input1
rd 8681:$Input9
route-target export 8681:$Input8
route-target import 8681:$Input8
exit

router bgp 8681
address-family ipv4 vrf $Input1
no synchronization
redistribute static
redistribute connected
neighbor xxx.xxx.xxx.xxx remote-as $Input2
neighbor xxx.xxx.xxx.xxx activate
neighbor xxx.xxx.xxx.xxx next-hop-self)
neighbor xxx.xxx.xxx.xxx as-override
exit

interface $Input7.$Input5
description $Input3
encapsulation dot1q $Input5
ip vrf forwarding $Input1
ip address $Input4 255.255.255.252
no shutdown
exit"
"@ }

$textBoxform2 = New-Object “System.Windows.Forms.TextBox”;
$textBoxform2.Size = New-Object System.Drawing.Size(260,90) 
$textBoxform2.Location = New-Object System.Drawing.Size(10,41) 
$textBoxform2.Size = New-Object System.Drawing.Size(460,550)
$textBoxform2.AcceptsReturn = $true
$textBoxform2.AcceptsTab = $false
$textBoxform2.Multiline = $true
$textBoxform2.Text = $Script

$textBoxform2.Text = $Script;
$form2.Controls.Add($textBoxform2);
$ret = $form2.ShowDialog();


} 






#####################
#### MAIN SCRIPT ####
#####################


# Call form with specified buttons, labels, text boxes and checkbox

$button = New-Object “System.Windows.Forms.Button”;
$button.Left = 140;
$button.Top = 400;
$button.Width = 220;
$button.Text = “Generate Configuration Script”;
$button.Add_Click({

generate






})

$form.Controls.Add($button);
$form.Controls.Add($textLabel1);
$form.Controls.Add($textLabel2);
$form.Controls.Add($textLabel3);
$form.Controls.Add($textLabel4);
$form.Controls.Add($textLabel5);
$form.Controls.Add($textLabel6);
$form.Controls.Add($textLabel7);
$form.Controls.Add($textLabel8);
$form.Controls.Add($textLabel9);
$form.Controls.Add($textBox1);
$form.Controls.Add($textBox2);
$form.Controls.Add($textBox3);
$form.Controls.Add($textBox4);
$form.Controls.Add($textBox5);
$form.Controls.Add($textBox6);
$form.Controls.Add($textBox7);
$form.Controls.Add($textBox8);
$form.Controls.Add($textBox9);
$form.Controls.Add($checkBox1);
$ret = $form.ShowDialog();






# When the Generate Configuration button is clicked, 
# it calls the 'generate' function                   




}



function ReservePort {
##########################
#### Define Variables ####
##########################
$reservetitle = “Interface Reservation Configuration Wizard”
$reservedescription = "Enter circuit reference:"
$reservetitle2 = "Interface Reservation Script"
$reserveinterface = "Enter interface number ( Gi X/X ):"

#############
#### GUI ####
#############
$reserveform = New-Object “System.Windows.Forms.Form”;
$reserveform.Width = 480;
$reserveform.Height = 190;
$reserveform.Text = $reservetitle;
$reserveform.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen;
$reserveform.Opacity = 0.9
$reserveform.KeyPreview = $True

$reserveform2 = New-Object “System.Windows.Forms.Form”;
$reserveform2.Width = 300;
$reserveform2.Height = 370;
$reserveform2.Text = $reservetitle2;
$reserveform2.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen;

$textLabel1 = New-Object “System.Windows.Forms.Label”;
$textLabel1.Left = 10;
$textLabel1.Top = 10;
$textLabel1.width = 180;
$textLabel1.Text = $reserveinterface;

$textLabel2 = New-Object “System.Windows.Forms.Label”;
$textLabel2.Left = 10;
$textLabel2.Top = 50;
$textLabel2.width = 180;
$textLabel2.Text = $reservedescription;

$textBox1 = New-Object “System.Windows.Forms.TextBox”;
$textBox1.Left = 230;
$textBox1.Top = 10;
$textBox1.width = 220;

$textBox2 = New-Object “System.Windows.Forms.TextBox”;
$textBox2.Left = 230;
$textBox2.Top = 50;
$textBox2.width = 220;

$defaultValue = “”
$textBox1.Text = $defaultValue;


####################################

function reservegenerate() {

$Input1=$textBox1.Text;
$Input2=$textBox2.Text;
$reserveform.Close();


$reserveScript = @"
configure terminal
interface $Input1
description RESERVED - $Input2
exit
"@


$reservetextBoxform2 = New-Object “System.Windows.Forms.TextBox”;
$reservetextBoxform2.Size = New-Object System.Drawing.Size(260,90) 
$reservetextBoxform2.Location = New-Object System.Drawing.Size(12,21) 
$reservetextBoxform2.Size = New-Object System.Drawing.Size(260,290)
$reservetextBoxform2.AcceptsReturn = $true
$reservetextBoxform2.AcceptsTab = $false
$reservetextBoxform2.Multiline = $true
$reservetextBoxform2.Text = $reserveScript

$reservetextBoxform2.Text = $reserveScript;
$reserveform2.Controls.Add($reservetextBoxform2);
$ret = $reserveform2.ShowDialog();


} 






#####################
#### MAIN SCRIPT ####
#####################


# Call form with specified buttons, labels, text boxes and checkbox

$reservebutton = New-Object “System.Windows.Forms.Button”;
$reservebutton.Left = 140;
$reservebutton.Top = 100;
$reservebutton.Width = 220;
$reservebutton.Text = “Generate Configuration Script”;
$reservebutton.Add_Click({

reservegenerate






})

$reserveform.Controls.Add($reservebutton);
$reserveform.Controls.Add($textLabel1);
$reserveform.Controls.Add($textLabel2);
$reserveform.Controls.Add($textBox1);
$reserveform.Controls.Add($textBox2);
$ret = $reserveform.ShowDialog();






# When the Generate Configuration button is clicked, 
# it calls the 'generate' function                   




}


function BGPPeering {
##########################
#### Define Variables ####
##########################
$peeringtitle = “BGP Peering Configuration Wizard”
$peeringdescription = "Enter Customer Name:"
$peeringtitle2 = "BGP Peering Configuration Script"
$peeringAS = "Enter Customer AS Number:"
$peeringaddress = "Enter Neighbor Address:"
$peeringcontact = "Enter Contact Details"

#############
#### GUI ####
#############
$peeringform = New-Object “System.Windows.Forms.Form”;
$peeringform.Width = 480;
$peeringform.Height = 320;
$peeringform.Text = $peeringtitle;
$peeringform.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen;
$peeringform.Opacity = 0.9
$peeringform.KeyPreview = $True

$peeringform2 = New-Object “System.Windows.Forms.Form”;
$peeringform2.Width = 400;
$peeringform2.Height = 220;
$peeringform2.Text = $peeringtitle2;
$peeringform2.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen;

$peeringtextLabel1 = New-Object “System.Windows.Forms.Label”;
$peeringtextLabel1.Left = 10;
$peeringtextLabel1.Top = 10;
$peeringtextLabel1.width = 180;
$peeringtextLabel1.Text = $peeringAS;

$peeringtextLabel2 = New-Object “System.Windows.Forms.Label”;
$peeringtextLabel2.Left = 10;
$peeringtextLabel2.Top = 50;
$peeringtextLabel2.width = 180;
$peeringtextLabel2.Text = $peeringdescription;

$peeringtextLabel3 = New-Object “System.Windows.Forms.Label”;
$peeringtextLabel3.Left = 10;
$peeringtextLabel3.Top = 90;
$peeringtextLabel3.width = 180;
$peeringtextLabel3.Text = $peeringaddress;

$peeringtextLabel4 = New-Object “System.Windows.Forms.Label”;
$peeringtextLabel4.Left = 10;
$peeringtextLabel4.Top = 130;
$peeringtextLabel4.width = 180;
$peeringtextLabel4.Text = $peeringcontact;

$peeringtextBox1 = New-Object “System.Windows.Forms.TextBox”;
$peeringtextBox1.Left = 230;
$peeringtextBox1.Top = 10;
$peeringtextBox1.width = 220;

$peeringtextBox2 = New-Object “System.Windows.Forms.TextBox”;
$peeringtextBox2.Left = 230;
$peeringtextBox2.Top = 50;
$peeringtextBox2.width = 220;

$peeringtextBox3 = New-Object “System.Windows.Forms.TextBox”;
$peeringtextBox3.Left = 230;
$peeringtextBox3.Top = 90;
$peeringtextBox3.width = 220;

$peeringtextBox4 = New-Object “System.Windows.Forms.TextBox”;
$peeringtextBox4.Left = 230;
$peeringtextBox4.Top = 130;
$peeringtextBox4.width = 220;

$peeringgroupBox = New-Object System.Windows.Forms.GroupBox #create the group box
$peeringgroupBox.Location = New-Object System.Drawing.Size(120,165) #location of the group box (px) in relation to the primary window's edges (length, height)
$peeringgroupBox.size = New-Object System.Drawing.Size(100,100) #the size in px of the group box (length, height)
$peeringgroupBox.text = "Address-family:" #labeling the box

$peeringRadioButton1 = New-Object System.Windows.Forms.RadioButton #create the radio button
$peeringRadioButton1.Location = new-object System.Drawing.Point(15,15) #location of the radio button(px) in relation to the group box's edges (length, height)
$peeringRadioButton1.size = New-Object System.Drawing.Size(80,20) #the size in px of the radio button (length, height)
$peeringRadioButton1.Checked = $true #is checked by default
$peeringRadioButton1.Text = "IPv4" #labeling the radio button
$peeringgroupBox.Controls.Add($peeringRadioButton1) #activate the inside the group box

$peeringRadioButton2 = New-Object System.Windows.Forms.RadioButton #create the radio button
$peeringRadioButton2.Location = new-object System.Drawing.Point(15,15) #location of the radio button(px) in relation to the group box's edges (length, height)
$peeringRadioButton2.size = New-Object System.Drawing.Size(80,60) #the size in px of the radio button (length, height)
$peeringRadioButton2.Checked = $false #is not checked by default
$peeringRadioButton2.Text = "IPv6" #labeling the radio button
$peeringgroupBox.Controls.Add($peeringRadioButton2) #activate the inside the group box


$defaultValue = “”
$peeringtextBox1.Text = $defaultValue;
$peeringtextBox2.Text = $defaultValue;
$peeringtextBox3.Text = $defaultValue;
$peeringtextBox4.Text = $defaultValue;




####################################

function peeringgenerate() {

$Input1=$peeringtextBox1.Text;
$Input2=$peeringtextBox2.Text;
$Input3=$peeringtextBox3.Text;
$Input4=$peeringtextBox4.Text;
$peeringform.Close();



if ($peeringRadioButton1.Checked -eq $true) {$peeringScript = @"
configure terminal
router bgp 8681
neighbor $Input3
  remote-as $Input1
  use neighbor-group IX-LINX-PEERS
  description Peer: AS$Input1 $Input2 (LINX) $Input4
  address-family ipv4 unicast
   maximum-prefix 500 90
   exit
"@
} 


if ($peeringRadioButton2.Checked -eq $true) {$peeringScript = @"
configure terminal
router bgp 8681
neighbor $Input3
  remote-as $Input1
  use neighbor-group IX-LINX-PEERS-V6
  description Peer: AS$Input1 $Input2 (LINX) $Input4
  address-family ipv6 unicast
   maximum-prefix 500 90
   exit
"@}




$peeringBoxform2 = New-Object “System.Windows.Forms.TextBox”;
$peeringBoxform2.Size = New-Object System.Drawing.Size(560,590) 
$peeringBoxform2.Location = New-Object System.Drawing.Size(12,21) 
$peeringBoxform2.Size = New-Object System.Drawing.Size(360,150)
$peeringBoxform2.AcceptsReturn = $true
$peeringBoxform2.AcceptsTab = $false
$peeringBoxform2.Multiline = $true
$peeringBoxform2.Text = $peeringScript

$peeringBoxform2.Text = $peeringScript;
$peeringform2.Controls.Add($peeringBoxform2);
$ret = $peeringform2.ShowDialog();


} 






#####################
#### MAIN SCRIPT ####
#####################


# Call form with specified buttons, labels, text boxes and checkbox

$peeringbutton = New-Object “System.Windows.Forms.Button”;
$peeringbutton.Left = 140;
$peeringbutton.Top = 240;
$peeringbutton.Width = 230;
$peeringbutton.Text = “Generate Configuration Script”;
$peeringbutton.Add_Click({

peeringgenerate




})

$peeringform.Controls.Add($peeringbutton);
$peeringform.Controls.Add($peeringtextLabel1);
$peeringform.Controls.Add($peeringtextLabel2);
$peeringform.Controls.Add($peeringtextLabel3);
$peeringform.Controls.Add($peeringtextLabel4);
$peeringform.Controls.Add($peeringtextBox1);
$peeringform.Controls.Add($peeringtextBox2);
$peeringform.Controls.Add($peeringtextBox3);
$peeringform.Controls.Add($peeringtextBox4);
$peeringform.Controls.Add($peeringgroupBox) #activate the group box

$ret = $peeringform.ShowDialog();






# When the Generate Configuration button is clicked, 
# it calls the 'generate' function                   




}





function Main_Menu () {
##########################
#### Define Variables ####
##########################
$maintitle = “Circuit Builder”
$welcomemessage = "Welcome to the Circuit Builder. Please select a function below..."

#############
#### GUI ####
#############
$mainform = New-Object “System.Windows.Forms.Form”;
$mainform.Width = 300;
$mainform.Height = 290;
$mainform.Text = $maintitle;
$mainform.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen;
$mainform.Opacity = 0.9
$mainform.KeyPreview = $True

$maintextLabel1 = New-Object “System.Windows.Forms.Label”;
$maintextLabel1.Left = 10;
$maintextLabel1.Top = 10;
$maintextLabel1.width = 280;
$maintextLabel1.Height = 90;
$maintextLabel1.Text = $welcomemessage;
$maintextLabel1.Font = New-Object System.Drawing.Font("Calibri",12)

#OneWorld Circuit button
$oneworldbutton = New-Object “System.Windows.Forms.Button”;
$oneworldbutton.Left = 40;
$oneworldbutton.Top = 100;
$oneworldbutton.Width = 220;
$oneworldbutton.Text = “Oneworld Circuit”;
$oneworldbutton.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Bold)
$oneworldbutton.Add_Click({
OneworldCircuit
})

#Reserve port button
$reservebutton = New-Object “System.Windows.Forms.Button”;
$reservebutton.Left = 40;
$reservebutton.Top = 150;
$reservebutton.Width = 220;
$reservebutton.Text = “Reserve Port”;
$reservebutton.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Bold)
$reservebutton.Add_Click({
ReservePort
})

#BGP peering button
$peeringbutton = New-Object “System.Windows.Forms.Button”;
$peeringbutton.Left = 40;
$peeringbutton.Top = 200;
$peeringbutton.Width = 220;
$peeringbutton.Text = “New BGP Peer”;
$peeringbutton.Font = New-Object System.Drawing.Font("Calibri",12,[System.Drawing.FontStyle]::Bold)
$peeringbutton.Add_Click({
BGPPeering
})

$mainform.Controls.Add($maintextLabel1);
$mainform.Controls.Add($oneworldbutton);
$mainform.Controls.Add($reservebutton);
$mainform.Controls.Add($peeringbutton);
#add buttons here
$ret = $mainform.ShowDialog();

}

########################
#### Execute Script ####
########################

Main_Menu

