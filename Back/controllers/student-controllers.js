const { reverse } = require('lodash');
const bcrypt = require('bcrypt')
const { Op } = require('sequelize');
const { Student , Post , RSVP , Department} = require('../models/schema');


module.exports = {
    async Register(req,res){
        const { fullname, email, password, picture, year,depId } = req.body;
        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(password, saltRounds);
        try {
          const existingStudent = await Student.findOne({ where: { email } });
          if (existingStudent) {
            return res.status(400).json({ message: 'User with this Email already exist', success: false });
          }
            const student = await Student.create({
                fullname, email, picture, year, depId,
                password:hashedPassword
            });
            res.status(200).json({ success: true});

          } catch (err) {
            console.error(err);
            res.status(500).json({ message: 'Failed to register Student' });
          }
    },

    async ChatBot(req,res){},
    async RSVP(req,res){},
}