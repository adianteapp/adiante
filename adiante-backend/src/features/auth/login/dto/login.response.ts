import { LoginStatus } from "../login.enum"
export interface LoginResponse {
  id: number,
  name: string,
  accessToken: string
  status: LoginStatus
  }