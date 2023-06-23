const { reverse } = require('lodash');
const bcrypt = require('bcrypt');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const { Op } = require('sequelize');
const nodemailer = require('nodemailer');
const { Student} = require('../models/schema');

async function sendVerificationEmail(email) {
  // Create a nodemailer transporter
  const transporter = nodemailer.createTransport({
    // Configure the transporter settings (e.g., SMTP or sendmail)
    // For example, using a Gmail account:
    service: 'gmail',
    auth: {
      
    },
  });

  // Prepare the email message
  const mailOptions = {
    from: 'your_email@gmail.com',
    to: email,
    subject: 'Email Verification',
    text: 'Please verify your email address.',
    // You can also include an HTML version of the message
    // html: '<p>Please verify your email address.</p>'
  };

  // Send the email
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

        await sendVerificationEmail(student.email);

        res.status(200).json({ success: true });
     
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Failed to register Student' });
    }
  },

  upload,
};

