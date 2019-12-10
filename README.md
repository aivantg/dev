# .dev - a tool to make your command line experience smoother

When it comes to my development projects, I like to keep things organized. But as I worked, I felt like I was being punished for my organization! For example, I would keep all my class homework files in a folder like `~/Development/Classes/CS61a/hw`, but that meant that I had a lot to type every time I wanted to open that folder! Even with tab completion, I felt frustrated. 

Command line aliases are a nice solution for this. I could add the line `alias hw="cd ~/Development/Classes/CS61a/hw"` to quickly get to my homework folder. But command line aliases felt unwieldy, and it felt like I was simply pushing the disorganization somewhere else. 

To solve some of these problems and help me make my command line as powerful and functional I could, I created a bash script that would 1) help me create aliases for my `cd` command and 2) let me add more powerful command line shortcuts easily and extensibly!


## Installation

1. Clone this repository into a folder somewhere on your computer. It can be stored anywhere! 
2. Open up `dev.sh` in a text editor
3. Edit the value for `DEV_CONFIG_PATH` to be the folder that contains `dev.sh`
4. Edit the value for `DEV_FOLDER_PATH` to be your "home" folder for all of your development projects.
5. Open up `~/.bash_profile` in a text editor and add the line `source ~/Development/.dev/dev.sh` to the top, replacing "~/Development/.dev/dev.sh" with wherever your `dev.sh` script is located

That's it!

Note: This script has only been tested in Bash 5.0.2. It relies on some specific features of bash and might need to be modified if using a different shell

## Basic Usage

In it's most basic form, `dev` just replaces `cd` with a few small differences

1. The `cd` command uses your current directory as the root for where to start looking for folders. The `dev` command instead uses your `DEV_FOLDER_PATH` variable as the prefix to all paths. So if your `DEV_FOLDER_PATH` was set to "~/Development", the following `cd` command could be translated to use `dev` as shown

`cd ~/Development/Classes/CS61a/hw` -> `dev Classes/CS61a/hw`

