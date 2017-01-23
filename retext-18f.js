var report = require('vfile-reporter');
var remark = require('remark');
var lint = require('remark-lint');

process.argv.shift()  // skip node.exe
process.argv.shift()  // skip name of js file

var fileContents = process.argv.join(' ')
var file = remark().use(lint, {firstHeadingLevel: true}).process(fileContents);

console.log(JSON.stringify(file.messages))

