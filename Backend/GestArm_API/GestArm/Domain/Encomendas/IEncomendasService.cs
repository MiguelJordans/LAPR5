﻿namespace GestArm.Domain.Encomendas;

public interface IEncomendasService
{
    Task<EncomendaDto> GetByIdAsync(EncomendaId id);
    Task<EncomendaDto> AddAsync(CreatingEncomendaDto dto);
    Task<bool> RemoveAsync(EncomendaId id);

    Task<EncomendaDto> UpdateAsync(EncomendaId id,CreatingEncomendaDto dto);
    Task<List<EncomendaDto>> GetAllAsync();
}