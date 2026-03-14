import ApiClient from './ApiClient';

class FirstRunAPI extends ApiClient {
  constructor() {
    super('first-run');
  }
}

export default new FirstRunAPI();
