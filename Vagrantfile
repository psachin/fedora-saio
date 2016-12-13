# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

DEFAULT_BOX = "fedoraSaio"

vagrant_boxes = {
  DEFAULT_BOX => "https://download.fedoraproject.org/pub/fedora/linux/releases/23/Cloud/x86_64/Images/Fedora-Cloud-Base-Vagrant-23-20151030.x86_64.vagrant-virtualbox.box",
  # DEFAULT_BOX => "https://download.fedoraproject.org/pub/fedora/linux/releases/23/Cloud/x86_64/Images/Fedora-Cloud-Base-Vagrant-23-20151030.x86_64.vagrant-libvirt.box",
}

vagrant_box = (ENV['VAGRANT_BOX'] || DEFAULT_BOX)

local_config = {
  "full_reprovision" => (ENV['FULL_REPROVISION'] || 'false').downcase == 'true',
  "loopback_gb" => Integer(ENV['LOOPBACK_GB'] || 4),
  "extra_packages" => (ENV['EXTRA_PACKAGES'] || '').split(','),
  "storage_policies" => (ENV['STORAGE_POLICIES'] || 'default').split(','),
  "ec_policy" => (ENV['EC_POLICY'] || ''),
  "servers_per_port" => Integer(ENV['SERVERS_PER_PORT'] || 0),
  "object_sync_method" => (ENV['OBJECT_SYNC_METHOD'] || 'rsync'),
  "post_as_copy" => (ENV['POST_AS_COPY'] || 'true').downcase == 'true',
  "part_power" => Integer(ENV['PART_POWER'] || 10),
  "replicas" => Integer(ENV['REPLICAS'] || 3),
  "ec_replicas" => Integer(ENV['EC_REPLICAS'] || 6),
  "regions" => Integer(ENV['REGIONS'] || 1),
  "zones" => Integer(ENV['ZONES'] || 4),
  "nodes" => Integer(ENV['NODES'] || 4),
  "disks" => Integer(ENV['DISKS'] || 4),
  "ec_disks" => Integer(ENV['EC_DISKS'] || 8),
  "swift_repo" => (ENV['SWIFT_REPO'] || 'git://github.com/openstack/swift.git'),
  "swift_repo_branch" => (ENV['SWIFT_REPO_BRANCH'] || 'master'),
  "swiftclient_repo" => (ENV['SWIFTCLIENT_REPO'] || 'git://github.com/openstack/python-swiftclient.git'),
  "swiftclient_repo_branch" => (ENV['SWIFTCLIENT_REPO_BRANCH'] || 'master'),
  "swift_bench_repo" => (ENV['SWIFTBENCH_REPO'] || 'git://github.com/openstack/swift-bench.git'),
  "swift_bench_repo_branch" => (ENV['SWIFTBENCH_REPO_BRANCH'] || 'master'),
  "swift_specs_repo" => (ENV['SWIFTSPECS_REPO'] || 'git://github.com/openstack/swift-specs.git'),
  "swift_specs_repo_branch" => (ENV['SWIFTSPECS_REPO_BRANCH'] || 'master'),
  "extra_key" => (ENV['EXTRA_KEY'] || ''),
  "source_root" => (ENV['SOURCE_ROOT'] || '/vagrant'),
}

Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.define :fedoraSaio do |fedoraSaio|
    fedoraSaio.vm.box = "fedora/24-cloud-base"
    fedoraSaio.vm.hostname = "saio"
    fedoraSaio.vm.box_check_update = true

    fedoraSaio.vm.network :private_network,
                          :ip => "192.168.11.33",
                          :libvirt__network_name => "dev-net",
                          :management_network_name => "vagrant-libvirt",
                          :management_network_address => "192.168.121.0/24",
                          :management_network_mode => "nat",
                          :model_type => "virtio"
  end
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.


  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

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
  config.vm.provider "libvirt" do |libvirt|
    # Customize the amount of memory on the VM:
    libvirt.driver = "kvm"
    libvirt.cpus = 2
    libvirt.memory = 4096
    libvirt.nested = true

    libvirt.storage :file,
                    :size => '2G',
                    :path => 'saio-disk2.qcow2'
  end

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

  # config.vm.provision :shell, :inline => "curl -L https://www.opscode.com/chef/install.sh | sudo bash"

  # config.vm.provision :chef_solo do |chef|
  #   # chef.channel = "current"
  #   chef.cookbooks_path = ["cookbooks"]
  #   # chef.add_recipe("swift")
  #   # chef.json = local_config
  #   # chef.node_name = "saio"
  # end

  config.vm.provision :shell,
                      path: "install_packages.sh"
  config.vm.provision :shell,
                      path: "prepare_disk.sh"
  config.vm.provision :shell,
                      path: "copy_configs.sh"
  config.vm.provision :shell,
                      path: "sync_repos.sh"
  config.vm.provision :shell,
                      path: "remakerings.sh"
  config.vm.provision :shell,
                      path: "services.sh"

end
