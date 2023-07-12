const fs = require('fs');
const path = require('path');
const helpers = require('./helpers.js');
const { actors, dirActors } = require('../config.js')

/**
 * Iterate over actor-directories & execute their RML Mappings.
 */
actors
  .forEach(a => {
    const dirDT = path.resolve(dirActors, a, 'pod', 'data', 'dt');
    const dirMapping = path.resolve(dirDT, 'mapping');
    const fpathsRMLMappings =
      fs.readdirSync(dirMapping)
        // Only keep RML Mappings (Turtle)
        .filter( x => x.endsWith('.ttl'))
        // Resolve each path
        .map(x => path.resolve(dirMapping, x))

    // Execute RML Mappings
    fpathsRMLMappings.forEach( m => {
      const bnameOutput = path.basename(m).replace('.yml', '').replace('.ttl', '')
      const fpathOutput = path.resolve(m, `../../out/${bnameOutput}.ttl`);
      helpers.executeRMLMapping(m, fpathOutput);
    })
  })
