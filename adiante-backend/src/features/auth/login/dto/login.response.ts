import { LoginStatus } from "../login.enum"
export interface LoginResponse {
  name: string,
  accessToken: string
  status: LoginStatus
  }