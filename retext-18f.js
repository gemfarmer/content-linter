// eslint-disable-line global-require
/*eslint-env es6*/

var report = require('vfile-reporter');
// var _remark = require('remark');
var lint = require('remark-lint');
// var _retext = require('retext');

var fs = require('fs');

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
// var simplify = require('retext-simplify');
var simplify = require('retext-18f-simplify');

var overuse = require('retext-overuse');

var isCLI = false;
process.argv.shift()  // skip node.exe
process.argv.shift()  // skip name of js file

var fileContents = process.argv.join(' ')
if (fileContents.slice(0,4) === '////') {
  var filename = fileContents.slice(4, fileContents.length);
  fileContents = fs.readFileSync(filename, 'utf8');
  isCLI = true;
}

unified()
  .use(markdown)
  .use(lint)
  .use(
    remark2retext,
    unified()
      // .use(overuse)
      // .use(equality)
      .use(simplify)
      // .use(spell, dictionary)
      .use(english)
      // .use(quotes)
  )
  .use(remark2rehype)
  .use(html)
  .process(fileContents, function (err, file) {
    if (isCLI) {
      console.log(report(file))
    } else {
      console.log(JSON.stringify(file.messages))
    }
  });
