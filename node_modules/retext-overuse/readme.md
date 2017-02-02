# retext-overuse [![Build Status][travis-badge]][travis]

Check phrases for overuse with [**retext**][retext].

## Installation

[npm][npm-install]:

```bash
npm install retext-overuse
```

**retext-overuse** is also available for [duo][duo-install], and as an
AMD, CommonJS, and globals module, [uncompressed and compressed][releases].

## Usage

```js
var retext = require('retext');
var overuse = require('retext-overuse');
var report = require('vfile-reporter');

retext()
    .use(overuse)
    .process([
		'That movie was amazing',
		'The acting was amazing',
		'The story was amazing'
    ].join('\n'), function (err, file) {
        console.log(report(file));
    });
```

Yields:

```txt
<stdin>
	1:16-1:23: Replace “amazing” with “astonishing”, “surprising”, “awe-inspiring”, “awesome”, “awful”, “awing”, “impressive”
	2:16-2:23: Replace “amazing” with “astonishing”, “surprising”, “awe-inspiring”, “awesome”, “awful”, “awing”, “impressive”
	3:15-3:22: Replace “amazing” with “astonishing”, “surprising”, “awe-inspiring”, “awesome”, “awful”, “awing”, “impressive”

⚠ 3 warnings
```

## API

### `retext.use(overuse[, options])`

Word overuse with Retext.

**Parameters**

*   `overuse` — This plug-in;

*   `options` (`Object?`, optional):

	*	`list` (Object.<Object>)
	 	- Phrases with suggestions.

	*	`ignore` (Object.<Array>)
	 	- Phrases in the list to ignore.

	* 	`limit` (Object.<number>)
	 	- Number of times phrase must have been used.

## License

[MIT][license] © [Duncan Beaton][author]

<!-- Definitions -->

[travis-badge]: https://img.shields.io/travis/dunckr/retext-overuse.svg

[travis]: https://travis-ci.org/dunckr/retext-overuse

[npm-install]: https://docs.npmjs.com/cli/install

[duo-install]: http://duojs.org/#getting-started

[releases]: https://github.com/dunckr/retext-overuse/releases

[license]: LICENSE

[author]: http://dunckr.com

[retext]: https://github.com/wooorm/retext
