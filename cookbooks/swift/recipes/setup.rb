
execute "dnf-update" do
  # Sadly, chef do not supports package install using dnf :(
  command "dnf update -y && dnf install python-dnf-plugins-extras-migrate -y && dnf-2 migrate -y"
  action :run
end

packager_essential = [
  "fedora-packager", "rpmdevtools", "python-d2to1", "python-oslo-sphinx",
  "python-pbr", "python-sphinx",
]

dev_essential = [
  "emacs-nox", "rsyslog", "wget", "@development-tools", "pypy", "openssl-libs",
  "openssl-devel",
]

saio_essential = [
  "curl", "gcc", "memcached", "rsync", "sqlite", "xfsprogs", "git-core",
  "libffi-devel", "xinetd", "liberasurecode-devel", "python-setuptools",
  "python-coverage", "python-devel", "python3-devel", "python-nose", "pyxattr",
  "python-eventlet", "python-greenlet", "python-paste-deploy",
  "python-netifaces", "python-pip", "python-dns", "python-mock",
  "redhat-rpm-config", "rsync-daemon", "python-pyeclib", "python3-pyeclib",
]

(dev_essential + saio_essential + packager_essential).each do |pkg|
  package pkg do
    action :install
  end
end
