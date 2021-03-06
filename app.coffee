express = require 'express'
path = require 'path'
session = require 'express-session'
mongoStore = require('connect-mongo')(session)

config = require './config'

logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'


routes = require './routes'

app = express()

# view engine setup
app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'jade'

app.use logger 'dev'
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()
app.use session
  secret: config.cookieSecret
  key: config.db
  cookie:
    maxAge: 1000 * 60 * 60 * 24* 30
  store: new mongoStore
    db: config.db

app.use express.static path.join __dirname, 'public'

# app.use '/', routes
# app.use '/users', users

app.use routes

# catch 404 and forward to error handler
# app.use(function(req, res, next) {
#   err = new Error('Not Found');
#   err.status = 404;
#   next(err);
# });

app.use (req, res, next) ->
  err = new Error "Oops.... 404"
  err.status = 404
  next err
# error handlers

# development error handler
# will print stacktrace
# if (app.get('env') === 'development') {
#     app.use(function(err, req, res, next) {
#         res.status(err.status || 500);
#         res.render('error', {
#             message: err.message,
#             error: err
#         });
#     });
# }
if app.get 'env' is 'development'
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
      message: err.message
      error: err

# production error handler
# no stacktraces leaked to user
# app.use(function(err, req, res, next) {
#     res.status(err.status || 500);
#     res.render('error', {
#         message: err.message,
#         error: {}
#     });
# });
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render 'error',
    message: err.message
    error: {}


module.exports = app;
