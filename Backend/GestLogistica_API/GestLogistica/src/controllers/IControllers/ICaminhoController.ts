import { Request, Response, NextFunction } from 'express';

export default interface ICaminhoController  {
  createCaminho(req: Request, res: Response, next: NextFunction);
}