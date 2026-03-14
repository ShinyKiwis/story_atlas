import ApiClient from './ApiClient.js';

class AuthAPI extends ApiClient {
  constructor() {
    super('sessions');
  }

  login() {
    console.log(client);
  }

  logout() {
    
  }
}

export default new AuthAPI();
