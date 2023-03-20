const fs = require('fs');
const path = require('path');
const helpers = require('./helpers.js');
const { actors, dirActors } = require('../config.js')

/**
 * Iterate over actor-directories & parse their YARRRML mappings to RML (Turtle).
 */
actors
  .forEach(a => {
    const dirDT = path.resolve(dirActors, a, 'data', 'dt');
    const dirMapping = path.resolve(dirDT, 'mapping');
    const fpathsYARRRMLMappings =
      fs.readdirSync(dirMapping)
        // Only keep files with a YAML extension
        .filter( x => x.endsWith('.yml') || x.endsWith('.yaml'))
        // Resolve each path
        .map(x => path.resolve(dirMapping, x))

    // Parse YARRRML Mappings to Turtle
    fpathsYARRRMLMappings.forEach( src => {
      const ttl = helpers.parseYarrrml(src);
      const dest = `${src}.ttl`;
      helpers.writeFile(ttl, dest)
    })
  })