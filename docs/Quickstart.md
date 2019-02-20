Welcome to CIBox development workflow

Here you can see a quick how-to start current development workflow from scratch to first build for Pull Request.

#### Prepare GitHub project
* Clone repository to your local desktop. ```git clone https://github.com/cibox/cibox.git```
* Open ```cibox``` subfolder and run ```sh ./repository.sh``` there. You'll get ```FRESH_REPOSITORY``` subfolder where all the files prepared for your future project.
* Create new Git repository inside ```FRESH_REPOSITORY``` project and push it to your remote repository on GitHub.
* Create dedicated user at GitHub for not conflicting with your own personal account. The user's credentials ( [how to get a token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) ) would be used as bot for posting comments from Jenkins to GitHub. This user should have access to a project repo.

#### Jenkins provisioning
* Install ansible 1.9.x at your local desktop.
* Create your own Ubuntu 14.04 powered virtual machine, vps or dedicated server and get its IP address. We recommend [DigitalOcean VPS hosting](http://bit.ly/cibox-digitalocean), because we are using its droplets for spinning up CI instances for ~2 years without any issues. Allow [root access](http://askubuntu.com/questions/469143/how-to-enable-ssh-root-access-on-ubuntu-14-04) [without password](http://www.thegeekstuff.com/2008/11/3-steps-to-perform-ssh-login-without-password-using-ssh-keygen-ssh-copy-id/_) to this virtual machine.
* Go into cloned ```cibox``` subfolder and prefill IP address and previously created github bot repo's credentials of created machine to ```config.yml``` file within a folder. It is simple yml file.
```yml
github_url: https://github.com/NAME/REPOSITORY
github_username: BOT_NAME
github_token: BOT_ACCESS_TOKEN
github_password: BOT_PASSWORD
```
* Run ```sh ./provision``` from console of your desktop machine and wait untill all the software installed onto remote host. If there are errors during install or install been stalled for more than 10 minutes, try to stop ```CTRL-C``` and rerun the command untill it's done.
* After successful run of ```sh ./provision``` script you should login into ```http://IP:8080``` Jenkins console.


#### Jenkins provisioning using virtualbox/vagrant
[Requirement: vagrant 1.7+]
* Change settings in config.yml
* Go to builder-setup folder
* (Recommended) Regenerate keys in ssh-keys subfolder: `ssh-keygen` (select ssh-keys/id_rsa as the key file name)
* Prepare target host (VM) as described in the previous section
* Login to the target host
* Add contents of `ssh-keys/id_rsa.pub` to ~/.ssh/authorized_keys
* Logout from the target host
* Start virtualbox with `vagrant up`
* Go to /vagrant folder
* Run ```sh ./provision``` from console of your desktop machine and wait untill all the software installed onto remote host. If there are errors during install or install been stalled for more than 10 minutes, try to stop ```CTRL-C``` and rerun the command untill it's done.
* After successful run of ```sh ./provision``` script you should login into ```http://IP:8080``` Jenkins console.

#### How to work with project files?

* Run `vagrant up` withing the `FRESH_REPOSITORY` directory and you'll get ready to use virtual machine.

#### Create first PR on GitHub
* Create New Pull request for your project repo and wait ~5 minutes. You should get changed status and build comment afterwards.
* For debugging Jenkins problems use ```http://IP:8080/log/all``` UI or ```/var/log/jenkins/jenkins.log``` on your Jenkins server. Also take a look at [Troubleshooting section in CIBox documentation](http://docs.cibox.tools) for a possible issues.

##### Securing CI
For adding more security to spinned up CI server you need to close Jenkins port (8080 by default) via adding nginx/apache htpasswd protection or adding VPN connection only to the server.
Keep in mind that Jenking is not good in terms of security even if you will disable everything to anonymous user.
