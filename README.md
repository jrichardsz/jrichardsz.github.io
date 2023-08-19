# JRichardsz Blog

## Theme

- https://github.com/hmfaysal/Jekyll-HMFAYSAL-Theme

## Dev mode

docker run --rm \
  --volume="$PWD:/srv/jekyll" \
  -p 4000:4000 \
  -it jekyll/jekyll \
  bash

touch Gemfile.lock
chmod a+w Gemfile.lock
chmod a+w /srv/jekyll/
bundle install

jekyll serve -H 0.0.0.0 -P 4000

## Build static site

https://github.com/envygeeks/jekyll-docker/blob/master/README.md