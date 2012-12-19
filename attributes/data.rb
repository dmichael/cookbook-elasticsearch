# Load configuration settings from data bag 'elasticsearch/data' or from node attributes
#
# In a data bag, you can define multiple devices to be formatted and/or mounted:
#
#    {
#      "id" : "data",
#      "<ENVIRONMENT>": {
#        "devices" : {
#          "/dev/sda2" : {
#            "file_system"      : "ext3",
#            "mount_options"    : "rw,user",
#            "mount_path"       : "/usr/local/var/data/elasticsearch/disk1",
#            "format_command"   : "mkfs.ext3",
#            "fs_check_command" : "dumpe2fs",
#            "ebs"            : {
#              "region"                : "us-east-1", // if undefined then instance region is used
#              "size"                  : 250,
#              "delete_on_termination" : true,
#              "type"                  : "io1",
#              "iops"                  : 2000
#            }
#          },
#          "/dev/sda3" : {
#            "file_system"      : "ext3",
#            "mount_options"    : "rw,user",
#            "mount_path"       : "/usr/local/var/data/elasticsearch/disk2",
#            "format_command"   : "mkfs.ext3",
#            "fs_check_command" : "dumpe2fs",
#          }
#        }
#      }
#
# To set the configuration with nodes attributes (eg. for Chef Solo), see the Vagrantfile.
#
# If EBS size is defined, new storage is automaticaly created, formated by format_command and mounted to mount_path.
# You should add mount_path of each defined device to attributes/default - default.elasticsearch[:data_path].
# Multiple data paths in default attributes can be defined as string separated by commas or as Array
#
data = Chef::DataBagItem.load('elasticsearch', 'data')[node.chef_environment] rescue {}

default.elasticsearch[:data][:devices] = data['devices'] || {}
