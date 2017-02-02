/**
 * @author Duncan Beaton
 * @copyright 2016 Duncan Beaton
 * @license MIT
 * @module retext:overuse
 * @fileoverview Word overuse with Retext.
 */

'use strict';

/*
 * Dependencies.
 */

var keys = require('object-keys');
var difference = require('array-differ');
var search = require('nlcst-search');
var nlcstToString = require('nlcst-to-string');
var quotation = require('quotation');
var stopwords = require('stopwords').english;
var thesaurus = require('thesaurus/lib/th_en_US_new');

/*
 * Methods.
 */

/**
 * Get any duplicated Words in `node`.
 *
 * @param {Node} node - Parent to search in.
 * @param {Array.<string>} phrases - Phrases to search for.
 * @return {Object}
 */
function getDuplicates(node, phrases) {
  var duplicates = {};
  search(node, phrases, function (match, position, parent, phrase) {
    duplicates[phrase] = duplicates[phrase] ? duplicates[phrase] + 1 : 1
  });
  return duplicates;
}

/**
 * Get duplicates that are used too frequently.
 *
 * @param {Object} duplicates - Phrases to search for.
 * @param {number} limit - Number of times phrase must have been used.
 * @return {Array.<string>}
 */
function getOveruse(duplicates, limit) {
  var duplicate;
  for (duplicate in duplicates) {
    if (duplicates[duplicate] < limit) {
      delete duplicates[duplicate]
    }
  }
  return keys(duplicates);
}

/**
 * Attach.
 *
 * @param {Retext} retext - Instance.
 * @param {Object?} [options] - Configuration.
 * @param {Object.<Object>?} [options.list] - Phrases with suggestions
 * @param {Object.<Array>?} [options.ignore] - Phrases in the list
 * to ignore.
 * @param {Object.<number>?} [options.limit] - Number of times phrase
 * must have been used.
 * @return {Function} - `transformer`.
 */
function attacher(retext, options) {
  var settings = options || {};
  var ignore = settings.ignore || stopwords;
  var patterns = settings.list || thesaurus;
  var limit = settings.limit || 3;
  var list = keys(patterns);
  var phrases = difference(list, ignore);

  /**
   * Search `tree` for overuse.
   *
   * @param {Node} tree - NLCST node.
   * @param {VFile} file - Virtual file.
   */
  function transformer(tree, file) {
    var duplicates = getDuplicates(tree, phrases)
    var overuse = getOveruse(duplicates, limit)

    search(tree, overuse, function (match, position, parent, phrase) {
      var suggestions = patterns[phrase];
      var value = quotation(nlcstToString(match), '“', '”');

      var reason = 'Replace ' + value + ' with ' +
        quotation(suggestions, '“', '”').join(', ');

      var message = file.warn(reason, {
        'start': match[0].position.start,
        'end': match[match.length - 1].position.end
      });

      message.ruleId = phrase;
      message.source = 'retext-overuse';

    });

  }

  return transformer;
}

/*
 * Expose.
 */

module.exports = attacher;
