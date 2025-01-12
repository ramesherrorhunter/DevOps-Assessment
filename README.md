## Deployment of project

**To expose deployment port(8080)**
<br>

`kubectl expose deployment nodejs-app --type=NodePort`

**To port forward**
<br>

`kubectl port-forward svc/nodejs-service 8080:8080 --address 0.0.0.0`

**To access ArgoCD**
<br>

`kubectl port-forward -n argocd svc/argocd-server 9001:80 --address 0.0.0.0`

**To check ingress**
curl -L dev.local


**To check Load with Apache Benchmark (ab)**
`sudo apt-get install apache2-utils`

`ab -n 10000000 -c 1000 https://dev.local/`