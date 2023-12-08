
###  Terraform Env Vars


```bash
# Example of pulling an item from 1pass and setting it into an env var.
export TESTITEM=$(op item get "ClicksAndCodes 1A server" --fields label=testItem)
```

```bash
# tf only picks up env vars that are prefixed with TF_VAR_
# The DigitalOcean token is not used within the TF script so it does not need the TF_VAR_ prefix.
export DIGITALOCEAN_ACCESS_TOKEN=$(op item get "ClicksAndCodes 2A server" --fields label=DO_TOKEN_CCC_120823_2A)

# Note that this set of tf env vars has `&&` connecting them, so copy & paste them as a block.
export TF_VAR_LINUX_USER_DEVOPS=$(op item get "ClicksAndCodes 2A server" --fields label=LINUX_USER_DEVOPS_2A) &&
export TF_VAR_LINUX_SSH_KEY=$(op item get "ClicksAndCodes 2A server" --fields label=LINUX_SSH_KEY_2A) &&
export TF_VAR_LINUX_SERVER_NAME=$(op item get "ClicksAndCodes 2A server" --fields label=LINUX_SERVER_NAME_2A)

```


For this project, we will use all new env vars, secrets, keys, etc.

- add ssh key
  - to generate new ssh key: `ssh-keygen -t ed25519 -C "emailAddressHere"`
  - Add the .pub key to 1pass. (example key name: LINUX_SSH_KEY_2A, with value of your ssh key)
  - **Don't forget!! -->** the .pub key to digitalocean.  Settings > Security > Add SSH Key
  - (Later, if you use CICD you'll need to add the private key to its secrets or in some way get the private key can be upload to the remote server it generates)
- Generate a Digital Ocean API key & add it to 1pass (example key name: DO_TOKEN_CCC_120823_2A, with value of your DO API Key)
- Pick server name & add it to 1pass (example key name: LINUX_SERVER_NAME_2A, with value of your chosen server name)
- Pick server user's name & add it to 1pass (example key name: LINUX_USER_DEVOPS_2A, with value of your chosen server user name)


