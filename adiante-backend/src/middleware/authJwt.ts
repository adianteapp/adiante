import jwt from 'jsonwebtoken';
import config from '../config/auth.config';
import { NextFunction, Request, Response } from 'express';

interface RequestWithUserId extends Request {
  userId: number;
}


const verifyToken = (req: RequestWithUserId, res: Response, next: NextFunction) => {
      let token: string = req.headers["x-access-token"] as string;

      if (!token) {
        return res.status(403).send({
          message: "No token provided!"
        });
      }

      jwt.verify(token, config.secret, (err: jwt.VerifyErrors | null, decoded: object | undefined) => {
        if (err) {
          return res.status(401).send({
            message: "Unauthorized!"
          });
        }
        req.userId = (decoded as { id: number }).id;
        next();
      });
};

const authJwt = {
  verifyToken,
};

export default authJwt;
