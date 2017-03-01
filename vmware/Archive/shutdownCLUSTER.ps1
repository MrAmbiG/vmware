#REQUIRES -powercli 5.x

<#
.SYNOPSIS
    Shutdown cluster
	
.DESCRIPTION
  Just run this oneliner and replace the mycluster with the cluster of your choice. 
  more one liners at http://ambitech.blogspot.in/2015/05/create-multiple-dvswitches-and.html
    .
.NOTES
    File Name      : shutdownCLUSTER.PS1
    Author         : ambig1;twitter/MrAmbiG1
    Prerequisite   : powerclie
    Copyright      - None
.LINK
    Script posted over: github
    
.EXAMPLE
    get-cluster cluster11 | get-vmhost | stop-vmhost -confirm:$false
.EXAMPLE
    get-cluster cluster* | get-vmhost | stop-vmhost -confirm:$false
#>

#shutsdown all hosts of the clusters whose name begins with cluster
get-cluster cluster* | get-vmhost | stop-vmhost -confirm:$false
