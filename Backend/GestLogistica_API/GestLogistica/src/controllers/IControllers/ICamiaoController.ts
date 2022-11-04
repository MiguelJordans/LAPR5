import { Request, Response, NextFunction } from 'express';

export default interface ICamiaoController  {
    createCamiao(req: Request, res: Response, next: NextFunction);
    getAllCamioes(req: Request, res: Response, next: NextFunction);
    getCamiaoByCaract(req: Request, res: Response, next: NextFunction);
    getCamiaoByMatricula(req: Request, res: Response, next: NextFunction);
    updateCamiao(req: Request, res: Response, next: NextFunction);
}