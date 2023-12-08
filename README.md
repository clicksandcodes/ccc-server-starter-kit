
###  Terraform 

#### Env Vars

**[Keep in Mind]**
👉 Linux/MacOS env vars must be prefixed with TF_VAR_ for tf to find them.

```bash
# tf only picks up env vars that are prefixed with TF_VAR_
# The DigitalOcean token is not used within the TF script so it does not need the TF_VAR_ prefix.
export DIGITALOCEAN_ACCESS_TOKEN=$(op item get "ClicksAndCodes 2A server" --fields label=DO_TOKEN_CCC_120823_2A)

# Note that this set of tf env vars has `&&` connecting them, so copy & paste them as a block.
export TF_VAR_LINUX_USER_DEVOPS_2A=$(op item get "ClicksAndCodes 2A server" --fields label=LINUX_USER_DEVOPS_2A) &&
export TF_VAR_LINUX_SSH_KEY_2A=$(op item get "ClicksAndCodes 2A server" --fields label=LINUX_SSH_KEY_2A) &&
export TF_VAR_LINUX_SERVER_NAME_2A=$(op item get "ClicksAndCodes 2A server" --fields label=LINUX_SERVER_NAME_2A)
```


#### Dealing with ssh keys

**[Keep in Mind]**
👉 You may need to add your ssh key to the IdentiyFile section of your `~/.ssh/config` file as shown below.  A problem I was running into was that I did not set a password on my ssh key during the ssh-keygen step.  Then I would attempt to ssh into a newly tf -created server and I would be prompted for my password.  Then I realized I was missing an entry in the ssh config file.  Once I added it, things worked as expected.


```bash
# open ~/.ssh/config with your IDE
code  ~/.ssh/config

# Add name of your ssh key to it, like this:
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/yourKeyFilename
```

### Notes with additional detail

For this project, we will use all new env vars, secrets, keys, etc.

- add ssh key
  - to generate new ssh key: `ssh-keygen -t ed25519 -C "emailAddressHere"`
  - Add the .pub key to 1pass. (example key name: LINUX_SSH_KEY_2A, with value of your ssh key)
  - **Don't forget!! -->** the .pub key to digitalocean.  Settings > Security > Add SSH Key
  - 👉 Review the section above "Dealing with ssh keys" and be sure to add the ssh key to your ssh config file as mentioned.
  - (Later, if you use CICD you'll need to add the private key to its secrets or in some way get the private key can be upload to the remote server it generates)
- Generate a Digital Ocean API key & add it to 1pass (example key name: DO_TOKEN, with value of your DO API Key)
- Pick server name & add it to 1pass (example key name: LINUX_SERVER_NAME, with value of your chosen server name)
- Pick server user's name & add it to 1pass (example key name: LINUX_USER_DEVOPS, with value of your chosen server user name)


