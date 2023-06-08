const { reverse } = require('lodash');
const { Op } = require('sequelize');
const { Department , Post , Staff, School, Category } = require('../models/schema');


module.exports = {
    async addSchool(req, res) {
        try {
            
            let abbreviation = '';
            if (req.body.name.includes(' ')) {
            const words = req.body.name.split(' ');
            abbreviation = words.reduce((abbr, word) => {
              if (['and'].includes(word.toLowerCase())) {
                return abbr;
              }
              return abbr + word[0].toUpperCase();
            }, '');
            }
            else { abbreviation = req.body.name.toUpperCase();}

            const existingSchool = await School.findOne({ where: { name: req.body.name } });

            if (!existingSchool) {
              const school = await School.create({
                name:req.body.name,
                ShortedName:abbreviation
              });
            }
            
            let category = await Category.findOne({ where: { name: abbreviation } });
            if (!category) {
              category = await Category.create({ name: abbreviation });
            }

            res.status(201).json({ success: true });
          } catch (error) {
            console.error(error);
            res.status(500).json({ message: 'Internal server error' });
          }
    },

    async addDepartment(req, res) {
      try {
        let abbreviation = '';
        if (req.body.name.includes(' ')) {
          const words = req.body.name.split(' ');
          abbreviation = words.reduce((abbr, word) => {
            if (['of', 'and'].includes(word.toLowerCase())) {
              return abbr;
            }
            return abbr + word[0].toUpperCase();
          }, '');
        }
        else { abbreviation = req.body.name.toUpperCase();}

        const existingDepartment = await Department.findOne({ where: { name: req.body.name } });

        if (!existingDepartment) {
          const department = await Department.create({
            name: req.body.name,
            ShortedName: abbreviation,
            schoolId: req.body.schoolId
          });
        }
        let category = await Category.findOne({ where: { name: abbreviation } });
        if (!category) {
          category = await Category.create({ name: abbreviation});
        }

        res.status(201).json({ success: true });
      } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
      }
    },
    
    async addCategory(req, res) {
      try {
        let abbreviation = '';
        if (req.body.name.includes(' ')) {
          const words = req.body.name.split(' ');
          abbreviation = words.reduce((abbr, word) => {
            if (['of', 'and'].includes(word.toLowerCase())) {
              return abbr;
            }
            return abbr + word[0].toUpperCase();
          }, '');
        }
        else { abbreviation = req.body.name.toUpperCase();}

        let category = await Category.findOne({ where: { name: abbreviation } });
        if (!category) {
            category = await Category.create({name:abbreviation});
        }
        res.status(201).json({ success: true });
        } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
        }
    },

    async ApproveAccount(req,res){
        try {
            const staff = await Staff.findByPk(req.body.staffId);
            
            if (!staff) {
              return res.status(404).json({ success: false, message: "Staff not found" });
            }
            staff.isVerified = true;
            await staff.save();
            res.status(200).json({ success: true, message: "Staff account has been approved" });
            
          } catch (error) {
            console.error(error);
            return res.status(500).send('Internal Server Error');
          }
    },

    async ViewPost(req,res){
      try {
          const post = await Post.findAll();
          if (!post) {
            return res.status(404).json({ message: 'Post not found' });
          }
          return res.json(post);
        } catch (err) {
          console.error(err);
          return res.status(500).json({ message: 'Internal Server Error' });
        }
  },

    async BanAccount(req, res) {
      try {
        const staff = await Staff.findByPk(req.body.staffId);
        if (!staff) {
          return res.status(404).json({ success: false, message: "Staff account not found" });
        }
    
        if (!staff.isVerified) {
          return res.status(400).json({ success: false, message: "account is already banned or not approved" });
        }
    
        // Set isVerified to false to ban the account
        staff.isVerified = false;
        await staff.save();
    
        res.status(200).json({ success: true, message: "Staff account has been banned" });
      } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, message: "Something went wrong" });
      }
    }
    
}

// res.status(200).json({ success: true });