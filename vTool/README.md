vTool
=====
vTool is a handy multi automation tool for VMware administrators and those who do implementation onsite or offsite. Below are just few highlights

  - Never Ending menu
  - Each menu allows you to jump back or forward to other menu
  - Create vmkernel or VM standard or distribued portgroups
  - Run ssh/cli commands on all esxi hosts (just like ansible)
  - Run any advanced settings against any number of esxi
  - Add datastores
  - Highly scalable. you can add your own functions and menu entry for that

>**How to update?**

- Click the filename
- click raw
- copy paste the entire content of webpage to a .ps1 file
- [optional] Try to keep the name of your vtool with the one which is online

> **vCenter Automation:**

    -create cluster
    -Add Hosts to cluster
    -Configure HA
    -Configure DRS
    -DRS rules (beta)
    -Create vApp
    -Add Datastores to cluster
    -SNMP
    -Syslog settings
    -DNS settings
    -NTP settings
    -Any Advanced setting
    -Firewall Settings
    -Scratch partition
    -Performance settings
    -Core dump settings
    -Power Management (shutdown, reboot, maintenance)
    -Enable/Disable services. You will get 3 options again for each of the following
         A. DCUI           [Direct Console UI]
         B. TSM            [ESXi Shell]
         C. TSM-SSH        [SSH]
         D. lbtd           [Load-Based Teaming Daemon]
         E. lwsmd          [Active Directory Service]
         F. ntpd           [NTP Daemon]
         G. pcscd          [PC/SC Smart Card Daemon]
         H. sfcbd-watchdog [CIM Server]
         I. snmpd          [SNMP Server]
         J. vmsyslogd      [Syslog Server]
         K. vprobed        [VProbe Daemon]
         L. vpxa           [VMware vCenter Agent]
         M. xorg           [X.Org Server]
    -IpV6
    -VMKernel Services
         A. Enable VMotion
         B. Enable VsanTraffic
         C. Enable FaultTolerance
         D. Enable ManagementTraffic
         E. Disable VMotion
         F. Disable VsanTraffic
         G. Disable FaultTolerance
         H. Disable ManagementTraffic
    -WinSSH (Run SSH commands on esxi directly from windows, needs plink.exe in c:/.) Imagine ansible.
    -mtu of vmkernel
    -Qdepth for fnic
    -Create vSwitch
    -Update Number of Ports
    -make nic active/passive/unused on vSwitch or portgroup
    -Update MTU
    -Enable AllowPromiscuous
    -Enable ForgedTransmits
    -Enable MacChanges
    -Disable AllowPromiscuous
    -Disable ForgedTransmits
    -Disable MacChanges
    -Remove vSwitch
    -Create VM Portgroup
    -Create VMkernel Portgroup
    -Rename Portgroup
    -Update Portgroup's Vlan
    -Delete VM Portgroup
    -Delete VMkernel Portgroup  
    -Sync portgroup with vSwitch(inherit all properties of vswitch to portgroup)
    -Add TCP/IP stack (vmotion, provisioning etc.)
    -LoadBalanceIP
    -LoadBalanceSrcMac
    -LoadBalanceSrcId
    -ExplicitFailover
    -L3 vmotion portgroup
    -Create VDS
    -Create dvPortgroup
    -Add hosts to VDS
    -Load balancing policies for vds
    -(L3)TCP/IP stack
    -migrate vmkernel portgroup to vds

> **Standalone Host[beta]:**

    -Connect to standalone hosts
    -Create virtual Standard Switch
    -Create virtual Machine Portgroup
    -Create VMkernel Portgroup
    -Rename Portgroups
    -Add Nics to vSwitch
    -Remove VM portgroup
    -Remove VMkernel portgroup
    -Change Ip address and gateway of a vmkernel
