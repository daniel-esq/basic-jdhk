This project contains the kubernetes descriptors 
that will allow you to manage your components' installations with simple helm commands.

Project structure:
  * **basic-java** // The chart of the application meant to be installed in minikube
  * **basic-common** // A common helm chart from which other charts inherit descriptors to avoid excessive 
  and redundant boilerplate configs
  * **basic-umbrella-chart** // The parent and wrapper of all charts
  
**Note:** _basic-umbrella-chart will also host all the <namespace>-values.yaml files (Example: local-minikube-values.yaml)



### Requirements
1. **Helm** Installation instructions can be found [here](https://helm.sh/docs/intro/install/)
    


### Installation
A custom bash script has been created to help with the installation and upgrade of the charts.
The script name is **helm-actions.sh** which can be executed with the following arguments:
 * _Template the charts_
     ~~~
     ./helm-actions.sh -t
     ~~~
     Will print in the console a yaml file with all the interpolated values 
     
 * _Install the charts_
     ~~~
     ./helm-actions.sh -i
     ~~~
     Will install the charts in minikube  
        
 * _Upgrade the charts_
     ~~~
     ./helm-actions.sh -u
     ~~~
     Update the installation with the latest changes  
        
 * _Delete the charts_
     ~~~
     ./helm-actions.sh -d
     ~~~
     Delete the installation
     
   
#### Other useful helm commands

Find installed helm charts:
~~~
helm ls
~~~ 

_Expected output example:_
~~~
NAME 	NAMESPACE	REVISION	UPDATED                             	STATUS  	CHART                     	APP VERSION  
basic	default  	1       	2020-05-16 19:30:25.407527 +0100 BST	deployed	basic-umbrella-chart-0.1.0	0.1.0 
~~~ 

Inspect installation history for a specific chart:
~~~
helm history basic
~~~

_Expected output example (after an upgrade):_
~~~
REVISION	UPDATED                 	STATUS    	CHART                     	APP VERSION	DESCRIPTION     
1       	Sat May 16 19:30:25 2020	superseded	basic-umbrella-chart-0.1.0	0.1.0      	Install complete
2       	Sun May 17 13:19:11 2020	deployed  	basic-umbrella-chart-0.1.0	0.1.0      	Upgrade complete
~~~
Returns the installation history and the status of each revision.

Rollback to a previous revision:
~~~
helm rollback basic 1
~~~
_Expected output example:_
~~~
Rollback was a success! Happy Helming!
~~~
_Expected output example from the history command:_
~~~
helm history basic

REVISION	UPDATED                 	STATUS    	CHART                     	APP VERSION	DESCRIPTION     
1       	Sat May 16 19:30:25 2020	superseded	basic-umbrella-chart-0.1.0	0.1.0      	Install complete
2       	Sun May 17 13:19:11 2020	superseded	basic-umbrella-chart-0.1.0	0.1.0      	Upgrade complete
3       	Sun May 17 13:26:10 2020	deployed  	basic-umbrella-chart-0.1.0	0.1.0      	Rollback to 1
~~~
Notice the revision description: _Rollback to 1_
