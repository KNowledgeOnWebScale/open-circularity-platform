#!/usr/bin/env node
const path = require('path');
const { compileSettings } = require('@comunica/web-client-generator/lib/CompileSettings');
const queryDir = path.join(__dirname, 'queries');
const settingsFile = path.join(__dirname, 'settings.json');
const outputFile = path.join(__dirname, 'outputs', 'queries.json');
compileSettings(queryDir, settingsFile, outputFile);
