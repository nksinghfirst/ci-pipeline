# ci-pipeline

Step1 - Created an EC2 instance of t2.medium because it was pre-requisite for minikube (2CPU).
Step2 - Then installed docker on it for creating and testing images.
Setp3 - Created a docker image and tested it and it was working fine.
$ docker run -d -p 3333:3333 <image-name>
Step4 - Then created git repo and uploaded the files that is required for creating an image.
Step5 - Then created Jenkinsfile for CI part of the pipeline, to create an image, push it on dockerhub and starting the next job for CD.
Step6 - Then created a webhook in github so that the pipeline/job gets triggered when ever any changes happned in the git repo. 
Step7 - Then I installed Java and Jenkins on EC2.
Step8 - Then installed docker plugins in jenkins.
Step9 - Creted dockerhub and github credential so that it can access it.(created a tocken for github credential)
Step10 - Then created jenkins job for CI of pipeline selected webhook trigger and provided the link for github repo that contain files - Jenkinsfile and files for building image.
Step11 - Then buid the job to see if it was working or not.
K8s repo - 
Step12 - Then I created another git repo that contain Jenkinsfile for updating the daocker image tag in deployment.yaml file and yaml file for k8s and argocd
Step13 - Then created pipeline for it.
Step14 - Then I installed minikube, kubectl and argocd.
Step15 - Then I opened argocd and created a New App filled the detail and then created it.
Step16 - APP Health was Healthy.
Step17 - Then I make changes in deployment.yaml file changed 'replicas: 2 to replicas: 3' and then clicked on Refresh then it Synced it then their was 3 replicas.

Step18 - Then tested my CI CD setup by makings changes in code in git repo.
       - After making changes in repo the jenkins CI job started building for createing an image, push it on dockerhub and starting the next job for CD,
       - After successful build it trigger the build of another CD job for updating the tag in deployment.yaml file,
       - After that I waited for around 3 min for ArgoCD to check that the git repo has been updated (that it is out of sync) (AgroCD automatically check for changes eery 3 min)
       - Then AgroCD make changes in APP according to the desired state (according to department.yaml file)
       

# Problems I faced while doing all this
1. Jenkins wasn't able to push the image to dockerhub because it wasn’t able to access the docker.sock
sol. sudo chmod 777 docker.sock

2. Jenkins and AgroCD uses the same port for while running, So I change the port of Jenkins.
sol. sudo vi /lib/systemd/system/jenkins.service

3. Unable to use ArgoCD UI.
sol. kubectl edit svc argocd-server -n argocd  (change ‘type: ClusterIP’ to ‘type: NodePort’ ) &
   kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443

4. While ArgoCD was running, I wasn't able to use the terminal.
sol. So I also connected it through SSH Client. 

5. First I use LoadBlancer to get the external link for the website but the APP Health was stuck on 'Processing' 
sol. Then I used NodePort and then the APP Health was 'Healthy' (while i was looking about agrocd it was mentioned that if i want get an external link i should use LoadBlancer or NodePort)
