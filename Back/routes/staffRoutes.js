const express = require('express');
const router = express.Router();

const StaffController = require('../controllers/staff-controllers')
const AdminController = require('../controllers/admin-controllers')
const common = require('../controllers/common-contollers')

router.post('/stReg',StaffController.upload(),StaffController.Register)

router.post('/post',StaffController.post(),StaffController.AddPost)
router.put('/updatePost',StaffController.UpdatePost)
router.delete('/deletePost',StaffController.DeletePost)
router.delete('/deleteChat',common.DeleteChat)

router.post('/createOpt',common.CreateOption)
router.get('/getOpt',common.GetOption)
router.delete('/deleteOpt',common.DeleteOption)


router.post('/likePost',common.LikePost)
router.get('/seeLike',common.seeLike)
router.get('/viewPost',AdminController.ViewPost)  //for staff
router.get('/myPost',StaffController.MyPost)

router.get('/getDep',common.getDep)
router.get('/getSchool',common.getSchool)

router.post('/chat',common.Chat)
router.get('/getchat',common.getChat)
router.get('/checkconv',common.checkChat)

router.post('/conv',common.Conv)
router.get('/getconv',common.getConv)

router.get('/searchPost',common.SearchPost)

router.get('/chatBot',StaffController.ChatBot)



module.exports = router;