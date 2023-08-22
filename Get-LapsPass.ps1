function Get-LapsPass {
    param (
        [Parameter (Mandatory=$true, ValueFromPipeLine=$true)]
        [string]
        $ComputerName,
        [Parameter (ValueFromPipeLine=$false)]
        [object]
        $Credential,
        [Parameter (Mandatory=$false, ValueFromPipeLine=$false)]
        [string]
        $UserName = "Administrator"
    )
    foreach ($computer in $ComputerName){
        if ($Credentials){
            $comObj = Get-ADComputer $computer -Properties ms-Mcs-AdmPwd -Credential $Credential -ErrorAction Stop
        }else{
            $comObj = Get-ADComputer $computer -Properties ms-Mcs-AdmPwd -ErrorAction Stop
        }
        $lapsPass   = ConvertTo-SecureString $comObj.'ms-Mcs-AdmPwd' -AsPlainText -Force -ErrorAction Stop
        $serverCred = New-Object PSCredential ($UserName, $lapsPass) -ErrorAction Stop
    }
    return $serverCred
}
