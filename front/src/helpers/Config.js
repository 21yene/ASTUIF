import axios from 'axios';

// Rest of your code...

const ip = axios.create({
    baseURL: 'https://astuifback.hagrie.com',
});
const realip = axios.create({
    baseURL: 'https://ts.hagrie.com',
});

export { realip, ip };