const express = require('express');
const router = express.Router();

const StudentController = require('../controllers/student-controllers')
const common = require('../controllers/common-contollers')

router.post('/register',StudentController.Register)

router.post('/likePost',common.LikePost)
router.get('/seeLike',common.seeLike)
router.get('/viewPost',common.ViewPost)  //for stud

router.get('/getDep',common.getDep)

router.post('/chat',common.Chat)
router.get('/getchat',common.getChat)
router.get('/checkchat',common.checkChat)
router.delete('/deleteChat',common.DeleteChat)

router.post('/conv',common.Conv)
router.get('/getconv',common.getConv)

router.get('/searchPost',common.SearchPost)

router.get('/chatBot',StudentController.ChatBot)
router.post('/rsvp',StudentController.RSVP)

module.exports = router;