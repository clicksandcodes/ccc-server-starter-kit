
### Problems I had

ssh key.  
For some reason, only one of the ssh keys I would try... woudl work.  It was an old one and so I did not want to use it for fresh projects which might end up being in production.

So, I created a new key, and with it, the server would be created. The user would be there in the list when I'd run `less /etc/passwd`.

But remote connection with the ssh key would not work-- it would prompt me for a password even though the key had no pw.  Maybe its name was too long or something?  Will re-create ssh key and try again.  Still, nope.

... Found the problem:
I did not add the new ssh key to my ssh config file:

```bash
# open ~/.ssh/config with your IDE
code  ~/.ssh/config

# Add name of your key to it, like this:
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/yourKeyFilename
```