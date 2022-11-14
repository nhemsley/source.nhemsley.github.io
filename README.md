# Building


## Building Javascript
Need to have a node installed, with yarn installed globally (npm install -g yarn)

```
yarn install
yarn build
```

## Building Jekyll Site

Currently using ruby 2.7.5

```
bundle install
bundle exec jekyll build
bundle exec jekyll s # to serve the site locally

```


## Building pdf

Using wkhtmltopdf

```
#to install 
sudo apt install wkhtmltopdf

(cd nhemsley.github.io && wkhtmltopdf --enable-local-file-access resume-pdf.html resume-nicholas-hemsley.pdf)

```
