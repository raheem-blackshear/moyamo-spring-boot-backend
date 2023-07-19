pipeline {
    agent any
    stages {
        stage('init') {
            steps {
                 script {
                     print 'init parent'
                 }
            }
        }
    }
    post {
        always {
            print "always"
        }
        success {
            //sendEmail("Successful");
            print "Successful"
        }
        unstable {
            //sendEmail("Unstable");
            print "Unstable"
        }
        failure {
            //sendEmail("Failed");
            print "Failed"
        }
    }
}

def getDevVersion() {
    def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
    def versionNumber;
    if (gitCommit == null) {
        versionNumber = env.BUILD_NUMBER;
    } else {
        versionNumber = gitCommit.take(8);
    }
    print 'build  versions...'
    print versionNumber
    return versionNumber
}

def getReleaseVersion() {
    def pom = readMavenPom file: 'pom.xml'
    def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
    def versionNumber;
    if (gitCommit == null) {
        versionNumber = env.BUILD_NUMBER;
    } else {
        versionNumber = gitCommit.take(8);
    }
    return pom.version.replace("-SNAPSHOT", ".${versionNumber}")
}
