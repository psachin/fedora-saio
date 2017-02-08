# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

# Not used
DEFAULT_BOX = "fedoraSwift"

boxes = [
  {
    :name => "proxy1",
    :eth1 => "192.168.100.33",
    :mem => 512,
    :cpu => 1
  },
  {
    :name => "object1",
    :eth1 => "192.168.100.20",
    :mem => 512,
    :cpu => 1
  },
  {
    :name => "object2",
    :eth1 => "192.168.100.21",
    :mem => 512,
    :cpu => 1
  },
  {
    :name => "object3",
    :eth1 => "192.168.100.22",
    :mem => 512,
    :cpu => 1
  }
]

Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  boxes.each do |box|
    config.vm.define box[:name] do |fedora|
      fedora.vm.box = "fedora/25-cloud-base"
      fedora.vm.hostname = box[:name]
      fedora.vm.box_check_update = true

      fedora.vm.network :private_network,
                        :ip => box[:eth1],
                        :libvirt__network_name => "swift-cluster-int",
                        :management_network_name => "replication",
                        :management_network_address => "192.168.100.0/24",
                        :management_network_mode => "nat",
                        :model_type => "virtio"

      fedora.vm.provider "libvirt" do |libvirt|
        # Customize the amount of memory on the VM:
        libvirt.autostart = true
        libvirt.uri = 'qemu+unix:///system'
        libvirt.driver = "kvm"
        libvirt.cpus = box[:cpu]
        libvirt.memory = box[:mem]
        libvirt.nested = true
        # libvirt.storage_pool_name = "swift-cluster-pool"

        if /object/ === box[:name]
          libvirt.storage :file,
                          :size => '2G',
                          :path => "swift-cluster-disk-#{box[:name]}.qcow2"
        end
      end
    end
  end
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.


  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.

  # config.vm.network :forwarded_port,
  #                   :guest => 22,
  #                   :host => 2222,
  #                   :adapter => "eth0",
  #                   :host_ip => "*"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.


  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "./cookbooks/swift/files/default/etc", "/etc", type: "rsync"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.

  config.vm.provision :shell,
                      path: "install_packages.sh"
  # config.vm.provision :shell,
  #                     path: "prepare_disk.sh"
  config.vm.provision :shell,
                      path: "copy_configs.sh"
  config.vm.provision :shell,
                      path: "sync_repos.sh"
  # config.vm.provision :shell,
  #                     path: "remakerings.sh"
  config.vm.provision :shell,
                      path: "services.sh"

end
