import {Caminho} from "../../domain/caminho/caminho";
import {CaminhoId} from "../../domain/caminho/caminhoId";
import ICaminhoArmazemChegadaId from "../../dto/caminho/ICaminhoArmazemChegadaIdDTO";
import {Repo} from "../../core/infra/Repo";
import {Result} from "../../core/logic/Result";

export default interface ICaminhoRepo extends Repo<Caminho> {
    //removeByRoleIds (roles: RoleId[]): Promise<any>
    async

    save(caminho: Caminho): Promise<Caminho>;

    findByDomainId(caminhoId: CaminhoId | string): Promise<Caminho>;

    getAllCaminhos();

    getByArmazemPartidaId(string): Promise<Result<Array<Caminho>>>;

    getByArmazemChegadaId(ICaminhoArmazemChegadaId): Promise<Result<Array<Caminho>>>;


    save(caminho: Caminho): Promise<Caminho>;

    //findByIds (rolesIds: RoleId[]): Promise<Role[]>;
    //saveCollection (roles: Role[]): Promise<Role[]>;

    delete(caminhoId: CaminhoId): Promise<boolean>;

    update(caminho: Caminho): Promise<Result<Caminho>>;
}