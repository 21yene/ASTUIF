const bcrypt = require('bcrypt');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const { Op } = require('sequelize');
const nodemailer = require('nodemailer');
const jwt = require('jsonwebtoken');
const { Student} = require('../models/schema');
const {USER,PASSWORD,JWT_SECRET,HOST} = require('../config/verify.js')

async function sendVerificationEmail(email) {
  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: USER,
      pass: PASSWORD,
    },
  });
  const token = jwt.sign({ email }, JWT_SECRET, { expiresIn: '1w' });
  const verificationLink = `${HOST}/api/student/verify?token=${token}`;

  const mailOptions = {
    from: 'your_email@gmail.com',
    to: email,
    subject: 'Email Verification For ASTU Interactive Feed',
    text: `Please verify your email address by clicking the following link: ${verificationLink}`,
  };

  await transporter.sendMail(mailOptions);
}

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
        if(student){sendVerificationEmail(student.email);}

        res.status(200).json({ success: true });
     
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Failed to register Student' });
    }
  },

  async VerifyStudent(req, res){
    try {
      const { token } = req.query;
      const decodedToken = jwt.verify(token, 'JWT_SECRET');
      const { email } = decodedToken;

      const student = await Student.findOne({ where: { email } });
  
      if (!student) {
        return res.status(400).json({ message: 'Invalid verification token' });
      }
      if (student.isVerified) {
        res.status(200).json({ success: false });// Redirect to a page indicating that the email is already verified
      }
      student.isVerified = true;
      await student.save();
      res.status(200).json({ success: true });
      
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Failed to verify email' });
    }
  },

  upload,
};

