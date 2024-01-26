import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
    vus: 5,
    duration: '30s',
};

export default function () {
    const url = `http://workspace_bookworm:8080/`;

    http.get(url, options);
    sleep(1);
}
