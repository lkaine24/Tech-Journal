function getinfo {

    $vms = Get-VM

    Write-Host "--------------------"

    foreach ($vm in $vms) {

    $vm_name = $vm.Name.ToString()
    $vm_net = $vm.NetworkAdapters.IPAddresses
    $vm_state = $vm.State

    Write-Host "Name: $vm_name"
    Write-Host "NetInfo: $vm_net"
    Write-Host "PowerState: $vm_state"
    Write-Host "--------------------"

}
}

function extrainfo {

    $vms = Get-VM | Select-Object *

    Write-Host "--------------------"

    foreach ($vm in $vms) {

    # Grab info
    $vm_name = $vm.Name.ToString()
    $vm_id = $vm.VMId
    $vm_status = $vm.Status
    $vm_generation = $vm.Generation
    $vm_uptime = $vm.Uptime
    $vm_config = $vm.ConfigurationLocation

    # Write info to terminal
    Write-Host "Name: $vm_name"
    Write-Host "Id: $vm_id"
    Write-Host "Status: $vm_status"
    Write-Host "Generation: $vm_generation"
    Write-Host "Uptime: $vm_uptime"
    Write-Host "Config Location: $vm_config"
    Write-Host "--------------------"

}
}

function poweron($filter) {

    Start-VM $filter

    Write-Host "$vm_name started!"

}

function poweroff($filter) {

    Stop-VM $filter

    Write-Host "$vm_name stopped!"

}

function snapshot($filter) {

    $snap_name = Read-Host "What would you like to name this snapshot"

    Checkpoint-VM -Name $filter -SnapshotName $snap_name

}

function restore($filter) {

    Write-Host "Current Snapshots:"

    $snaps = Get-VMSnapshot -VMName $filter | Select-Object VMName, Name

    Write-Host $snaps.Name

    $snap_name = Read-Host "Which snapshot would you like to restore to?"

    Restore-VMSnapshot -Name $snap_name -VMName $filter

}

function changecpu($filter) {

    $currentcpucount = Get-VMProcessor $filter | Select-Object -Expand Count

    Write-Host "The current CPU count for $filter is $currentcpucount."

    $cpucount = Read-Host "How many processors would you like to allocate to this machine?"

    Stop-VM $filter

    Set-VMProcessor $filter -Count $cpucount

    Start-VM $filter

    $newcpucount = Get-VMProcessor $filter | Select-Object -Expand Count

    Write-Host "The new CPU count for $filter is $newcpucount"

}

function switchadapters($filter) {

    $currentadapter = Get-VMNetworkAdapter $filter | Select-Object -Expand SwitchName

    $available = Get-VMSwitch | Select-Object -Expand Name

    Write-Host "Current VM Adapter:"
    Write-Host $currentadapter

    Write-Host "Available Adapters:"
    Write-Host $available

    $newadapter = Read-Host "Which Adapter would you like to switch to?"

    Write-Host "Switching Network Adapters..."

    Get-VM $filter | Get-VMNetworkadapter | Connect-VMNetworkadapter -SwitchName $newadapter

}


function menu() {

    Write-Host "Basic Info [1]"
    Write-Host "Extra Info [2]"
    Write-Host "Power On [3]"
    Write-Host "Power Off [4]"
    Write-Host "Snapshot [5]"
    Write-Host "Restore a Snapshot [6]"
    Write-Host "Change VM's CPU Count [7]"
    Write-Host "Execute Remote Command [8]"
    Write-Host ""

    $operation = Read-Host "Choose an option"

    if ( $operation -ne 1 -and $operation -ne 2) {$filter = Read-Host "Which VM would you like to operate on?"}

    if ( 1 -eq $operation) {getinfo}
    ElseIf ( 2 -eq $operation) {extrainfo}
    ElseIf ( 3 -eq $operation) {poweron $filter}
    ElseIf ( 4 -eq $operation) {poweroff $filter}
    ElseIf ( 5 -eq $operation) {snapshot $filter}
    ElseIf ( 6 -eq $operation) {restore $filter}
    ElseIf ( 7 -eq $operation) {changecpu $filter}
    ElseIf ( 8 -eq $operation) {switchadapters $filter}


menu

}

menu
