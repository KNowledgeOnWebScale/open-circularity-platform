#!/usr/bin/env node
const fse = require('fs-extra');
const path = require('path');
const { compileSettings } = require('@comunica/web-client-generator/lib/CompileSettings');
const queryDir = path.join(__dirname, 'queries');
const queryDirTemplateLess = path.join(__dirname, 'outputs', 'queries');
const settingsFile = path.join(__dirname, 'settings.json');
const outputFile = path.join(__dirname, 'outputs', 'queries.json');

// compileSettings() would consider the .templates too, so use a different directory, not containing the .template files
fse.copySync(queryDir, queryDirTemplateLess, {filter: (src,dest) => { return ! src.endsWith(".template"); }})

compileSettings(queryDirTemplateLess, settingsFile, outputFile);
