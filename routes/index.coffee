#Router

express = require 'express'
router = module.exports = express.Router()



router.get '/', (req, res) ->
  res.render 'index',
    title: 'Hello world!'

# router.route '/resource'
# .get (req, res) ->
#   res.send 'Hi, this is resource'

router.route '/register'
.get (req, res) ->
  res.render 'register',
    title: '注册'
.post (req, res) ->

router.route '/login'
.get (req, res) ->
  res.render 'login',
    title: '登入'
.post (req, res) ->

router.route '/post'
.get (req, res) ->
  res.render 'post',
    title: '发表'
.post (req, res) ->


router.get 'logout', (req, res) ->
  
  



