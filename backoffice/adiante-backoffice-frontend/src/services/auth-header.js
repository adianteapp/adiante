export default function authHeader() {

  const user = localStorage.getItem('user');
  if (user) {
    let accessToken = JSON.parse(user).accessToken;
    return { 'x-access-token': accessToken };       // for Node.js Express back-end
  }else {
    return undefined;
  }
}
