const path = require('path');

module.exports.dirActors = './actors'; // Relative to package.json

module.exports.actors =[
  'building-owner',
  'lindner-group',
  'building-owner2',
  'ragn-sells'
];

module.exports.RMLMapper = {
  rmlmapperPath: path.resolve('./rmlmapper.jar'),
  tempFolderPath: path.resolve('.tmp'),
  serialization: 'turtle'
}
