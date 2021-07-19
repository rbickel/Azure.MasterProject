
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade nginx-ingress ingress-nginx/ingress-nginx --install --namespace ingress-nginx --create-namespace --reuse-values --default-ssl-certificate=default/keycloakmasteraksrbklio

kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.4.0/cert-manager.yaml
kubectl create secret generic azuredns-config -n cert-manager --from-literal=client-secret=myclientsecret

helm repo add jfrog https://charts.jfrog.io
helm repo update
helm upgrade --install artifactory --set artifactory.masterKey=6a54d1ef117de7ac7dc3fe069b3acd06e938c30917db6cd2dc614b12fbf4d6d9 --set artifactory.joinKey=99c29d23cfa335a44cf751be7d136c35b77af54ca397b8f2db08e8ff7c358cdd --namespace artifactory jfrog/artifactory