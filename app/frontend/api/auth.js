import ApiClient from './ApiClient.js';

class AuthAPI extends ApiClient {
  constructor() {
    super('sessions');
  }

  login(username, password) {
    return this.create({ username, password })
  }

  logout() {
    return this.client.delete(`/${this.resource}`);
  }
}

export default new AuthAPI();
