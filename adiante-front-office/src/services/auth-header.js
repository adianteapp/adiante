export default function authHeader() {
  let accessToken = JSON.parse(localStorage.getItem('user')).accessToken;

  if (accessToken) {
     return { 'x-access-token': accessToken };       // for Node.js Express back-end
  } else {
    return {};
  }
}
