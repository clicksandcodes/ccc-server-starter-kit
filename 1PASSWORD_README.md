
#### Password management tools

I recommend storing your env vars in a pw management tool, such as 1password.

Why? Because then you can extract the password or API keys etc, dynamically, like this:

- Download 1password and install the 1password CLI tool.
- Create a 1password vault, such as "example vault"
- Inside the new vault, make a New Item of the type "Secure Note" with the exact name "some secure note example"
- Give it a password item.  Make the name of it "testItem" and add a simple password like "testPassword"
- Now run this: `op item get "some secure note example" --fields label=testItem`
- Now, set it into an env var: 
`export TESTITEM=$(op item get "some secure note example" --fields label=testItem)`
- and now, run `env` and you should see it in your list of env vars.
