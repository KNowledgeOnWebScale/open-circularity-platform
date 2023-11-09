const fse = require('fs-extra');
const path = require('path');
const {dirActors,  actors, actorsWithoutDT } = require('../config.js')

// Iterate over actors with DT & set up the file structure.
actors
  .forEach(a => {
    const dirDT = path.resolve(dirActors, a, 'pod', 'data', 'dt');
    ['in', 'mapping', 'out'].forEach(dirName => {
      fse.ensureDirSync(path.resolve(dirDT, dirName))
    });
    // this is needed 'cause bashlib does not overwrite existing .acl files after an environment variables file switch
    fse.emptyDirSync(path.resolve(dirDT, 'out'));
  })

// Iterate over actors without DT & set up the file structure.
actorsWithoutDT
  .forEach(a => {
    fse.ensureDirSync(path.resolve(dirActors, a, 'pod', 'data'))
  })
