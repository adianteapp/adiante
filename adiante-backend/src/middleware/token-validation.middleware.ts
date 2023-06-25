import {Request,Response,NextFunction} from 'express'
import jwt from 'jsonwebtoken';
import config from '../config/auth.config';


export default function verifyToken(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
    const originalMethod = descriptor.value;
    let token:string = undefined;
     
    descriptor.value = async function (req: Request, res: Response, next: NextFunction) {
      const token: string = req.headers["x-access-token"] as string;

      if (!token) {
        return res.status(403).send({  message: "No token provided!" });
      }

      jwt.verify(token, config.secret, (err: jwt.VerifyErrors | null, decoded: object | undefined) => {
        if (err) {
          return res.status(401).send({
            message: "Unauthorized!"
          });
        }else{
            const decodedPatientId = (decoded as { id: string }).id;
            req.params.patientId = decodedPatientId;
        }});

      await originalMethod.apply(this, [req, res, next]);
    };



  }
  