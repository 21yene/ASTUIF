const { Op } = require('sequelize');
const bcrypt = require('bcrypt');
const {Staff , Post, Student, Category , RSVP, Department, School} = require('../models/schema');


module.exports = {
    async Register(req,res){
        const { fullname, email, password, picture } = req.body;
        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(password, saltRounds);
        try {
            const existingStaff = await Staff.findOne({ where: { email } });
            if (existingStaff) {
                return res.status(400).json({ message: 'User with this Email already exist', success: false });
            }
            const staff = await Staff.create({
                fullname,
                email,
                picture,
                password:hashedPassword
            });
            res.status(200).json({ success: true });

        } catch (err) {
            console.error(err);
            res.status(500).json({ message: 'Failed to register staff' });
        }
    },

    async AddPost(req,res){
        try {
            const result = await Staff.findOne({ where: { staffId: req.body.staffId } });
            const existingPost = await Post.findOne({
            where:{
                content: req.body.content,
                eventLocation: req.body.eventLocation,
                staffId: req.body.staffId,
                categoryId: req.body.categoryId
               }
            });

              
              
            if (!existingPost) {
              
            const post = await Post.create({
                  content: req.body.content,
                  eventLocation: req.body.eventLocation,
                  staffId: req.body.staffId,
                  categoryId: req.body.categoryId,
                  staffName: result.fullname,
                });
              
                if(req.body.rsvp){
                    const result = await Category.findOne({ where: { categoryId: req.body.categoryId } });
                    if (!result) { 
                        console.log('Invalid category ID'); 
                    return; 
                    }
                    const category = result.name.toUpperCase();  
                    const postId = post.postId;
                    
                    if (category === 'ALL') {
                        const staffs = await Staff.findAll();
                        const staffIds = staffs.map((staff) => staff.staffId);
                        const students = await Student.findAll();
                        const studentIds = students.map((student) => student.studentId);

                    
                        const staffEnteries = staffIds.map(forUser => { 
                            return {
                                postId: postId,
                                forUser: forUser,
                                userType: 'Staff',
                                status: false
                            }
                        });
                        const rsvpStaff = await RSVP.bulkCreate(staffEnteries);

                        const StudEnteries = studentIds.map(forUser => { 
                            return {
                                postId: postId,
                                forUser: forUser,
                                userType: 'Student',
                                status: false
                            }
                        });
                        const rsvpStud = await RSVP.bulkCreate(StudEnteries);
                        
                    } 
                    else if (category === 'STAFF') {
                        const staffs = await Staff.findAll();
                        const staffIds = staffs.map((staff) => staff.staffId);

                        const staffEnteries = staffIds.map(forUser => { 
                            return {
                                postId: postId,
                                forUser: forUser,
                                userType: 'Staff',
                                status: false
                            }
                        });
                        const rsvpStaff = await RSVP.bulkCreate(staffEnteries);

                    } 
                    else if (category === 'STUDENT') {
                        const students = await Student.findAll();
                        const studentIds = students.map((student) => student.studentId);

                        const StudEnteries = studentIds.map(forUser => { 
                            return {
                                postId: postId,
                                forUser: forUser,
                                userType: 'Student',
                                status: false
                            }
                        });
                        const rsvpStud = await RSVP.bulkCreate(StudEnteries);

                    }
                    else{
                        const result = await Department.findOne({where:{ShortedName: category }});
                        if(result === null){
                            const result = await School.findOne({where:{ShortedName: category }});

                            if (result === null){
                                console.log('category is not on both school and department so do nothing!!')
                            }
                            else{
                                const finalresult = await Department.findAll({where:{schoolId: result.schoolId }});

                                const stud = finalresult.map((dep)=>dep.depId);

                                const studentList = await Student.findAll({ where: { depId: { [Op.in]: stud } } });

                                const studentIds = studentList.map((student) => student.studentId);

                                const StudEnteries = studentIds.map(forUser => { 
                                    return {
                                        postId: postId,
                                        forUser: forUser,
                                        userType: 'Student',
                                        status: false
                                    }
                                });
                                const rsvpStud = await RSVP.bulkCreate(StudEnteries); 
                            }
                        } 
                        else {
                            const students = await Student.findAll({where:{depID:result.depId}});
                            const studentIds = students.map((student) => student.studentId);

                            const StudEnteries = studentIds.map(forUser => { 
                                return {
                                    postId: postId,
                                    forUser: forUser,
                                    userType: 'Student',
                                    status: false
                                }
                            });
                            const rsvpStud = await RSVP.bulkCreate(StudEnteries);
                        }
                    }
                }
          

            return res.status(201).json({ success:true, post: post })
        }
        } catch (error) {
            console.error(error);
            return res.status(500).json({ message: 'An error occurred while creating the post' });
        }
    },

    async MyPost(req,res){
        try {
            const posts = await Post.findAll({ where: { staffId:req.query.staffId } });
            if (posts.length === 0) {
                return res.status(404).json({ message: 'No posts found' });
            }
            return res.json(posts);
        } catch (err) {
            console.error(err);
            return res.status(500).json({ message: 'Internal Server Error' });
        }
    },

    async UpdatePost(req,res){
        const result = await Post.update(req.body,{
            where: {
                postId: req.body.postId
            }
        })
        res.send({
            success : true,
            data: result
        })
    },

    async DeletePost(req,res){
        const postId= req.body.postId;
        try {
            const post = await Post.findOne({ where: { postId: postId } });
            const rsvpCount = await RSVP.destroy({ where: { postId: postId } });

            if (!post) {
            return res.status(404).json({ error: 'Post not found' });
            }
            await post.destroy();
            return res.status(204).json({success:true});

        } catch (error) {
            console.error(error);
            return res.status(500).json({ error: 'Failed to delete post' });
        }
    },

    async ChatBot(req,res){},
}