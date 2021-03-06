import { Injectable } from "@angular/core";
import { Http, Headers, Response } from "@angular/http";
import 'rxjs/add/operator/map';
import { Configuration } from "./configuration";
import { User } from "../entity/user";

//this approach to login is taken from tutorial: https://medium.com/@juliapassynkova/angular-springboot-jwt-integration-p-1-800a337a4e0
//string values would possibly be better in constants, but it's not needed in this case
@Injectable()
export class AuthenticationService {
    static AUTH_TOKEN = '/oauth/token';

    constructor(private http: Http, private configuration: Configuration) { }
    
    login(username: string, password: string) {
        const body = `username=${encodeURIComponent(username)}&password=${encodeURIComponent(password)}&grant_type=password`;

        const headers = new Headers();
        headers.append('Content-Type', 'application/x-www-form-urlencoded');
        headers.append('Authorization', 'Basic ' + btoa('testjwtclientid' + ':' + 'XY7kmzoNzl100'));

        return this.http.post(this.configuration.ServerWithApiUrl + AuthenticationService.AUTH_TOKEN, body, {headers})
            .map(res => res.json())
            .map((res: any) => {
            if (res.access_token) {
                return res.access_token;
            }
            return null;
            });
    }
    
}