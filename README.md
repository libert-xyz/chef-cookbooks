Verify your connection to the Chef server
------------------------------------------

First, validate that your ~/learn-chef/.chef contains your knife.rb file and your private key file.


	ls ~/learn-chef/.chef
	knife.rb  your_name.pem

knife ssl check

Create a cookbook
-----------------
First, from your ~/chef-repo directory, create a cookbooks directory and cd there.

mkdir cookbooks
cd cookbooks
chef generate cookbook learn_chef_httpd

Create a template
------------------
chef generate template learn_chef_httpd index.html



Bootstrap using key-based authentication
-----------------------------------------

Replace ADDRESS with your remote node's external address, USER with your username, and IDENTITY_FILE with your SSH identify file, for example ~/.ssh/my.pem.

knife bootstrap ADDRESS --ssh-user USER --sudo --identity-file IDENTITY_FILE --node-name node1 --run-list 'recipe[learn_chef_httpd]'



knife bootstrap ADDRESS -x root -P sesamo321 -N module3 -r 'recipe[learn_chef_httpd]'



Check Result
------------

knife node list

Upload your cookbook to the Chef server
---------------------------------------
Run knife to upload the updated cookbook to the Chef server.
-------------------------------------------------------------

knife cookbook upload learn_chef_httpd


To run chef-client on your node remotely from your workstation, you'll run the knife ssh command.
knife ssh takes the command to run on the node as an argument.



Update your node using key-based authentication
-----------------------------------------------


knife ssh ADDRESS 'sudo chef-client' --manual-list --ssh-user USER --identity-file IDENTITY_FILE


RUNLIST
---------

knife node run_list add node-name "recipe[name]"


Role Upload
-----------

knife role from file webserver.json

Remove run-list from Node
------------------------

knife node run list remove module3 'recipe[learn_chef_httpd']

Add ROle to Node
----------------

knife node run list add module3 'role[webserver]'


Upload a role to the server
----------------------------

knife role from file roles/webserver.json

List Nodes
----------

knife client list


How to clean up your environment
--------------------------------

knife node delete node1 --yes
knife client delete node1 --yes



SHOW
----------

knife node show nodeNAME
knife node show nodeNAME -a hostname


#############################################################################################################################
#############################################################################################################################
#######################################CONCEPTS##############################################################################
#############################################################################################################################
#############################################################################################################################

Resouces
----------
Piace of the system at desire state:
a package that should be install, a service that should be running,a cron job, etc.

Recipes
-------

Describe Resources and their desire state.
Can install and configure software components, deploy apps , etc.

Node
------

physical , virtual or cloud machines

The 'node object' is the representation of that physical node within Chef(e.g. in JSON)


'ohai' node attributes -> JSON

ROLES
-------

encapsulate the run-list and attributes for a server.
easy to configure many nodes 'Identically'

Data Bags
----------
Stores information about the infrastructure , are JSON Data

knife upload data_bags/vhosts/


Environments
--------------

Each enviroments may include attributes necesary for configuring the insfrastructure
in that environment.
	-Production needs certain Yum repos
	- QA needs differents YUM repos
	 - The version of chef cookboos to be used

knife environment show envName

knife environment list

knife environment from file dev.rb


knife bootstrap rodrigo-zalles2.mylabserver.com --ssh-user root  -P sesamo321 --node-name module3 -r 'role[webserver]' -E production


Test Kitchen
------------
- enables you to run your cookbooks in a temporary environment that resembles production.

kitchen list

kitchen create


- Apply the cookbook to your Test Kitchen instance

kitchen converge

- Verify that your Test Kitchen instance contains the updated MOTD

kitchen login


knife cookbook site show selinux  | grep latest_version


Berkshelf
----------
instead of running the "knife cookbook upload" command to manually upload each dependency.
Berkshelf uploads your cookbooks to the Chef server and retrieves the cookbooks that your cookbook depends on.

berks install
berks update

Berkshelf installs dependent cookbooks to the ~/.berkshelf/cookbooks directory so that they can be shared among all of your cookbooks.
