# Policyfile.rb - Describe how you want Chef to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name "packer_gs"
default['packer_gs']['version']="0.1.0"
# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list "packer_gs::default"

# Specify a custom source for a single cookbook:
# cookbook "example_cookbook", path: "../cookbooks/example_cookbook"
#cookbook 'java', '1.47.0' , :supermarket
#cookbook 'activemq_gs', '1.0.1', path: "./cookbooks/activemq_gs"
cookbook 'packer_gs', path: "./cookbooks/packer_gs"
cookbook 'java', 
