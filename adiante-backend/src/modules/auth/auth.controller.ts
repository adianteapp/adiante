import { Request, Response } from 'express';
import * as authService from './auth.service';
import { LoginStatuses } from './auth.enum';

interface SignInRequest {
  username: string;
  password: string;
}

interface SignInResponse {
  id: number;
  name: string;
  accessToken: string;
}

async function signInPatient(req: Request<{}, {}, SignInRequest>, res: Response<SignInResponse | { message: string, errorCode: number }>): Promise<void> {
  const loginResult = await authService.validatePatientCredentials(req.body.username, req.body.password);

  switch (loginResult.validationResult) {
    case LoginStatuses.Succesfull:

      res.status(200).send({
        id: Number(loginResult.patient.id.toString()),
        name: loginResult.patient.name,
        accessToken: loginResult.token
      });
      break;

    case LoginStatuses.UserNameNotFound:
      res.status(404).send({ message: "User Not found.", errorCode: LoginStatuses.UserNameNotFound });
      break;
    case LoginStatuses.WrongPassword:
      res.status(401).send({ message: "Invalid Password!", errorCode: LoginStatuses.WrongPassword });
      break;
    default:
      res.status(500).send({ message: "Server error", errorCode: LoginStatuses.InternalError });
  }
}

export {signInPatient };