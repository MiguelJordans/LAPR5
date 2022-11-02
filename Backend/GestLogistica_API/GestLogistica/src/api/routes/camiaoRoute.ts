import { Router } from 'express';
import { celebrate, Joi } from 'celebrate';

import { Container } from 'typedi';

import ICamiaoController from '../../controllers/IControllers/ICamiaoController';

import config from "../../../config";

const route = Router();

export default (app: Router) => {
    app.use('/camioes', route);

    const ctrl = Container.get(config.controllers.camiao.name) as ICamiaoController;

    route.post('',
        celebrate({
            body: Joi.object({
                caractCamiao: Joi.string().required(),
                matriculaCamiao: Joi.string().required(),
                capacidadeCarga: Joi.string().required(),
                cargaMax: Joi.string().required(),
                cargaTotal: Joi.string().required(),
                tara: Joi.string().required(),
                tempoCarregamento: Joi.string().required(),
            })
        }),
        (req, res, next) => ctrl.createCamiao(req, res, next) );

}