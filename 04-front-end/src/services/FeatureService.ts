import api from "../api/api";

export default class FeatureService {
    public static editFeature(featureId: number, newName: string): Promise<boolean> {
        return new Promise<boolean>(resolve => {
            api("put", "/feature/" + featureId, "administrator", { name: newName })
            .then(res => {
                if (res.status !== "ok") return resolve(false);
                if (res.data?.errorCode !== undefined) return resolve(false);
                resolve(true);
            })
        });
    }

    public static deleteFeature(featureId: number): Promise<boolean> {
        return new Promise<boolean>(resolve => {
            api("delete", "/feature/" + featureId, "administrator")
            .then(res => {
                if (res.status !== "ok") return resolve(false);
                if (res.data?.errorCode !== undefined) return resolve(false);
                resolve(true);
            });
        });
    }
}