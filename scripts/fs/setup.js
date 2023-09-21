const fse = require('fs-extra');
const path = require('path');
const {dirActors,  actors, actorsWithoutDT } = require('../config.js')

// Iterate over actors with DT & set up the file structure.
actors
  .forEach(a => {
    const dirDT = path.resolve(dirActors, a, 'pod', 'data', 'dt');
    ['in', 'mapping', 'out'].forEach(dirName => {
      fse.ensureDirSync(path.resolve(dirDT, dirName))
    })
  })

// Iterate over actors without DT & set up the file structure.
actorsWithoutDT
  .forEach(a => {
    fse.ensureDirSync(path.resolve(dirActors, a, 'pod', 'data'))
  })
