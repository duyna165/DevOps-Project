![dev](https://user-images.githubusercontent.com/61420358/227756719-9d7a0e96-fe0a-442d-85ed-cf033ea26433.png)

- Dùng công cụ SCM ( GitHub ) --> Tạo EC2 cài đặt jenkins server , terraform , helm    -->  Dùng Jenkins Script ( file jenkins_scipt.sh) tạo EKS cluster từ file terraform và helm cài đặt ứng dụng ( bitnami, helm chart , nginx , load balancer) - Sử dụng S3 để lưu file tf.state ( file backend.tf) - 
dùng Slack để thông báo 


Noted :


Slack Notification
We will Login to slack and create a workspace by following the prompts. Then we will create a channel jenkins-cicd in our workspace.

Next we need to Add jenkins app to slack. Search in Google with Slack apps. Then search for jenkins add to Slack. We will choose the channel jenkins-cicd. It will give us to setup instructions, from there copy Integration token credential ID .

![slack-apps](https://user-images.githubusercontent.com/61420358/227756877-22a114ac-1be9-4088-9d74-48b5a3fcf119.png)
We will go to Jenkins dashboard Configure system -> Slack
Workspace:  example (in the workspace url example.slack.com)
credential: slacktoken 
default channel: #jenkins-cicd
We will add our sonar token to global credentials.
Kind: secret text
Secret: <paste_token>
name: slacktoken
description: slacktoken
![slack-notifications](https://user-images.githubusercontent.com/61420358/227756895-d2105d96-41a9-4305-aea3-758cc51596c1.png)


We will add below part to our Jenkinsfile in the same level with stages and push our changes.
post{
        always {
            echo 'Slack Notifications'
            slackSend channel: '#jenkinscicd',
                color: COLOR_MAP[currentBuild.currentResult],
                message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
    }
   
   
   ![slack-connection-successful](https://user-images.githubusercontent.com/61420358/227756925-8cb16da2-55f4-41d7-9441-2b43ac0403ed.png)

