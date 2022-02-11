import ssl
import getpass
from pyVmomi import vim
from pyVim.connect import SmartConnect, vim
import json

# The following function was taken from vThinkBeyondVM's website at:
# https://vthinkbeyondvm.com/pyvmomi-tutorial-how-to-get-all-the-core-vcenter-server-inventory-objects-and-play-around/
def get_all_objs(content, vimtype):
    obj = {}
    container = content.viewManager.CreateContainerView(content.rootFolder, vimtype, True)
    for managed_object_ref in container.view:
        obj.update({managed_object_ref:managed_object_ref.name})
    return obj

def get_host_info(vms, filter):
    host_info = []
    print("Filter is: " + filter)
    for vm in vms:
        vm_name = vm.name
        if filter in vm_name:
            summary = vars(vm.summary)
            vm_host = {}
            vm_host["vm_name"] = vm.name
            vm_host["ip_address"] = summary["guest"].ipAddress
            vm_host["power_state"] = summary["runtime"].powerState
            vm_host["memory"] = int(summary["config"].memorySizeMB / 1024)
            vm_host["cpu_count"] = summary["config"].numCpu
            host_info.append(vm_host)
    return host_info

def parse_info(vm_list):
    for vm in vm_list:
        if vm != None:
            print("----------")
            print("VM Name: " + vm["vm_name"])
            print("IP Address: " + str(vm["ip_address"]))
            print("Power State: " + vm["power_state"])
            print("RAM: " + str(vm["memory"]) + " GB")
            print("CPU Count: " + str(vm["cpu_count"]))

def main(content, vcenter_name):
    ans = 0
    while ans == 0:
        print("[1] Login Info")
        print("[2] List VMs by Name")
        print("[3] Print AboutInfo")
        print("[4] Quit the program")
        answer = input("Choose an option: ")
        if answer == "1":
            session_info = content.sessionManager.currentSession
            print("CURRENT SESSION INFORMATION")
            print("Username = " + session_info.userName)
            print("IPaddress = " + session_info.ipAddress)
            print("Vcenter Server = " + vcenter_name)
        elif answer == "2":
            filter = input("Enter a filter for your VM seach: ")
            vmsToScan = [vm for vm in get_all_objs(content, [vim.VirtualMachine])]
            vms = get_host_info(vmsToScan, filter)
            vms1 = parse_info(vms)
            print(vms1)
        elif answer == "3":
            print(content.about)
            print("Version number: " + content.about.version)
        elif answer == "4":
            break

def login():

    with open('/home/champuser/Tech-Journal/SYS350/automation/info.json', 'r')  as jsonfile:
        obj = json.load(jsonfile)

    passw = getpass.getpass()

    s=ssl.SSLContext(ssl.PROTOCOL_TLSv1_2)

    s.verify_mode=ssl.CERT_NONE

    si = SmartConnect(host=obj["vcenter_host"], user=obj["username"], pwd=passw, sslContext=s)

    content = si.content

    return content, obj["vcenter_host"]


if __name__ == '__main__':
    info = login()
    content = info[0]
    vcenter_name = info[1]
    main(content, vcenter_name)