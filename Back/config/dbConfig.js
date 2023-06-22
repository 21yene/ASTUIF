const { Sequelize } = require('sequelize');
require('dotenv').config()
const connect = new Sequelize('hagriecom_astuif', 'root', 'Yerosen1892!', {
  host: 'localhost',
  dialect: 'mysql',
  logging:false
});

(async () => {
  try {
    await connect.authenticate();
    console.log('Connection has been established successfully.');
  } catch (error) {
    console.error('Unable to connect to the database:', error);
  }
})();

module.exports = connect;