2. When using the `dev` command, you can optionally separate out folders using spaces instead of slashes (you'll see why soon). Here's what that looks like: 

`cd ~/Development/Classes/CS61a/hw` -> `dev Classes CS61a hw`

Now, this doesn't seem to be very useful yet, but here's where the aliases come in. Every passed in to the `dev` command, is looked up in dictionary of aliases to see if it expands out to a bigger path. Let's see what that means using an example.

Let's say we create the following two aliases: 

- `dev alias:mk c classes` (here we are aliasing 'c' to the path 'classes')
- `dev alias:mk 61a Classes/CS61a` (here we are aliasing '61a' to the path 'Classes/CS61a')

Now, we can rewrite the cd command from above in a few new ways!

`cd ~/Development/Classes/CS61a/hw` is equivalent to: 

- `dev Classes CS61a hw` (the full version)
- `dev c CS61a hw` (slightly shortened)
- `dev 61a hw` (even shorter)

Aliases simply let you shorten parts of file paths so that you can spend less time typing! Details about the alias plugin and all the commands available are below.

## Plugins

The power of the `dev` command doesn't stop at upgrading the `cd` command. By default, the `dev` command looks up all arguments as folders that you are trying to `cd` into. But if the first argument contains a ":", it assumes you are trying to call a function located in one of the plugins. 

For example:

`dev alias:mk c classes` is interpreted as a call to the `mk` function in the `alias` plugin. The rest of the arguments are then passed into that function to be processed. 

It's super easy to make your own plugins for the `dev` command and this lets you easily add new shortcuts to your workflow as you come up with them! 
I've included some of the plugins that I made (like `alias` which enables the core functionality of the dev command!), but feel free to peek under the hood, tweak them, and most-importantly add your own! (Details on how are below)

Below are some explanations of how to use the included plugins: 

### the `alias` plugin

This plugin enables the core "cd"-replacing functionality of the `dev` command. 

Note: This plugin stores it's aliases in a file called `project_aliases.txt` stored in the same folder as your `dev.sh` script. 

`dev alias:mk <alias> <path>` -  Will create a new directory alias, aliasing `<alias>` to `<path>`

`dev alias:rm <alias>` - Removes any aliases connected to `<alias>`

`dev alias:ls` - Lists all current aliases with associated paths

`dev alias:cd <arguments>` - changes the directory to the path built by appending the `DEV_FOLDER PATH` variable to each of the arguments separated by slashes. Each argument is first looked up in the alias dictionary. looks up each argument in alias dictionary, expands out to a full path, and changes the current directory. The `dev` command, by default, calls this function (as described earlier)!

*Example Usage*
```
>> dev alias:mk myproject Projects/Web/MyProject
>> dev myproject # will cd into your "~/Projects/Web/MyProject" using the alias you created above!
>> dev alias:rm myproject # Removes this alias
```


### the `cmd` plugin

This plugin helps organize any other general command line aliases you want to have. 

Note: This plugin stores it's command line aliases in a file called `cmd_aliases.txt` stored in the same folder as your `dev.sh` script. It also relies on the `_setup.sh` file to source these commands at the start of a new shell.

`dev cmd:mk <alias> <cmd>` -  Will create a new command alias, aliasing `<alias>` to a one line `<cmd>`. It will fail if the `<alias>` is already associated with an executable in your PATH variable. You may need to surround the command in double quotes if it contains single quotes inside of it.

`dev cmd:rm <alias>` - Removes any aliases connected to `<alias> 

`dev cmd:ls` - Lists all current aliases with associated commands. 

*Example Usage*
```
>> dev cmd:mk sshserver ssh root@1.2.3.4
>> sshserver # will run the ssh command we created an alias for above!
```

### the `env` plugin

This plugin helps organize environment variables you want to set in your command line

Note: This plugin stores it's environment variables in a file called `env.txt` stored in the same folder as your `dev.sh` script. It also relies on the `_setup.sh` file to source these variables at the start of a new shell.

`dev env:set <name> <value>` -  Will create a new environment variable. Will not create if environment variable already has a value

`dev env:setf <name> <value>` -  Will create a new environment variable regardless of whether it already has a value

`dev env:rm <name>` - Removes any environment variables with the name `<name>`

`dev env:ls` - Lists all current environment variables managed using this script

*Example Usage*
```
>> dev env:set SERVER 1.2.3.4
>> ssh root@$SERVER # the variable created above will be immediately available here!
```

### the `ssh` plugin

This plugin is a good example of a few commands that tend to be easy to forget pushed out into a plugin. Realistically, we could make use of the `cmd` plugin, but this allows for more extensibility in the future as well keeping our interactions clean

`dev ssh:pub` - Copies your SSH public key (stored in ~/.ssh/id_rsa.pub) to the clipboard

`dev ssh:edit` - Opens your SSH config file in the nano text editor

### the `profile` plugin

Same as above, this plugin is just a few commands to make interacting with your `~/.bash_profile` file a little more organized

`dev profile:edit` - Opens your `~/.bash_profile` file in the nano text editor

`dev profile:atom` - Opens your `~/.bash_profile` file in VS code

`dev profile:update` - Sources your `~.bash_profile` file to get new updates

### the `config` plugin

This plugin contains a few commands to make interacting with and updating your `dev.sh` file a little more organized. A meta-plugin!

`dev config:edit` - Opens your `dev.sh` file in the nano text editor
`dev config:develop` - Opens the folder containing your `dev.sh` file as a project folder in VS Code
`dev config:update` - Sources your `dev.sh` file to get new updates

### Creating your own Plugin

To create your own plugin, just add it to the `plugins` folder, and `[pluginname]=1` to the list of apps in `dev.sh`!

If you think your plugin might be useful to others, feel free to make a pull request :) 

## Final words

I made this to make my life easier, but it is more of an eloquent hack than it is "finished" product. Let me know if you have issues or ideas to help make this better!





