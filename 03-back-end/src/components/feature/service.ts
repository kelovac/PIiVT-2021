import IModelAdapterOptionsInterface from '../../common/IModelAdapterOptions.interface';
import BaseService from '../../services/BaseService';
import FeatureModel from './model';
import * as mysql2 from "mysql2/promise";
import CategoryService from '../category/service';
import CategoryModel from '../../../dist/components/category/model';
import IErrorResponse from '../../../dist/common/IErrorResponse.interface';
import { IAddFeature } from './dto/AddFeature';
import { IEditFeature } from './dto/EditFeature';

class FeatureModelAdapterOptions implements IModelAdapterOptionsInterface {
    loadCategory: boolean = false;
}

class FeatureService extends BaseService<FeatureModel> {
    private categoryService: CategoryService;

    constructor(db: mysql2.Connection) {
        super(db);
        this.categoryService = new CategoryService(this.db);
    }

    protected async adaptModel(
        data: any,
        options: Partial<FeatureModelAdapterOptions>
    ): Promise<FeatureModel> {
        const item: FeatureModel = new FeatureModel();

        item.featureId  = +(data?.feature_id);
        item.name       = data?.name;
        item.categoryId = +(data?.category_id);

        if (options.loadCategory && item.categoryId) {
            const result = await this.categoryService.getById(item.categoryId);
            item.category = result as CategoryModel;
        }

        return item;
    }

    public async getById(
        featureId: number,
        options: Partial<FeatureModelAdapterOptions> = { },
    ): Promise<FeatureModel|null|IErrorResponse> {
        return await this.getByIdFromTable("feature", featureId, options);
    }

    public async getAllByCategoryId(
        categoryId: number,
    ): Promise<FeatureModel[]> {
        const allFeatures: FeatureModel[] = [];

        let currentParent: CategoryModel|null = await this.categoryService.getById(categoryId) as CategoryModel;

        while (currentParent !== null) {
            allFeatures.push(
                ... await this.getAllByFieldNameFromTable(
                    "feature",
                    "category_id",
                    currentParent.categoryId,
                ) as FeatureModel[]
            );

            currentParent = await this.categoryService.getById(
                currentParent.parentCategoryId
            ) as CategoryModel | null;
        }

        return allFeatures;
    }

    public async add(data: IAddFeature): Promise<FeatureModel|IErrorResponse> {
        return new Promise<FeatureModel|IErrorResponse>(resolve => {
            const sql = "INSERT feature SET name = ?, category_id = ?;";
            this.db.execute(sql, [ data.name, data.categoryId ])
                .then(async result => {
                    const insertInfo: any = result[0];
                    const newId: number = +(insertInfo?.insertId);
                    resolve(await this.getById(newId));
                })
                .catch(error => {
                    resolve({
                        errorCode: error?.errno,
                        errorMessage: error?.sqlMessage
                    });
                })
        });
    }

    public async edit(
        featureId: number,
        data: IEditFeature,
        options: Partial<FeatureModelAdapterOptions> = { },
    ): Promise<FeatureModel|IErrorResponse> {
        return new Promise<FeatureModel|IErrorResponse>(resolve => {
            const sql = "UPDATE feature SET name = ? WHERE feature_id = ?;";
            this.db.execute(sql, [ data.name, featureId ])
                .then(async result => {
                    resolve(await this.getById(featureId, options));
                })
                .catch(error => {
                    resolve({
                        errorCode: error?.errno,
                        errorMessage: error?.sqlMessage
                    });
                })
        });
    }

    public async delete(featureId: number): Promise<IErrorResponse> {
        return new Promise<IErrorResponse>(resolve => {
            const sql = "DELETE FROM feature WHERE feature_id = ?;";
            this.db.execute(sql, [featureId])
                .then(async result => {
                    const deleteInfo: any = result[0];
                    const deletedRowCount: number = +(deleteInfo?.affectedRows);

                    if (deletedRowCount === 1) {
                        resolve({
                            errorCode: 0,
                            errorMessage: "One record deleted."
                        });
                    } else {
                        resolve({
                            errorCode: -1,
                            errorMessage: "This record could not be deleted because it does not exist."
                        });
                    }
                })
                .catch(error => {
                    if (error?.errno === 1451) {
                        resolve({
                            errorCode: -2,
                            errorMessage: "This record could not be deleted beucase it has subcategories."
                        });
                        return;
                    }

                    resolve({
                        errorCode: error?.errno,
                        errorMessage: error?.sqlMessage
                    });
                })
        });
    }
}

export default FeatureService;