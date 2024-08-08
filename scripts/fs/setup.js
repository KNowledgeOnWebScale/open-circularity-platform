const fse = require('fs-extra');
const path = require('path');
const {dirActors,  actors, actorsWithoutDT, csss} = require('../config.js')

// Iterate over actors with DT & set up the file structure.
actors
  .forEach(a => {
    const dirDT = path.resolve(dirActors, a, 'pod-template', 'base', 'data', 'dt');
    ['in', 'mapping', 'out'].forEach(dirName => {
      fse.ensureDirSync(path.resolve(dirDT, dirName))
    });
  })

// Iterate over actors without DT & set up the file structure.
actorsWithoutDT
  .forEach(a => {
    fse.ensureDirSync(path.resolve(dirActors, a))
  })

// Iterate over Solid Community Servers.
csss
  .forEach(css => {
    fse.ensureDirSync(path.resolve('./docker-run', 'data', css))
  })
