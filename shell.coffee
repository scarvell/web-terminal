spawn = require('child_process').spawn
express = require('express')
app = express.createServer()
io = require('socket.io').listen app

app.configure () ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'ejs'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + '/public')
  app.use express.bodyParser({})

app.configure 'development', () ->
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure 'production', () ->
  app.use express.errorHandler()

# Routes
app.get '/', (req, res) ->
  res.render 'index'

sh = spawn '/bin/bash'

onData = (data) ->
  process.stdout.write data

sh.stderr.on 'data', onData
sh.stdout.on 'data', onData

app.listen 3000

io.configure 'development', () ->
  io.set 'log level', 1

io.sockets.on 'connection', (socket) ->
  sh.stdout.on 'data', (line) ->
    socket.emit 'stdout', {data:line.toString()}

  sh.stderr.on 'data', (line) ->
    socket.emit 'stdout', {data:line.toString()}
    
  socket.on 'stdin', (data) ->
    try
      sh.stdin.write(data.data+'\n')
    catch err
      socket.emit 'stdout', {data:'Could not send command to shell server.'}

process.stdin.resume()

process.stdin.on 'data', (data) ->
  sh.stdin.write data