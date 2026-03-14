import axios from 'axios';

class ApiClient {
  constructor(resource) {
    this.resource = resource
    this.client = axios.create({
      baseURL: `${window.globalConfig.hostUrl}/api`,
    })
    this.client.interceptors.request.use(config => {
      config.headers['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').content;
      return config;
    })
  }  

  create(data) {
    return this.client.post(`/${this.resource}`, data);
  }
};

export default ApiClient;
