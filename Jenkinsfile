def revision = "1.0.${env.BUILD_ID}"
currentBuild.displayName=revision

node('') {

    currentBuild.result = "SUCCESS"

    try {

       stage('Checkout'){

        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/ahfarmer/emoji-search.git']]])
       }

       stage('Test'){

         env.NODE_ENV = "dev"

         print "Environment will be : ${env.NODE_ENV}"

       }

       stage('Build Docker'){
        sh """
        #!/bin/bash -l

         curl https://raw.githubusercontent.com/alwaysshrek/prudential-test/master/Dockerfile > Dockerfile
         OLD_IMAGES=`docker images | grep emoji-search | tr -s '[:space:]' | cut -d' ' -f3`
         [[ -n \$OLD_IMAGES ]] && docker rmi \$OLD_IMAGES
         docker build . --no-cache --network=host --compress -t emoji-search:${revision}
        """

       }

       stage('Deploy'){
        sh """
        #!/bin/bash -l

         echo 'ssh to dev server and tell it to pull new image'
         OLD_CONTAINERS=`docker ps | grep emoji-search | tr -s '[:space:]' | cut -d' ' -f1`
         [[ -n \$OLD_CONTAINERS ]] && docker stop \$OLD_CONTAINERS
         ssh dev@localhost "docker run -d -t --rm -p 3000:3000 emoji-search:${revision}"
        """

       }

       stage('Cleanup'){

         echo 'prune and cleanup'
     }



    }
    catch (err) {

        currentBuild.result = "FAILURE"

            mail body: "project build error is here: ${env.BUILD_URL}" ,
            from: 'xxxx@yyyy.com',
            replyTo: 'yyyy@yyyy.com',
            subject: 'Emoji Search project build failed',
            to: 'zzzz@yyyyy.com'

        throw err
    }

}
