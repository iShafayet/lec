
commander = require 'commander'
fs = require 'fs'
path = require 'path'

{ LineEndingCorrector } = require 'line-ending-corrector'

commander.version '0.0.1'
commander.option '-o, --output <filename>', 'Output File Path'
commander.option '-r, --recursive', 'Run the algorithm recursively'
commander.option '-f, --force-write', 'Forcefully (over)write the destination file'
commander.option '-d, --directory', 'Apply on the contents of a directory'
commander.option '-c, --eolc <End Of Line Character>', 'End of Line Character'
commander.option '-e, --encoding <encoding>', 'Preferred Encoding'
commander.option '-v, --verbose', 'Output additional information'
commander.option '-n, --nodot', 'Ignore Dot Files'

commander.parse process.argv

eolc = commander.eolc or 'CRLF'
encoding = commander.encoding or 'utf8'
isVerboseMode = (commander.verbose is true)
shouldForceWrite = (commander.forceWrite is true)

shouldIgnoreDotFiles = (commander.nodot is true)

# deleteDirRecursive = (path) ->
#   return unless fs.existsSync(path)
#   fs.readdirSync(path).forEach (file, index) ->
#     curPath = path + '/' + file
#     if fs.lstatSync(curPath).isDirectory()
#       deleteDirRecursive curPath
#     else
#       fs.unlinkSync curPath
#   fs.rmdirSync path

getValidatedDirectory = (dir)->

  dir = path.normalize dir

  unless fs.existsSync dir
    console.log "Directory '#{dir}' does not exist"
    process.exit(3)

  stat = fs.statSync dir
  unless stat.isDirectory()
    console.log "Directory '#{dir}' is not a directory"
    process.exit(4)

  return dir

getValidatedSource = (source)->

  source = path.normalize source

  unless fs.existsSync source
    console.log "Source '#{source}' does not exist"
    process.exit(3)

  stat = fs.statSync source
  unless stat.isFile()
    console.log "Source '#{source}' is not a file"
    process.exit(4)

  return source

getValidatedDestination = (destination)->

  destination = path.normalize destination

  if fs.existsSync destination

    if shouldForceWrite

      fs.unlinkSync destination
      if fs.existsSync destination
        console.log "Destination '#{destination}' could not be removed. Please do it manually."
        process.exit(6)

    else
      
      console.log "Destination '#{destination}' already exists. Use the -f flag to force overwrite."
      process.exit(5)

  return destination

correct = (source, destination)->
  input = fs.readFileSync source, { encoding: encoding }
  [ wasAltered, output ] = LineEndingCorrector.correctSync input, { encoding, eolc }
  fs.writeFileSync destination, output, { encoding: encoding }
  if isVerboseMode
    if wasAltered
      console.log "correct content saved to '#{destination}'"
    else
      if source is destination
        console.log "'#{source}' already has the correct line endings."
      else
        console.log "'#{source}' already has the correct line endings. The file was copied to '#{destination}' as-is."


correctDir = (dir)->
  fs.readdirSync(dir).forEach (file, index) ->
    return if shouldIgnoreDotFiles and file.charAt(0) is '.'
    curPath = path.join dir, file
    stat = fs.lstatSync(curPath)
    if stat.isDirectory()
      correctDir curPath
    else
      correct curPath, curPath


if commander.directory

  isRecursive = (commander.recursive is true)

  if commander.output
    console.log "You may not provide an output path for directories"
    process.exit(1)

  directory = getValidatedDirectory commander.args[0]

  correctDir directory

else

  if commander.args.length is 0
    console.log 'Insufficient Argument(s)'
    process.exit(2)

  source = getValidatedSource commander.args[0]

  if commander.output
    destination = getValidatedDestination commander.output
  else
    destination = source

  correct source, destination


 








# console.log commander.args