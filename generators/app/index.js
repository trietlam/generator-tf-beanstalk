"use strict";
const Generator = require("yeoman-generator");
const _ = require("lodash");
const chalk = require("chalk");
const yosay = require("yosay");

module.exports = class extends Generator {
  projectName() {
    const answers = [
      {
        type: "input",
        name: "projectName",
        message: "Project name?",
        default: _.kebabCase(this.appname) // Default to current folder name
      },
      {
        type: "input",
        name: "region",
        message: "Aws deployment region?",
        default: "ap-southeast-2" // Default to ap-southeast-2
      },
      {
        type: "input",
        name: "profile",
        message:
          "Aws deployment profile ? (according to your ~/.aws/config and ~/.aws/credentials files)",
        default: "deployment" // Default to deployment profile
      },
      {
        type: "input",
        name: "jumpbox",
        message: "Do you need an EC2 instance as jumpbox ?",
        default: false
      }
    ];

    return this.prompt(answers).then(props => {
      console.log({ props });
      // To access props later use this.props.someAnswer;
      this.props = props;
    });
  }

  writing() {
    console.log("Copying");
    this.fs.copy(this.templatePath("."), this.destinationPath("."));

    this.fs.copyTpl(
      this.templatePath("main.tfvars"),
      this.destinationPath("main.tfvars"),
      {
        profile: this.props.profile,
        name: this.props.projectName,
        region: this.props.region
      }
    );

    this.fs.copyTpl(
      this.templatePath("modules/jumpbox/jumpbox.var.tf"),
      this.destinationPath("modules/jumpbox/jumpbox.var.tf"),
      { jumpbox: this.props.jumpbox ? 1 : 0 }
    );
  }
  // Install() {
  //   this.installDependencies();
  // }
};
