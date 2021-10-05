#!/bin/bash

# A list of all the files and directories we want to create.
# Note that we only include a directory in this list if it's supposed to be
# empty, and we make sure to suffix it with / to let the procedure below know
# that this is an empty directory and not a file.
FS_MAP=(
  _config.html
  _data/navigation.yml
  _includes/footer.html
  _includes/header.html
  _includes/lists.html
  _includes/navigation.html
  _includes/post-card.html
  _includes/services.html
  _layouts/alternate.html
  _layouts/framework.html
  _layouts/post.html
  _posts/
  Gemfile
  index.html
  static/img/
  static/styles/style.scss
  static/vendor/
)

# We loop over our list of files/directories.
# If it's a directory, we create the directory.
# If it's a file, we create the file, as well as its parent directory.
#
# See the -p option of mkdir, it automatically creates parent directories
# if missing.
for FS_OBJECT in ${FS_MAP[*]}
do
  # ${VAR: -1} gives us the last character of a string
  #
  # Read the if block like this:
  # If the last character of FS_OBJECT is '/':
  #     Try to create directory named FS_OBJECT, if succeeds:
  #         Let the user know that FS_OBJECT directory was created.
  #     Else, nothing
  # Else, nothing
  #
  # I hope it's not too complicated and makes sense to you.
  if test "${FS_OBJECT: -1}" == '/'
  then
    if mkdir -p "$FS_OBJECT"
    then
      echo >&2 "directory created: \"$FS_OBJECT\""
    fi
    continue
  fi

  # dirname is a unix command that gives you only the parent directory part of
  # a compleyte filepath. For example:
  # dirname "/do/re/mi/fa/so/lo.c" -> /do/re/mi/fa/so
  #
  # Read the following block like so:
  # Create parent directory of FS_OBJECT
  # Try creating FS_OBJECT (itself), if succeeds:
  #     Let the user know that FS_OBJECT file was created.
  #
  # Simple, right? I hope so.
  mkdir -p "$(dirname "$FS_OBJECT")"
  if touch "$FS_OBJECT"
  then
    echo >&2 "file created: \"$FS_OBJECT\""
  fi
done

echo >&2 "setting up Gemfile"
# << SOMETHING is called a HEREDOC.
#
# Read it as following:
# Write EVERYTHING from here, until the string EOF, to Gemfile.
#
# Instead of trying to come up with a complicated quote structure to work with
# echo or printf, use heredocs for long, multi-line text.
cat << EOF > Gemfile
source "https://rubygems.org"

gem 'jekyll', '~>4.2'
gem 'webrick'
gem 'wdm', '>=0.1.0' if Gem.win_platform?
gem 'eventmachine', '~>1.0.0'
EOF

echo >&2 "setting up _config.yml"
cat << EOF > _config.yml
title:
description:
email:
phone:
author:
author_phone:
author_email:
url: ""
baseurl: ""
sass:
  sass_dir: static/styles
  style: uncompressed
markdown: kramdown
EOF

FRONTMATTER_SEP="---"

echo >&2 "setting up index.html"
cat << EOF > index.html
$FRONTMATTER_SEP
title: Home
laout: frameworl
$FRONTMATTER_SEP
EOF

echo >&2 "setting up _layouts/framework.html"
cat << EOF > _layouts/framework.html
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="{{ site.baseurl }}/static/styles/style.css" defer>

    <title>{{ site.title }} | {{ page.title }}</title>
</head>

<body>
</body>
</html>
EOF

echo >&2 "setting up static/styles/style.scss"
cat << EOF > static/styles/style.scss
// this stylesheet definitely works!
body {
  font-size: 16px;
}
EOF
