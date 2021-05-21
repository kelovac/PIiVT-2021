import IApplicationResources from '../../common/IApplicationResources.interface';
import IRouter from '../../common/IRouter.interface';
import { Application } from 'express';
import AdministratorController from './controller';

export default class AdministratorRouter implements IRouter {
    public setupRoutes(application: Application, resources: IApplicationResources) {
        const administratorCotroller = new AdministratorController(resources);

        application.get("/administrator",        administratorCotroller.getAll.bind(administratorCotroller));
        application.get("/administrator/id",     administratorCotroller.getById.bind(administratorCotroller));
        application.post("/administrator",       administratorCotroller.add.bind(administratorCotroller));
        application.put("/administrator/id",     administratorCotroller.edit.bind(administratorCotroller));
        application.delete("/administrator/id",  administratorCotroller.delete.bind(administratorCotroller));
    }

}