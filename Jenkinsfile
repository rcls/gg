pipeline {
    agent any

    stages {
        stage('Vivado') {
            steps {
               sh '/home/Xilinx/Vivado/2019.2/bin/vivado -mode batch -source top.tcl'
               sh './peta-base/peta.sh'
            }
            post {
                always {
                    archiveArtifacts artifacts:'Go_wrapper.xsa,**/*.ltx'
                }
            }
        }
    }
}
