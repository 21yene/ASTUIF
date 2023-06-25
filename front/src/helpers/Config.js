import axios from 'axios';
axios.defaults.withCredentials = true;
const ip = axios.create({
    baseURL: 'http://localhost:3000',
});

export default ip;