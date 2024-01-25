import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
    vus: 3,
    duration: '5s',
};

export default function () {
    const url = `http://workspace:8080/`;

    http.get(url, options);
    sleep(1);
}
