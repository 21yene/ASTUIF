const { Op, Sequelize, where } = require('sequelize');
const http = require('http');
const express = require('express');
const socket = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socket(server);

const bcrypt = require('bcrypt');
const {Staff , Post, Student, Category,Chat, RSVP,Preference,Option, Conversation, Department, Like,  School} = require('../models/schema');
const { query } = require('express');

const{sign}= require('jsonwebtoken');
const jwt = require("jsonwebtoken");
const { Console } = require('console');

const verifyUser = (req, res, next) => {
  const token = req.cookies.user;

  if (!token) {
    return res.status(401).json({ message: 'No token provided' });
  }
  else{
    jwt.verify(token, 'verySecretValue', (err, decoded) => {
      if (err) {
        return res.status(500).json({ message: 'Failed to authenticate token' });
      }else{
        req.user = decoded;
        next();
      }
    })
  }
};

async function myOption(req, res) {
  try {
    const get = await Preference.findOne({ where: { userId: req.query.userId, userType: req.query.userType } });
    if (get) {
      const result = await Option.findAll({ where: { preferenceId: get.preferenceId }, include: [Category] });
      const data = result.map(result => ({
        categoryId: result.categoryId,
        optionId: result.optionId,
        categoryName: result.Category.name
      }));

      return data;

    } else {
      return null;
    }
  } catch (err) {
    console.error(err);
    throw err;
  }
}

