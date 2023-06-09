const { reverse } = require('lodash');
const bcrypt = require('bcrypt');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const { Op } = require('sequelize');
const { Student} = require('../models/schema');

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'Images/Stud_Image');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});

const upload =()=>{
  return multer({
  storage: storage,
  limits: { fileSize: '10000000' },
  fileFilter: (req, file, cb) => {
    const fileTypes = /jpeg|jpg|png|gif/;
    const mimeType = fileTypes.test(file.mimetype);
    const extname = fileTypes.test(path.extname(file.originalname));
    if (mimeType && extname) {
      return cb(null, true);
    }
    cb('Give proper files format to upload');
  },
}).single('picture');}

module.exports = {
  async Register(req, res) {
    try {
        const { fullname, email, password, year, depId } = req.body;
        const picture = req.file ? req.file.path : null; 
        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(password, saltRounds);

        const existingStudent = await Student.findOne({ where: { email } });
        if (existingStudent) {
          if (req.file) {
            fs.unlinkSync(picture);
          }
          return res.status(400).json({ message: 'User with this Email already exists', success: false });
        }
        

        const student = await Student.create({
          fullname,
          email,
          picture,
          year,
          depId,
          password: hashedPassword,
        });

        res.status(200).json({ success: true });
     
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Failed to register Student' });
    }
  },

  upload,

  async ChatBot(req, res) {},
  async RSVP(req, res) {},
};
