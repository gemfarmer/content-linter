var report = require('vfile-reporter');
var remark = require('remark');
var lint = require('remark-lint');
var retext = require('retext');

var unified = require('unified');
var markdown = require('remark-parse');
var remark2retext = require('remark-retext');
var remark2rehype = require('remark-rehype');
var html = require('rehype-stringify');

var spell = require('retext-spell');
var dictionary = require('dictionary-en-us');

var english = require('retext-english');
var quotes = require('retext-quotes');

var equality = require('retext-equality');
var simplify = require('retext-simplify');

var overuse = require('retext-overuse');

process.argv.shift()  // skip node.exe
process.argv.shift()  // skip name of js file

var fileContents = process.argv.join(' ')
var file = unified()
  .use(markdown)
  .use(lint)
  .use(
    remark2retext,
    unified()
      .use(overuse)
      .use(equality)
      .use(simplify)
      .use(spell, dictionary)
      .use(english)
      .use(quotes)
  )
  .use(remark2rehype)
  .use(html)
  .process(fileContents, function (err, file) {
    console.log(JSON.stringify(file.messages))
  });





