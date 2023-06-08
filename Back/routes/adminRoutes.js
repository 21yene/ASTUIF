const express = require('express');
const router = express.Router();

const StaffController = require('../controllers/staff-controllers')
const AdminController = require('../controllers/admin-controllers')
const common = require('../controllers/common-contollers');
const adminControllers = require('../controllers/admin-controllers');

router.post('/login',common.login)
router.get('/logout',common.logout)
router.get('/user',common.user)

router.post('/addSchool',AdminController.addSchool)
router.post('/addDep',AdminController.addDepartment)
router.post('/addCategory',AdminController.addCategory)

router.get('/getDep',common.getDep)
router.get('/getSchool',common.getSchool)

router.get('/ViewPost',AdminController.ViewPost)  // for admin only.
router.get('/searchPost',common.SearchPost)  //????? not tested with post man

router.delete('/deletePost',StaffController.DeletePost)
router.put('/approveAcc',AdminController.ApproveAccount)
router.put('/banAcc',AdminController.BanAccount) // need title bit modifiaction with response handling


module.exports = router;