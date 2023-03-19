const config = require('./config.js')
const path = require('path');
const fs = require('fs');
const fse = require("fs-extra");
const util = require('util');
const exec = util.promisify(require('child_process').exec);
const yarrrml = require('@rmlio/yarrrml-parser/lib/rml-generator');
const N3 = require('n3');
const RMLMapperWrapper = require('@rmlio/rmlmapper-java-wrapper');

/**
 * Parse YARRRML file into RML file
 * @param fileIn input (YARRRML) file
 * @returns string
 */
module.exports.parseYarrrml = (fileIn) => {
  const yaml = fs.readFileSync(fileIn, {encoding: 'utf-8'})
  const y2r = new yarrrml();
  const triples = y2r.convert(yaml);
  
  const writer = new N3.Writer()
  writer.addQuads(triples);

  let triplesString = undefined;
  writer.end((error, result) => {
    triplesString = result;
  })
  return triplesString;
}

module.exports.writeFile = (data, fpath) => {
  fs.writeFileSync(fpath, data, { encoding: 'utf-8' });
}

module.exports.executeRMLMapping = async (fpathMapping, fpathOutput) => {
  const { rmlmapperPath, tempFolderPath, serialization } = config.RMLMapper;
  fse.removeSync(fpathOutput);
  const cmd = `java -jar ${rmlmapperPath} -m ${fpathMapping} -o ${fpathOutput} -s ${serialization}`;
  const cwd = path.dirname(fpathMapping);
  const {stdout, stderr} = await exec(cmd, {shell: "/bin/bash", cwd});
  console.info(stdout)
  console.error(stderr)
}

