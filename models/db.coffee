config = require '../config'
mongo = require 'mongodb'

db = mongo.Db
connection = mongo.Connection
server = mongo.Server

module.exports = new db config.db, new server(config.host, connection.DEFAULT_PORT), save: true