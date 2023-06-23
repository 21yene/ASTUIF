const express = require('express');
const router = express.Router();

const StaffController = require('../controllers/staff-controllers')
const AdminController = require('../controllers/admin-controllers')
const common = require('../controllers/common-contollers');

router.get('/getAllData',AdminController.getAllData)

router.post('/login',common.login)
router.get('/logout',common.logout)
router.get('/user',common.user)
router.get('/get',AdminController.GetStudent)

router.post('/addSchool',AdminController.addSchool)
router.post('/addDep',AdminController.addDepartment)
router.post('/addCategory',AdminController.addCategory)

router.get('/getDep',common.getDep)
router.get('/getSchool',common.getSchool)
router.get('/getCat',common.getCategory) //

router.get('/ViewPost',AdminController.ViewPost)  // for admin only.

router.get('/searchPost',common.SearchPost)
router.get('/searchStaff',common.SearchStaff)
router.get('/searchStudent',common.SearchStudent)  

router.delete('/deletePost',StaffController.DeletePost)
router.put('/approveAcc',AdminController.ApproveAccount)
router.put('/banAcc',AdminController.BanAccount) // need title bit modifiaction with response handling


module.exports = router;