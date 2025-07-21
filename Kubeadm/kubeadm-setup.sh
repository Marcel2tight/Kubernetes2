sudo su - : Makes you root user can be reliable secure than just sudo su

yum update -y : Updates the packages for Linux based systems, RHEL & CentOs
 
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo : Adds a new repository to the DNF package manager.

dnf repolist -v : displays a detailed list of enabled repositories i.e lists the repositories that came with the download

dnf install docker-ce -y : Installs the Docker CE package

systemctl start docker : Starts the Docker service

systemctl enable docker : Enables the Docker service

systemctl status docker --no-pager : Checks the status of docker without piping it to pager i.e. terminal is not frozen

systemctl status docker : Displays the status of the Docker service

vi /etc/docker/daemon.json : Opens the Docker daemon configuration file in the Vi editor.

## Specifies the cgroup driver to be used by Docker
{

    "exec-opts": ["native.cgroupdriver=systemd"]

}

cat /etc/docker/daemon.json : Displays the contents of the Docker daemon configuration file

systemctl restart docker : Restarts the Docker service

getenforce : Displays the current enforcing mode of SELinux (Security-Enhanced Linux).

setenforce 0 : Disables the enforcing mode of SELinux,setting it to permissive mode.

getenforce : Displays the current enforcing mode of SELinux after disabling it.(Security-Enhanced Linux

systemctl restart docker : Restarts the Docker service

## This overwrites any existing configuration in /etc/yum.repos.d/kubernetes.repo
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF

yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes : Installs Kubelet, Kubeadm, and Kubectl.


systemctl status kubelet : Displays the status of the Kubelet service

systemctl start kubelet : Starts the Kubelet service

systemctl enable kubelet : Enables kubelet i.e persists kubelet

yum install iproute-tc -y : Installs the iproute-tc package. Responsible for Managing Kubernetes Cluster Network Routing

## Permanently Set SELinux to Disable | Disable It Permanently SELinux
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

## Let IPTABLES see bridge traffic
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sysctl --system : Reloads the sysctl settings to apply the changes.

systemctl status firewalld : Displays the status of the firewalld service

systemctl stop firewalld : Stops the firewalld service

systemctl disable firewalld : Disbles the firewalld

## This generates the default configuration for containerd and saves it to a file.
containerd config default > /etc/containerd/config.toml

## Initializes a Kubernetes cluster using kubeadm and specifies the pod network CIDR. Only in the Master node
kubeadm init --pod-network-cidr=10.10.0.0/16 

## Used to add worker nodes to the Kubernetes cluster for the worker nodes only
kubeadm join 10.128.0.14:6443 --token ybytds.6orxgxi97mdo19z8 \
        --discovery-token-ca-cert-hash sha256:e335661b559a9f6fb03e9635a63ec9ad70d16faaced27934dcef3175607bb867

## Creates a directory named .kube in the user's home directory. which is used to store kubectl configuration files. Typically named config
mkdir -p $HOME/.kube 

## This sets up the kubectl configuration, allowing you to use kubectl commands to interact with your Kubernetes cluster.
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

## This command changes ownership of the kubeconfig file to the current user in this case marce
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get nodes : Retrieves information about the nodes in a Kubernetes cluster.

## Applies the Calico network plugin configuration to the Kubernetes cluster.
sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml

kubectl get cs : Retrieves the status of the control plane nodes in a Kubernetes cluster.

kubectl get pods -n kube-system : Retrieves a list of pods in the kube-system namespace.
## The kubectl get cs command is deprecated in newer Kubernetes versions, and the output may not be accurate










