import jenkins.model.*;
import hudson.model.FreeStyleProject;
import hudson.tasks.Shell;
import javaposse.jobdsl.plugin.*;

project = Jenkins.instance.createProject(FreeStyleProject, "GSA Pipeline Demo")

project.getBuildersList().clear()

project.getBuildersList().add(new ExecuteDslScripts(
  new ExecuteDslScripts.ScriptLocation("false","jenkins/pipeline/**/*.groovy",null),
  false,
  RemovedJobAction.DELETE,
  RemovedViewAction.DELETE,
  LookupStrategy.JENKINS_ROOT,
  "jenkins/dsl")
);

project.save()
