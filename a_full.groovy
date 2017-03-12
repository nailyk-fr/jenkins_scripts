#!groovy

pipeline {
	agent any
	stages {
		stage('Sync') {
			steps {
				build job: 'b_init', quietPeriod: 1
				build job: 'c_Source sync', quietPeriod: 1
				echo 'Init & sync done'
			}
		}
		stage('z3') {
			steps {
				build job: 'p_z3', quietPeriod: 2
				echo 'Lineage z3 done'
				build job: 'r_z3', quietPeriod: 2
				echo 'TWRP z3 done'
			}
		}
		stage('z3c') {
			steps {
				build job: 'p_z3c', quietPeriod: 2
				echo 'Lineage z3c done'
				build job: 'r_z3c', quietPeriod: 2
				echo 'TWRP z3c done'
			}
		}
		stage('sirius') {
			steps {
				build job: 'p_sirius', quietPeriod: 2
				echo 'Lineage sirius done'
				build job: 'r_sirius', quietPeriod: 2
				echo 'TWRP sirius done'
			}
		}
		stage('Release') {
			steps{
				build job: 'y_publish', quietPeriod: 2
				echo 'Released'
			}
		}
	}

	//build job: 'z_cleanup'
	//doc: https://wiki.jenkins-ci.org/display/JENKINS/Build+Flow+Plugin


}