module.exports = {
      async user(req, res) {
        try {
          await verifyUser(req, res, async () => {
            return res.json({ status: 'Success', user: req.user });
          });
        } catch (error) {
          console.error(error);
          return res.status(500).json({ message: 'Internal server error' });
        }
      },

      async login(req, res) {
        try {
          const { email, password, loginAs } = req.body;
          
          let user = null;
          if (loginAs === 'student') {
            user = await Student.findOne({ where: { email } });
          } else if (loginAs === 'staff') {
            user = await Staff.findOne({ where: { email } });
          } else if (loginAs === 'admin') {
            user = await Admin.findOne({ where: { email } });
          } else {
            return res.status(400).json({ message: 'Invalid request' });
          }

          if (!user) {
            return res.status(401).json({ message: 'Invalid email or User Not Found' });
          }

          const passwordMatch = await bcrypt.compare(password, user.password);

          if (passwordMatch) {
            if(loginAs === 'student'){
              const { studentId, fullname, email, picture, year, depId } = user;
              const { ShortedName: depName} = await Department.findOne({ where: { depId: depId } });
              const done = await Preference.findOne({where:{userId:studentId,userType:loginAs}})
              let pref;
              if(done){
                const result= await Option.findAll({where:{preferenceId:done.preferenceId},include:[Category]})
                const data = result.map(result => ({
                  optionId: result.optionId,
                  YourPreference: result.Category.name
                    }
                  ));
                  pref=data;
              }else{pref=done}

            const accessToken = sign({ user: { studentId, fullname, email, picture, year, depId, depName,pref }}, "verySecretValue", { expiresIn: '1d' }); // Access token
            res.cookie('user', accessToken, { httpOnly: true });
            return res.status(200).json({ accessToken, user: { studentId, fullname, email, picture, year, depId, depName,pref } });
            }
            
            else if (loginAs === 'staff') {
              const { staffId, fullname, email, picture, isVerified } = user;
              const done = await Preference.findOne({where:{userId:staffId,userType:loginAs}})
              let pref;
              if(done){
                const result= await Option.findAll({where:{preferenceId:done.preferenceId},include:[Category]})
                const data = result.map(result => ({
                  optionId: result.optionId,
                  YourPreference: result.Category.name
                    }
                  ));
                  pref=data;
              }else{pref=done}
              const accessToken = sign({ user:{staffId, fullname, email, picture, isVerified,pref }}, "verySecretValue", { expiresIn: '1d' }); // Access token
              res.cookie('user', accessToken, { httpOnly: true });
              return res.status(200).json({ accessToken, user: { staffId, fullname, email, picture, isVerified,pref } });
            } 
            
            else if (loginAs === 'admin') {
              const { adminId, fullname, email, picture} = user;
              const accessToken = sign({ user}, "verySecretValue", { expiresIn: '1d' }); // Access token
              res.cookie('user', accessToken, { httpOnly: true });
              return res.status(200).json({ accessToken, user: { adminId, fullname, email, picture} });
            } else {
              return res.status(400).json({ message: 'Invalid request' });
            }
  
            
          }

          else {
            return res.status(401).json({ message: 'This is not a correct password' });
          }
        } catch (error) {
          console.error(error);
          return res.status(500).json({ message: 'Internal server error' });
        }
      },
    
      async logout(req, res) {
        try {
          res.clearCookie('user');
          return res.status(200).json({ message: 'Success' });
        } catch (error) {
          console.error(error);
          return res.status(500).json({ message: 'Internal server error' });
        }
      },

    async ViewPost(req,res){
      try {
        const depName = req.query.depName;
        const depCat = await Category.findOne({ where: { name: depName } });

        const form = await Department.findOne({ where: { ShortedName: depName } });
        const school = await School.findOne({ where: { schoolId: form.schoolId } });
        const schoolCat = await Category.findOne({ where: { name: school.ShortedName } });

        if (!depCat) {
          return res.status(404).json({ message: 'Category not found' });
        }

        const categoryIds = [];
        if (depCat) {
          categoryIds.push(depCat.categoryId);
        }
        if (schoolCat) {
          categoryIds.push(schoolCat.categoryId);
        }

        const posts = await Post.findAll({
          where: { categoryId: categoryIds },
          include: [
            { model: Category, attributes: ['name'] },
            { model: Staff, attributes: ['picture'] }
          ]
        });
        const likes = await Like.findAll({
          attributes: [
            'postId',
            [Sequelize.fn('COUNT', Sequelize.col('likeId')), 'likes']
          ],
          group: ['postId']
        });

        
        
        const mappedPosts = posts.map(post => {
          const postLikes = likes.find(like => like.postId === post.id);
          const likesCount = postLikes ? postLikes.likes : 0;
          const { Category, Staff, ...rest } = post.toJSON();
        
          return {
            ...rest,
            categoryName: post.Category.name,
            staffImage: post.Staff.picture,
            likes: likesCount
          };
        });
        

        if (!posts) {
          return res.status(404).json({ message: 'Posts not found' });
        }
        return res.json(mappedPosts);
      } catch (err) {
        console.error(err);
        return res.status(500).json({ message: 'Internal Server Error' });
      }
      
    },

    async CreateOption(req,res){
      try {

        const {categoryId, userId, userType} = req.body;

        const result = await Preference.findOne({where:{userId:userId, userType:userType}})

        if(result){
          if(userType==='Student'){
            return res.status(404).json({ success: false, message: "Student Can't have more than One Prefernece" });
          }
          else if(userType==='Staff'){
            let check = await Option.findOne({
              where:{preferenceId:result.preferenceId,categoryId:categoryId}
            })
            if(check){
              return res.status(400).json({ success: false, message: "Option already Created!!" });
            }else{
            const done = await Option.create({
              preferenceId: result.preferenceId,
              categoryId:categoryId,
            })
            return res.status(200).json({ success: true, message: "Option Successfully Created" });
          }
        }
          else{
            return res.status(404).json({ success: false, message: "User Type Is Not Eligible" });
          }
        }else{
          const go = await Preference.create({
            userId:userId,
            userType:userType
          }) 
          if(go){
            const done = await Option.create({
              preferenceId: go.preferenceId,
              categoryId:categoryId,});
              return res.status(200).json({ success: true, message: "Option Successfully Created" });
          }
        }
        
      }catch (err) {
        console.error(err);
        return res.status(500).json({ message: 'Internal Server Error' });
      }
    },

    async GetOption(req,res){
      try {
        const get = await Preference.findOne({where:{userId:req.query.userId, userType:req.query.userType}});
        if(get){
          const result = await Option.findAll({where:{preferenceId:get.preferenceId},include: [Category]})
          const data = result.map(result => ({
            categoryId:result.categoryId,
            optionId: result.optionId,
            categoryName: result.Category.name
              }
            ));

          return res.status(200).json({ success: true, data });

        }else{
          return res.status(400).json({ success: false, message: "No preference is Set for You!!" });
        }
      } catch (err) {
        console.error(err);
        return res.status(500).json({ message: 'Internal Server Error' });
      }
    },

    async DeleteOption(req,res){
      try {
        const {optionId,userId,userType} = req.query;

        let result =await Preference.findOne({where:{userId:userId,userType:userType}});
        if(result){
          let go = await Option.count({where:{preferenceId:result.preferenceId}})
          let demo = await Option.findOne({where:{optionId:optionId}})

          if(go===1 && demo){
           let opt = await Option.destroy({where:{optionId:optionId}})
           let pre = await Preference.destroy({where:{preferenceId:result.preferenceId}})
           if(opt && pre){
            return res.status(200).json({ success: true, message: "Successfully deleted!!" });
           }
          }else if(demo){
            let opt = await Option.destroy({where:{optionId:optionId}})
            if(opt){return res.status(200).json({ success: true, message: "Successfully deleted!!" });}
          }else{
            return res.status(400).json({ success: false, message: "There is No such Option" });
        }
        }else{
          return res.status(400).json({ success: false, message: "There is No option deleted!!" });
        }

      } catch (err) {
        console.error(err);
        return res.status(500).json({ message: 'Internal Server Error' });
      }
    },

    async SearchPost(req,res){
        const keyword = req.query.keyword;
        try {
            const posts = await Post.findAll({
            where: {
                [Op.or]: [
                { topic: { [Op.like]: `%${keyword}%` } },
                { content: { [Op.like]: `%${keyword}%` } }
                ]
            }
            });
            
            res.json(posts);
        } catch (err) {
            console.error(err);
            res.status(500).json({ message: 'Server error' });
        }
    },

    async LikePost(req,res){
        try {
            const check = await Like.findOne({
                where: { 
                  liked_by_type: req.body.liked_by_type,
                  liked_by_id: req.body.liked_by_id,
                  postId: req.body.postId
                }
              });

            if (check) {
                await Like.destroy({where: {likeId: check.likeId}});
                const likes = await Like.findAll({
                    where:{postId:req.body.postId},
                    attributes: ['postId', [Sequelize.fn('COUNT', Sequelize.col('likeId')), 'likes']],
                    group: ['postId']
                });
                
                res.status(200).json({likes});
            } else {
                const result = await Like.create(req.body);
                const likes = await Like.findAll({
                    where:{postId:req.body.postId},
                    attributes: ['postId', [Sequelize.fn('COUNT', Sequelize.col('likeId')), 'likes']],
                    group: ['postId']
                });
                res.status(200).json(likes);
            }
        } catch (err) {
            console.error(err);
            res.status(500).json({ message: 'Server error' });
        }
    },

    async seeLike(req,res){
        try {
            const likes = await Like.findAll({
                attributes: ['postId', [Sequelize.fn('COUNT', Sequelize.col('likeId')), 'likes']],
                group: ['postId']
            });
            res.status(200).json(likes);
        } catch (err) {
            console.error(err);
            res.status(500).json({ message: 'Server error' });
        }
    },

    async Chat(req,res){
      try {
          const check = await Chat.findOne({where:{
              topic: req.body.topic,
              categoryId: req.body.categoryId,
              creatorType: req.body.creatorType,
              creatorId: req.body.creatorId,
          }})
          if(check){
              res.status(500).json({message:'Chat The same type created', success:false})
          }else{
             const result = await Chat.create(req.body) 
             res.status(201).json({success:true});
          }
      }catch (err){
          console.log(err);
          res.status(500).json({message: 'server error'})
      }
    },

    myOption,
    async getChat(req, res){
        try {
          const { userType, userId } = req.query; 
          let chats = await Chat.findAll();
          if (true) {
            chats = chats.filter(chat => {
              if (chat.creatorType === userType || !chat.restrictedMode) {
                return true; }
              return false; 
            });
          }

          let data= chats
          if(userType && !userId){
            res.status(200).json(data);
          }

          if (userType && userId) {
            const options = await myOption(req, res);
            
            data = data.filter(chat => options.some(option => option.categoryId === chat.categoryId));
          res.status(200).json(data);
        }
        } catch (err){
          console.log(err);
          res.status(500).json({message: 'server error'});
        }
    },

    async checkChat(req,res){
        try {
            const { userType , chatId } = req.query; 
            let check = await Chat.findOne({where:{chatId:chatId}});  
            if (check.creatorType === userType || !check.restrictedMode) {
                res.json({success:true}) 
            }else{
                res.json({success:false}) 
            }
        }catch (err){
            console.log(err);
            res.status(500).json({message: 'server error'})
        }
    },

    async DeleteChat(req,res){
      const { creatorId, chatId, creatorType } = req.body;

      try {
          const chat = await Chat.findOne({ where: { chatId: chatId } });
          
          const parsedCreatorId = parseInt(creatorId);

          if(chat && chat.creatorType===creatorType && chat.creatorId===parsedCreatorId){
             await chat.destroy();
             return res.status(204).json({success:true});
          }else{
            return res.status(404).json({success:false});
          }
      } catch (error) {
          console.error(error);
          return res.status(500).json({ error: 'Failed to delete post' });
      }
    },

    async Conv(req,res){
        try{
            let from ;
            if(req.body.senderType==='student'){
                let result = await Student.findOne({where:{studentId:req.body.userId}})
                from = result.fullname;
            }else{
                let result = await Staff.findOne({where:{staffId:req.body.userId}})
                from = result.fullname;
            }
            const result = await Conversation.create({
                message:req.body.message,
                userId:req.body.userId,
                senderType:req.body.senderType,
                chatId:req.body.chatId,
                from:from
            });
            if (result) {
                res.json({success:true}) 
            }else{
                res.json({success:false}) 
            }
        }catch(err){
            console.log(err);
            res.status(500).json({message: 'server error'});
        }
    },

    async getConv(req,res){
        try{
            const result = await Conversation.findAll({
                where:{chatId:req.query.chatId},
                attributes:['from','message','userid', 'senderType']
            });
            if (result) {
                res.json(result) 
            }else{
                res.json({success:false}) 
            }
        }catch(err){
            console.log(err);
            res.status(500).json({message: 'server error'});
        }
    },

    async getDep(req,res){
        try{
            const result = await Department.findAll({attributes:['depId','name','ShortedName','schoolId']})
            // console.log(result)
            res.status(200).json(result)
        }catch(err){
            console.log(err);
            res.status(500).json({message: 'server error'});
        }
    },

    async getSchool(req,res){
      try{
          const result = await School.findAll({attributes:['schoolId','name','ShortedName']})
          // console.log(result)
          res.status(200).json(result)
      }catch(err){
          console.log(err);
          res.status(500).json({message: 'server error'});
      }
  },
    async getCategory(req,res){
      try{
          const result = await Category.findAll({attributes:['categoryId','name']})
          res.status(200).json(result)
      }catch(err){
          console.log(err);
          res.status(500).json({message: 'server error'});
      }
  },
}

