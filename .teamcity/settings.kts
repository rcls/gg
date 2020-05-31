import jetbrains.buildServer.configs.kotlin.v2019_2.*
import jetbrains.buildServer.configs.kotlin.v2019_2.buildSteps.script
import jetbrains.buildServer.configs.kotlin.v2019_2.triggers.vcs
import jetbrains.buildServer.configs.kotlin.v2019_2.vcs.GitVcsRoot

/*
The settings script is an entry point for defining a TeamCity
project hierarchy. The script should contain a single call to the
project() function with a Project instance or an init function as
an argument.

VcsRoots, BuildTypes, Templates, and subprojects can be
registered inside the project using the vcsRoot(), buildType(),
template(), and subProject() methods respectively.

To debug settings scripts in command-line, run the

    mvnDebug org.jetbrains.teamcity:teamcity-configs-maven-plugin:generate

command and attach your debugger to the port 8000.

To debug in IntelliJ Idea, open the 'Maven Projects' tool window (View
-> Tool Windows -> Maven Projects), find the generate task node
(Plugins -> teamcity-configs -> teamcity-configs:generate), the
'Debug' option is available in the context menu for the task.
*/

version = "2020.1"

project {

    vcsRoot(HomeRalphDevTeamcityGg)

    buildType(Copy)
    buildType(Gogo)
}

object Copy : BuildType({
    name = "Copy"

    enablePersonalBuilds = false
    type = BuildTypeSettings.Type.DEPLOYMENT
    buildNumberPattern = "${Gogo.depParamRefs["teamcity.build.branch"]} ${Gogo.depParamRefs.buildNumber}"
    maxRunningBuilds = 1

    steps {
        script {
            name = "Copy"
            scriptContent = """
                set -e -x
                B='${Gogo.depParamRefs["teamcity.build.branch"]}'
                B="${'$'}{B//\//_}"
                mkdir -p /var/teamcity/"${'$'}B"
                cp -a * /var/teamcity/"${'$'}B"
            """.trimIndent()
        }
    }

    dependencies {
        artifacts(Gogo) {
            buildRule = lastSuccessful("+:*")
            artifactRules = "+:**"
        }
    }
})

object Gogo : BuildType({
    name = "Gogo"

    artifactRules = """
        Go_wrapper.xsa
        Gogo.runs/impl_1/*.ltx
        Gogo.runs/impl_1/*.rpt => reports
        p/Gogo/images/linux => boot
    """.trimIndent()

    vcs {
        root(DslContext.settingsRoot)

        cleanCheckout = true
    }

    steps {
        script {
            name = "Vivado"
            scriptContent = """
                set -e -x
                /home/Xilinx/Vivado/2019.2/bin/vivado -mode batch -source top.tcl
            """.trimIndent()
        }
        script {
            name = "Peta"
            scriptContent = """
                set -e -x
                p/peta.sh
            """.trimIndent()
        }
    }

    triggers {
        vcs {
            branchFilter = ""
        }
    }
})

object HomeRalphDevTeamcityGg : GitVcsRoot({
    name = "teamcity-gg"
    url = "git://localhost/home/ralph/dev/teamcity-gg"
    branchSpec = "+:refs/heads/*"
})
