import ApiClient from './ApiClient.js';

class UserAPI extends ApiClient {
  constructor() {
    super('users');
  }

  me() {
    return this.client.get(`/${this.resource}/me`);
  }

}

export default new UserAPI();
