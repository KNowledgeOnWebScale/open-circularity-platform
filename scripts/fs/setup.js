const fs = require('fs');
const fse = require('fs-extra');
const path = require('path');
const { actors, dirActors } = require('../config.js')

/**
 * Iterate over actor-directories & setup the file structure.
 */
actors
  .forEach(a => {
    const dirDT = path.resolve(dirActors, a, 'pod', 'data', 'dt');
    ['in', 'mapping', 'out'].forEach(dirName => {
      fse.ensureDirSync(path.resolve(dirDT, dirName))
    })
  })
