#!/bin/bash

STR="---"
mkdir _data _includes _layouts _posts static && touch index.html Gemfile _config.yml && cd _data && touch navigation.yml && cd ../_includes && touch navigation.html header.html footer.html services.html post-card.html lists.html && cd ../_layouts && touch framework.html alternate.html post.html && cd ../static && mkdir img styles vendor && cd styles && touch style.scss && cd ../../
echo "source \"https://rubygems.org\"" > Gemfile && printf "\ngem 'jekyll', \'~> 4.2\'\ngem \'webrick\'\ngem \'wdm\', \'>= 0.1.0\' if Gem.win_platform?\ngem \'eventmachine\', \'~> 1.0.0\'\n" >> Gemfile
echo "title: Default" > _config.yml && printf "email: some@domain.com\nphone: +440000000000\nphone: \naddress: 12 - Earthen Ring, Ragefire Chasm\n\nmarkdown: kramdown\nhighlighter: rouge\n\nkramdown:\n input: GFM\n\nsass:\n sass_dir: static/styles\n\nexclude:\n - Changelog.md\n - CNAME\n - Gemfile\n - Gemfile.lock\n - LICENSE\n - README.md\n - screenshot.png\n - docs/" >> _config.yml
echo $STR > index.html && printf "title: Home\nlayout: framework\n---\n" >> index.html
cd _layouts && echo "<! DOCTYPE HTML>" > framework.html && printf "\n<html lang=\"en\">\n\n<head>\n\t<meta charset = \"UTF-8\" />\n\t<meta http-equiv\"X-UA-Compatible\" content=\"IE=edge\" />\n\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\n\t<title>{{ site.title }} | {{ page.title }}</title>\n\t<link rel=\"stylesheet\" href=\"{{ site.baseurl }}/static/styles/style.css\" defer />\n</head>\n<body>\n\n\n</body>\n</html>\n" >> framework.html && cd ../
cd _data && echo "" > navigation.yml && cd ../
cd static/styles/ && echo $STR > style.scss && echo "$STR" >> style.scss && printf "// This Stylesheet definitely works\nbody{\n\tfont-size: 16px\n}\n" >> style.scss && cd ../../

bundle update
bundle exec jekyll serve -l
