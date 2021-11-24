#!/bin/sh
# check if directory exists /var/www

var_www="/var/www"
#var_www="$HOME/PhpstormProjects/deployer"
if [ -d $var_www ]
then
    echo "Directory /var/www exists"
else
    echo "Error: Directory /var/www does not exists."
    mkdir -p $var_www
fi

## check if directory exists /var/repo
#
var_repo="/var/repo"
#var_repo="$HOME/PhpstormProjects/deployer"
if [ -d $var_repo ]
then
    echo "Directory "  $var_repo  " exists"
else
    echo "Error: Directory "  $var_repo  " does not exists."
    mkdir -p $var_repo
fi


# get names of directories from user
# name of directory in /var/www
echo "Please type the directory name in " $var_www "?"
read www_dir

cd $var_www
mkdir -p $www_dir


# name of directory in /var/repo
echo "Please type the directory name in " $var_repo "?"
read repo_dir

cd $var_repo
mkdir -p $repo_dir


# run git init bare in /var/repo/
cd $repo_dir
git init bare

file="/hooks/post-receive"
echo "#!/bin/sh" > $file
echo "git --work-tree=$var_www/$var_www --git-dir=$var_repo/$repo_dir checkout -f main" > $file
cat $file


echo "Now run git remote add production ssh://root@yourserver$var_repo/$repo_dir"
echo "Then run git push production main"

cd "hooks"
chmod +x post-receive
